/*
This is Game "LEDG" for Demo.
*/

import net.tinyos.message.*;
import net.tinyos.util.*;
import java.io.*;
import java.util.*;
import java.text.*;

public class Oscilloscope implements MessageListener
{
  MoteIF mote;
  Data data;
  Window window;

  int interval = Constants.DEFAULT_INTERVAL;
  int version = -1;
  int NREADING = 10;
  int time = 0;
  public static final int THRESHOLD = 30;
  public static int judge = 0;

  /* Main entry point */
  void run() {
    data = new Data(this);
    mote = new MoteIF(PrintStreamMessenger.err);
    mote.registerListener(new OscilloscopeMsg(), this);
  }

  public synchronized void messageReceived(int dest_addr, Message msg) {
    if (msg instanceof OscilloscopeMsg) {
      OscilloscopeMsg omsg = (OscilloscopeMsg)msg;

      if(judge == 1) return;

      /* Update interval and mote data */
      periodUpdate(omsg.get_version(), omsg.get_interval());
      data.update(omsg.get_id(), omsg.get_count(), omsg.get_readings());
      //aida
      int dataint[] =  omsg.get_readings();
      //nagamitsu shows dataint all

      for(int index_num=0;index_num<dataint.length;index_num++){
        System.out.println(omsg.get_id()+"\t"+dataint[index_num++]+"\t"+dataint[index_num]);
      }

      int i;
      if(omsg.get_id() == 7){
        try{
          File file = new File("log_7.txt");
          FileWriter filewriter = new FileWriter(file,true);
          for(i = 0; i < 10; i++) {
            filewriter.write(dataint[i]+ "\n");
            if(dataint[i] < THRESHOLD) break;
          }
          filewriter.close();
        } catch (Exception e){
        }
      }
      else if(omsg.get_id() == 13){
        try{
          File file = new File("log_13.txt");
          FileWriter filewriter = new FileWriter(file,true);
          for(i = 0; i < 10; i++) {
            filewriter.write(dataint[i]+ "\n");
            if(dataint[i] < THRESHOLD) break;
          }
          filewriter.close();
        } catch (Exception e){
        }
      }
      else if(omsg.get_id() == 16){
        try{
          File file = new File("log_16.txt");
          FileWriter filewriter = new FileWriter(file,true);
          for(i = 0; i < 10; i++) {
            filewriter.write(dataint[i]+ "\n");
            if(dataint[i] < THRESHOLD) break;
          }
          filewriter.close();
        } catch (Exception e){
        }
      }
      else if(omsg.get_id() == 21){
        try{
          File file = new File("log_21.txt");
          FileWriter filewriter = new FileWriter(file,true);
          for(i = 0; i < 10; i++) {
            filewriter.write(dataint[i]+ "\n");
            if(dataint[i] < THRESHOLD) break;
          }
          filewriter.close();
        } catch (Exception e){
        }
      }
    }
  }

  void periodUpdate(int moteVersion, int moteInterval) {
    if (moteVersion > version) {
      /* It's new. Update our vision of the interval. */
      version = moteVersion;
      interval = moteInterval;
    }
    else if (moteVersion < version) {
      /* It's old. Update the mote's vision of the interval. */
      sendInterval();
    }
  }

  /* The user wants to set the interval to newPeriod. Refuse bogus values
  and return false, or accept the change, broadcast it, and return
  true */
  synchronized boolean setInterval(int newPeriod) {
    if (newPeriod < 1 || newPeriod > 65535) {
      return false;
    }
    interval = newPeriod;
    version++;
    sendInterval();
    return true;
  }

  /* Broadcast a version+interval message. */
  void sendInterval() {
    OscilloscopeMsg omsg = new OscilloscopeMsg();

    omsg.set_version(version);
    omsg.set_interval(interval);
  }

  /* User wants to clear all data. */
  void clear() {
    data = new Data(this);
  }

  public static void main(String[] args) throws Exception {
    Oscilloscope me = new Oscilloscope();
    LedSocket s = new LedSocket(LedSocket.DEFAULT_HOST, LedSocket.DEFAULT_PORT);
    int r_num = 0;
    int i;

    // Random On
    //for(i = 0 ; int end < 5; i++) {
    //r_num = (int)(Math.random() * 4);
    r_num = 1;
    if(r_num == 1) {
      //s.send( 5, 1000, 100, 100, 100);
      me.run();
      if(judge == 1) {
        //s.send( 5, 100, 100, 1000, 100);
        judge = 0;
        //System.out.println("end");
      }
    }
    else if(r_num == 2) {
      //s.send( 17, 1000, 100, 100, 100);
      me.run();
      //s.send( 17, 100, 100, 1000, 100);
    }
    else if(r_num == 3) {
      //	s.send( 19, 1000, 100, 100, 100);
      me.run();
      //s.send( 19, 100, 100, 1000, 100);
    }
    //}

    s.close();
  }
}
