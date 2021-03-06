import javax.swing.*;
import java.awt.*;
import java.io.*;

class gui extends JFrame{
    public static String time;

    public static void main(String args[]){
	for(;;) {
	    try{
		BufferedReader br = new BufferedReader(new FileReader("score.txt"));
		String str = br.readLine();
		System.out.println(str);
		int num = Integer.parseInt(str);
		if(num != 0) {
		    time = str;
		    break;
		}
		
		br.close();
	    }catch(IOException e){
		System.out.println(e);
	    }
	}

	gui frame = new gui("RESULT");
	frame.setSize(1000, 1000);
	frame.setLocationRelativeTo(null);
	frame.setVisible(true);
    }

    gui(String title){
	setTitle(title);
	setBounds(100, 100, 300, 250);
	setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

	JPanel p1 = new JPanel();
	p1.setBackground(Color.BLUE);
	p1.setPreferredSize(new Dimension(100, 50));
	JPanel p2 = new JPanel();
	p2.setBackground(Color.ORANGE);
	p2.setPreferredSize(new Dimension(100, 50));

	JLabel label1 = new JLabel("TIME :" +time+ " sec");
	label1.setHorizontalAlignment(JLabel.CENTER);
	label1.setFont(new Font("Century", Font.BOLD, 110));

	Container contentPane = getContentPane();
	contentPane.add(label1, BorderLayout.CENTER);
	contentPane.add(p1, BorderLayout.NORTH);
	contentPane.add(p2, BorderLayout.SOUTH);
    }
}
