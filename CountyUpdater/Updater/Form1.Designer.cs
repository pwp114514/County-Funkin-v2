namespace Updater
{
    partial class Form1
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            downloadProgress = new ProgressBar();
            reminderLol = new Label();
            SuspendLayout();
            // 
            // downloadProgress
            // 
            downloadProgress.Location = new Point(12, 38);
            downloadProgress.Name = "downloadProgress";
            downloadProgress.Size = new Size(425, 29);
            downloadProgress.TabIndex = 0;
            // 
            // reminderLol
            // 
            reminderLol.AutoSize = true;
            reminderLol.Location = new Point(94, 9);
            reminderLol.Name = "reminderLol";
            reminderLol.Size = new Size(266, 20);
            reminderLol.TabIndex = 1;
            reminderLol.Text = "County Funkin' is updating. Please wait.";
            // 
            // Form1
            // 
            AutoScaleDimensions = new SizeF(8F, 20F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(447, 75);
            Controls.Add(reminderLol);
            Controls.Add(downloadProgress);
            FormBorderStyle = FormBorderStyle.FixedSingle;
            MaximizeBox = false;
            MinimizeBox = false;
            Name = "Form1";
            ShowIcon = false;
            StartPosition = FormStartPosition.CenterScreen;
            Text = "Updating...";
            Load += Form1_Load;
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private ProgressBar downloadProgress;
        private Label reminderLol;
    }
}