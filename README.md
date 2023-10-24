## Banner Extension
1.  On the GTVSQPR page, create a Process Rule Code.
    
    Created extensions -  PPI_EXTENSIONS, PPI_IMAGE, ANK_IMAGE_EXTEND

2. On the GTVSQRU page, create a Rule Code.
    
    Created rules code - PPI_Read_Code, PPI_Read, PPI_UPDATE, PPI_WRITE

3. On the GTVSQPA page, create a GUID_LIST parameter of the CHARACTER type.
    
    Already present

4. On the GORSQPA page, associate the GUID_LIST parameter code with process code.
    
    Associated PPI_Extension to GUID_LIST

5. Include as many columns as required but ensure that one of the columns is referenced with the GUID name.
    
    Done

6. SQL Query in GORRSQL page
    
    Associated PPI_Extension to PPI_Read
    Read query Read.sql validated

## Configure the API
7. Add an extension code - Use the Postman utility and call a POST \IntegrationApi\api\extension-codes
    
    Read query Read.sql validated
8. Call a GET to view the code.
    
    Done
9. Create Extensions definitions
    
    Done with id=125
10. Extension versions enable the extension by connecting the extension code to a data model release version.
    
    Done
11. Create the extension version - Use POST \IntegrationApi\api\extension-versions
    
    Done with id=120

