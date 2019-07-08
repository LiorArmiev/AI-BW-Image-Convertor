using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Net.Http;
using System.Net;
using Microsoft.WindowsAzure.Storage.Auth;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Blob;

namespace WebApplicationBW
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string[] BWpicList = Directory.GetFiles(Server.MapPath("~/Files/"), "*.jpg");
            string[] RGBpicList = Directory.GetFiles(Server.MapPath("~/RGBImages/"), "*.jpg");
            if (RGBpicList.Count() > 20 || BWpicList.Count() >20)
            {
                foreach (string f in BWpicList)
                {
                    try
                    {
                        File.Delete(f);
                    }
                    catch
                    {
                    }

                }
                foreach (string f in RGBpicList)
                {
                    try
                    {
                        File.Delete(f);
                    }
                    catch
                    {
                    }

                }
            }
        }

        protected void btnFullPost_Click(object sender, EventArgs e)
        {
            string folderPath = Server.MapPath("~/Files/");
            if (!Directory.Exists(folderPath))
            {
                Directory.CreateDirectory(folderPath);
            }
            long filesize = FileUpload1.FileBytes.Length;
            if (filesize / (1024 * 1024) <= 1)
            {
                error.Visible = false;
                FileUpload1.SaveAs(folderPath + Path.GetFileName(FileUpload1.FileName));

                Image1.ImageUrl = "~/Files/" + Path.GetFileName(FileUpload1.FileName);
            }
            else
            {
                error.Visible = true;
            }

            StorageCredentials storageCredentials = new StorageCredentials("cvtierone", "");

            CloudStorageAccount storageAccount = new CloudStorageAccount(storageCredentials, true);
            CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
            CloudBlobContainer container = blobClient.GetContainerReference("cv-bw-input-images");
            CloudBlockBlob blockBlob = container.GetBlockBlobReference(FileUpload1.FileName);

            string BWImagePath = Server.MapPath(Image1.ImageUrl);
            blockBlob.UploadFromFile(Server.MapPath(Image1.ImageUrl));

            System.Threading.Thread.Sleep(5000);

            CloudBlobContainer containerRGB = blobClient.GetContainerReference("cv-bw-2-color");

            string FileName = FileUpload1.FileName.Split('.')[0];
            string FileEnding = FileUpload1.FileName.Split('.')[1];
            string RGBImageName = FileName + "_RGB." + FileEnding;
            CloudBlockBlob blob = containerRGB.GetBlockBlobReference(RGBImageName);
            string localRGBImagePath = Server.MapPath("~/RGBImages/") + RGBImageName;
            System.IO.FileMode mode = FileMode.Create;
            int i = 0;
            string errorout = "";
            while (i < 30)
                {
                    try
                        {
                            blob.DownloadToFile(localRGBImagePath, mode);
                        }
                    catch (Exception exception)
                        {
                            errorout = exception.ToString();
                        }

                    
                    if (!(File.Exists(localRGBImagePath)))
                    {
                        i++;
                        System.Threading.Thread.Sleep(1000);
                    }
                    else
                    {
                        i = 32;
                    }

                };
            
            Image2.ImageUrl = "~/RGBImages/" + RGBImageName;
            imgtable.Style.Add(HtmlTextWriterStyle.Display, "normal");
        }
        
    }
}