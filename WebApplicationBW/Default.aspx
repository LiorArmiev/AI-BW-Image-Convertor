<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplicationBW._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
	        Sys.WebForms.PageRequestManager.getInstance().add_initializeRequest(
		        function() {
                    Sys.WebForms.PageRequestManager.getInstance().add_initializeRequest(
	                    function () {
		                    if (document.getElementById) {
			                    
			                    var blur = document.getElementById('blur');
			                    blur.style.height = document.documentElement.clientHeight;
		                    }
	                    }
                    )
		        }
	        )
</script>
    <script type="text/javascript">
    function ShowProgress()
    {
        document.getElementById('<% Response.Write(UpdateProgress1.ClientID); %>').style.display = "inline";
    }
    </script>
    <script type="text/javascript">
    var prm = Sys.WebForms.PageRequestManager.getInstance();
    prm.add_initializeRequest(InitializeRequest);
    function InitializeRequest(sender, args) {
      if (prm.get_isInAsyncPostBack())
       {
          args.set_cancel(true);
       }
    }
    function AbortPostBack() {
      if (prm.get_isInAsyncPostBack()) {
           prm.abortPostBack();
      }        
    }
    </script>
    <asp:ScriptManager runat="server" ID="ScriptManager1" ></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false">
		<ContentTemplate>
                <div>
                    <asp:Table runat="server">
                        <asp:TableHeaderRow>
                            <asp:TableCell><img src="bw2rgb.png" width="50%" height="50%"/></asp:TableCell>
                            <asp:TableCell><h1>Black &amp; White </h1><h1>to Color Images</h1></asp:TableCell>
                            
                        </asp:TableHeaderRow>
                    </asp:Table>
                    <h3>This small AI project will convert black and white images to color, </h3>
                    <h3>It's been done using OpenCV and Deep Learning</h3>
                    <hr />
                    <h5>Huge thanks to: Adrian Rosebrock, Richard Zhang, Phillip Isola, Alexei A. Efros for the AI resorces</h5>
                    <h5>This is the link for the resorces and information about the deep learning involved: </h5>
                    <h5><a href="http://richzhang.github.io/colorization/">http://richzhang.github.io/colorization/</a></h5>
                    <h5><a href="https://www.pyimagesearch.com/2019/02/25/black-and-white-image-colorization-with-opencv-and-deep-learning/">https://www.pyimagesearch.com/</a></h5>
                   
                </div>
            <p></p>
            <p></p>
                <div>
                    <asp:Table runat="server">
                        <asp:TableHeaderRow>
                            <asp:TableCell>
                    <asp:FileUpload ID="FileUpload1" runat="server" class="btn btn-primary btn-lg" Font-Bold="False" BackColor="White" ForeColor="#428BCA" Width="400px" />
                     <h5>For the purposes of this experiment Image size will be limited to 2MB</h5>
                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:RegularExpressionValidator ID="uplValidator" runat="server" ControlToValidate="FileUpload1"
 ErrorMessage="only JPG/JPEG formats are allowed" ForeColor="Red" 
 ValidationExpression="(.+\.([jJ][pP][gG])|.+\.([jJ][eE][pP][gG]))"></asp:RegularExpressionValidator>
                        </asp:TableCell>
                                </asp:TableHeaderRow>
                            </asp:Table>
                    <asp:Button ID="btnUpload" class="btn btn-primary btn-lg" Text="Colorize" runat="server" OnClick="btnFullPost_Click" OnClientClick="ShowProgress();" Width="400px"/>
                
                    <asp:Label ID="error" Text="File Size is greter then 1MB, please provide a small file." runat="server" Visible="false" Font-Bold="True" ForeColor="Red" Height="16px" style="margin-left: 21px; margin-top: 0px; margin-bottom: 0px"/>
                    <hr />
                    <asp:Table runat="server" class="imgtable" style="display:none;" id="imgtable">
                        <asp:TableHeaderRow>
                            <asp:TableCell Font-Size="Medium" ForeColor="White" BackColor="#428bca" Font-Bold="true" >Original</asp:TableCell>
                            <asp:TableCell Font-Size="Medium" ForeColor="White" BackColor="#428bca" Font-Bold="true">Colorized</asp:TableCell>
                        </asp:TableHeaderRow>
                        <asp:TableRow>
                            <asp:TableCell><asp:Image ID="Image1" runat="server"  Width = "70%" /></asp:TableCell>
                            <asp:TableCell><asp:Image ID="Image2" runat="server"  Width = "70%" /></asp:TableCell>
                        </asp:TableRow>

                    </asp:Table>
                    
                </div>
		</ContentTemplate>

        <Triggers>
                <asp:PostBackTrigger ControlID="btnUpload" />
        </Triggers>
	</asp:UpdatePanel>

    <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
        <ProgressTemplate>         
	        <div id="blur" />
	        <div style="color:white; height: 44px;font-size: 40px; text-align: center; position: absolute; top: 30%; bottom: 50%; width: 100%;" >Deep Learning is now doing it's magic</div>    
	        <div style="color:white; height: 44px;font-size: 40px; text-align: center; position: absolute; top: 50%; bottom: 50%; width: 100%;" >Please Wait...</div>    
            <div style="color:lightcyan; height: 44px;font-size: 30px; text-align: center; position: absolute; top: 70%; bottom: 50%; width: 100%;" >If you think about it, you are asking a computer what was the color of the image</div> 
            <div style="color:lightcyan; height: 44px;font-size: 30px; text-align: center; position: absolute; top: 80%; bottom: 50%; width: 100%;" >It's like asking from a complete stranger try to figure out what was the original color on that day</div> 
        </ProgressTemplate>
    </asp:UpdateProgress>
    
</asp:Content>
