/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package bwdreader;

/**
 *
 * @author xvit
 */
public class Main {


    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
       // System.out.print(args.length);
        if (args.length == 0)
        {
            System.out.println("BWD file reader");
            System.out.println("Author: " + bwdreader.BDWHacker.author);
            System.out.println("Version: " + bwdreader.BDWHacker.version);
            System.out.println("");
            System.out.println("usage:");
            System.out.println("       bdwreader.jar <FILE.BWD> [parameter]");
            System.out.println("");
            System.out.println("parameter");
            System.out.println("  if parameter not enter, then data on screen");

            System.out.println("  -ini");
            System.out.println("  -htmldump");
            System.out.println("  -tab");

        }
        else{
            BDWHacker bdw = new BDWHacker(args[0]);
            if (args.length == 1) bdw.view();

            if (args.length > 1) {
              //  System.out.print("<!-- HTML -->");
                if (args[1].equals("-ini")) bdw.printIni();
                if (args[1].equals("-htmldump")) bdw.printHtmlDump();
                if (args[1].equals("-tab")) bdw.print_tabbed01();
            }



        }
 
        
    }

}
