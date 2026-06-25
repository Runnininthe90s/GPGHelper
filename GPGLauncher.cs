using System.Diagnostics;
using System.IO;
using System.Reflection;
using System;

class Program
{
    static void Main(string[] args)
    {
        try
        {
            string exePath = Assembly.GetExecutingAssembly().Location;
            string exeDir = Path.GetDirectoryName(exePath);
            string ps1Path = Path.Combine(exeDir, "GPGHelper.ps1");

            if (!File.Exists(ps1Path))
            {
                System.Windows.Forms.MessageBox.Show(string.Format("Could not find script: {0}", ps1Path), "Error", System.Windows.Forms.MessageBoxButtons.OK, System.Windows.Forms.MessageBoxIcon.Error);
                return;
            }

            ProcessStartInfo psi = new ProcessStartInfo();
            psi.FileName = "powershell.exe";
            psi.Arguments = string.Format("-ExecutionPolicy Bypass -WindowStyle Hidden -File \"{0}\"", ps1Path);
            psi.CreateNoWindow = true;
            psi.UseShellExecute = false;
            
            Process.Start(psi);
        }
        catch (Exception ex)
        {
            System.Windows.Forms.MessageBox.Show(string.Format("Error launching tool: {0}", ex.Message), "Error", System.Windows.Forms.MessageBoxButtons.OK, System.Windows.Forms.MessageBoxIcon.Error);
        }
    }
}
