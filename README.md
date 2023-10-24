## Banner Extension
1.  On the ==GTVSQPR== page, create a Process Rule Code.
    <span style="color:blue">Created extensions -  PPI_EXTENSIONS, PPI_IMAGE, ANK_IMAGE_EXTEND</span>
2. On the ==GTVSQRU== page, create a Rule Code.
<span style="color:blue">Created rules code - PPI_Read_Code, PPI_Read, PPI_UPDATE, PPI_WRITE</span>

3. On the ==GTVSQPA== page, create a GUID_LIST parameter of the CHARACTER type.
<span style="color:blue">Already present</span>
4. On the ==GORSQPA== page, associate the GUID_LIST parameter code with process code.
<span style="color:blue">Associated PPI_Extension to GUID_LIST</span>
5. Include as many columns as required but ensure that one of the columns is referenced with the GUID name.
<span style="color:blue">Done</span>
6. SQL Query in ==GORRSQL== page
<span style="color:blue">Associated PPI_Extension to PPI_Read</span>
<span style="color:blue">Read query Read.sql validated</span>

## Configure the API
7. Add an extension code - Use the Postman utility and call a POST \IntegrationApi\api\extension-codes
<span style="color:blue">Read query Read.sql validated</span>
8. Call a ==GET== to view the code.
<span style="color:blue">Done</span>
9. Create Extensions definitions
<span style="color:blue">Done with id=125</span>
10. Extension versions enable the extension by connecting the extension code to a data model release version.
<span style="color:blue">Done</span>
11. Create the extension version - Use POST \IntegrationApi\api\extension-versions
<span style="color:blue">Done with id=120</span>

