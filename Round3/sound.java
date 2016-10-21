import javax.sound.sampled.AudioFormat;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.Clip;
import javax.sound.sampled.DataLine;
import java.io.*;

public class sound {

  public static void main(String[] args) throws Exception {
    int flag = 0;

    for(;;) {
      flag = 0;

      try{
        File file = new File("sound_on.txt");
        FileReader filereader = new FileReader(file);

        int ch = filereader.read();
        // start_touch.wav
        if(ch == 49) {
          flag = 1;
          System.out.println(ch);
        }
        else if(ch == 50) {
          // start.wav
          flag = 2;
          System.out.println(ch);
        }
        else if(ch == 51) {
          // pinpon.wav
          flag = 3;
          System.out.println(ch);
        }
        else if(ch == 52) {
          // levelup.wav
          flag = 4;
          System.out.println(ch);
        }
        else if(ch == 53) {
          // yooo.wav
          flag = 5;
          System.out.println(ch);
        }
        else if(ch == 54) {
          // batu.wav
          flag = 6;
          System.out.println(ch);
        }
      }catch(FileNotFoundException e){
        System.out.println(e);
      }catch(IOException e){
        System.out.println(e);
      }


      try{
        File file = new File("sound_on.txt");
        PrintWriter pw = new PrintWriter(file);

        pw.println(0);

        pw.close();
      }catch(IOException e){
        System.out.println(e);
      }

      if(flag == 1){
        AudioInputStream audioStream = AudioSystem.getAudioInputStream(sound.class.getResourceAsStream("/_music/start_touch.wav"));
        AudioFormat format = audioStream.getFormat();
        DataLine.Info info = new DataLine.Info(Clip.class, format);
        Clip line = (Clip) AudioSystem.getLine(info);
        line.open(audioStream);
        line.start();

        line.drain();
        line.close();

        //System.exit(0);
      }
      else if(flag == 2){
        AudioInputStream audioStream = AudioSystem.getAudioInputStream(sound.class.getResourceAsStream("/_music/start.wav"));
        AudioFormat format = audioStream.getFormat();
        DataLine.Info info = new DataLine.Info(Clip.class, format);
        Clip line = (Clip) AudioSystem.getLine(info);
        line.open(audioStream);
        line.start();

        line.drain();
        line.close();

        //System.exit(0);
      }
      else if(flag == 3){
        AudioInputStream audioStream = AudioSystem.getAudioInputStream(sound.class.getResourceAsStream("/_music/pinpon.wav"));
        AudioFormat format = audioStream.getFormat();
        DataLine.Info info = new DataLine.Info(Clip.class, format);
        Clip line = (Clip) AudioSystem.getLine(info);
        line.open(audioStream);
        line.start();

        line.drain();
        line.close();

        //System.exit(0);
      }
      else if(flag == 4){
        AudioInputStream audioStream = AudioSystem.getAudioInputStream(sound.class.getResourceAsStream("/_music/levelup.wav"));
        AudioFormat format = audioStream.getFormat();
        DataLine.Info info = new DataLine.Info(Clip.class, format);
        Clip line = (Clip) AudioSystem.getLine(info);
        line.open(audioStream);
        line.start();

        line.drain();
        line.close();

        //System.exit(0);
      }
      else if(flag == 5){
        AudioInputStream audioStream = AudioSystem.getAudioInputStream(sound.class.getResourceAsStream("/_music/yooo.wav"));
        AudioFormat format = audioStream.getFormat();
        DataLine.Info info = new DataLine.Info(Clip.class, format);
        Clip line = (Clip) AudioSystem.getLine(info);
        line.open(audioStream);
        line.start();

        line.drain();
        line.close();

        //System.exit(0);
      }
      else if(flag == 6){
        AudioInputStream audioStream = AudioSystem.getAudioInputStream(sound.class.getResourceAsStream("/_music/batu.wav"));
        AudioFormat format = audioStream.getFormat();
        DataLine.Info info = new DataLine.Info(Clip.class, format);
        Clip line = (Clip) AudioSystem.getLine(info);
        line.open(audioStream);
        line.start();

        line.drain();
        line.close();

        //System.exit(0);
      }
      try{
        Thread.sleep(500);
      }catch(InterruptedException e){}
      }
    }

  }
