/*
This is Game "LEDG" for Demo.
Round3
*/

#include "Timer.h"
#include "Oscilloscope.h"
#include "TestFtsp.h"
#include "RadioCountToLeds.h"

module OscilloscopeC @safe() {
  uses {
    interface Boot;
    interface SplitControl as RadioControl;
    interface AMSend;
    interface Timer<TMilli> as Timer;
    interface Timer<TMilli> as Timer_count;
    interface Read<uint16_t>;
    interface Leds;
    interface GlobalTime<TMilli>;
    interface TimeSyncInfo;
    interface Packet;
    interface PacketTimeStamp<TMilli,uint32_t>;
  }
}
implementation {
  /* Current local state
  typedef nx_struct oscilloscope {
  nx_uint16_t version;  // Version of the interval.
  nx_uint16_t interval; // Sampling period.
  nx_uint16_t id;       // Mote id of sending mote.
  nx_uint16_t count;    // The readings are samples count * NREADINGS onwards
  nx_uint16_t readings[NREADINGS];
  } oscilloscope_t;
  */

  oscilloscope_t local;
  message_t sendBuf;
  message_t msgBuffer;
  message_t msgBuf;

  uint64_t clear_time = 0;
  uint64_t chill_time = 0;
  uint16_t data[10]   = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};   // Acquired data
  uint8_t  data_num   = 2;      // The number of acquired data

  bool sendBusy = FALSE;

  int counter = 0;
  int time_count = 0;

  //-----------------FUNCTION-----------------

  /* Use LEDs to report various status issues. */
  void report_problem() { call Leds.led0Toggle(); }     // Red
  void report_sent() { call Leds.led1Toggle(); }        // Green
  void report_received() { call Leds.led2Toggle(); }    // Yellow

  /* start Timers */
  void startTimer() {
    call Timer.startPeriodic(local.interval);
    call Timer_count.startPeriodic(1);
  }

  // pushing datas
  void push_data(uint16_t ill_data) {
    for(counter = 8; counter >= 0 ; counter--) {
      data[counter + 1] = data[counter];
    }
    data[0] = ill_data;
  }

  //------------------EVENT-------------------

  event void Boot.booted() {
    local.interval = DEFAULT_INTERVAL;
    local.id = TOS_NODE_ID;

    if(call RadioControl.start() != SUCCESS) report_problem();
  }

  event void RadioControl.startDone(error_t error) {
    startTimer();
  }

  event void RadioControl.stopDone(error_t error) { }

  event void Timer.fired() {
    if(data_num == NREADINGS) {
      if(!sendBusy && sizeof(local) <= call AMSend.maxPayloadLength()) {
        // Don't need to check for null because we've already checked length above
        // "local" gets "acquired data" in this line.
        memcpy(call AMSend.getPayload(&sendBuf, sizeof(local)), &local, sizeof(local));

        if(call AMSend.send(AM_BROADCAST_ADDR, &sendBuf, sizeof(local)) == SUCCESS) sendBusy = TRUE;
      }
      if(!sendBusy) report_problem();

      data_num = 0;
    }

    if(call Read.read() != SUCCESS) report_problem();
  }

  event void Timer_count.fired() {

  }

  event void AMSend.sendDone(message_t* msg, error_t flag) {
    if(flag == SUCCESS) report_sent();
    else                report_problem();

    sendBusy = FALSE;
  }

  event void Read.readDone(error_t result, uint16_t read_data) {
    if(result != SUCCESS) {
      read_data = 0xffff;
      report_problem();
    }

    if(data_num < NREADINGS) {
      local.readings[data_num++] = read_data;
      push_data(read_data);
    }
  }
}
