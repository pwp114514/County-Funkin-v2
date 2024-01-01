using System.Diagnostics;
using System.Net;
using System.IO;
using System.IO.Compression;

namespace Updater
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            WebClient clientG = new WebClient();
            string latestVersion = clientG.DownloadString("https://drive.google.com/uc?export=download&id=1w2z0slBjEQhNVL0fprnRpKP83HvnNO3M");
            if (File.Exists(Application.StartupPath + "\\_curVer.txt"))
            {
                if (latestVersion == File.ReadAllText(Application.StartupPath + "\\_curVer.txt"))
                {
                    if (MessageBox.Show("You're already running on the latest version of County Funkin'!", "Latest!", MessageBoxButtons.OK, MessageBoxIcon.Information, MessageBoxDefaultButton.Button1, MessageBoxOptions.DefaultDesktopOnly) == DialogResult.OK)
                        Application.Exit();
                    return;
                }
            }

            if (Directory.Exists(Application.StartupPath + "\\bin"))
                Directory.Delete(Application.StartupPath + "\\bin", true);
            if (File.Exists(Application.StartupPath + "\\CountyFunkin.zip"))
                File.Delete(Application.StartupPath + "\\CountyFunkin.zip");
            File.WriteAllText(Application.StartupPath + "\\_curVer.txt", latestVersion);

            WebClient clientD = new WebClient();
            clientD.DownloadProgressChanged += changeProgressBar;
            clientD.DownloadFileCompleted += closeApp;
            clientD.DownloadFileAsync(new Uri("https://drive.google.com/uc?export=download&id=1CL0WrBymlsO-srpXMNm9mn2_8P9zDpg0&confirm=t&uuid=e3c1bacb-c433-4fbe-b3ea-c7cf7a89360f&at=AB6BwCBmwZ3zyMFV-_2I7ztTgaPg:1693901598661"), "CountyFunkin.zip");
        }

        private void closeApp(object? sender, System.ComponentModel.AsyncCompletedEventArgs e)
        {
            ZipFile.ExtractToDirectory(Application.StartupPath + "\\CountyFunkin.zip", Application.StartupPath);
            File.Delete(Application.StartupPath + "\\CountyFunkin.zip");
            if (MessageBox.Show("County Funkin' has finished updating!", "Finished!", MessageBoxButtons.OK, MessageBoxIcon.Information, MessageBoxDefaultButton.Button1, MessageBoxOptions.DefaultDesktopOnly) == DialogResult.OK)
                Application.Exit();
        }

        private void changeProgressBar(object sender, DownloadProgressChangedEventArgs e)
        {
            downloadProgress.Value = e.ProgressPercentage;
        }
    }
}