# Valispace Matlab Toolbox

To install the Valispace Matlab Toolbox download the file ValispaceMatlabToolbox.mlappinstall and install the toolbox via double-click. You can then activate it by clicking the Valispace Toolbox Icon in your Apps Ribbon inside Matlab.

## Usage

Example usage:

```

% 1) Valispace Login
ValispaceInit("https://demo.valispace.com","username","password")

% 2) optional: pull all Valis for faster access or access via name
ValispacePull()

% 3a) get Vali as a struct
3a) ValispaceGetVali("MySat.Mass")

% 3b) get value
3b) ValispaceGetValue("MySat.Mass")

% 4) push value to Valispace
4) ValispacePushValue("MySat.Mass",0)

% 4b) update dataset (x values as first row and y values as second row)
4b) ValispacePushDataset("MySat.Mass", [0,1,2,3,4,5,6; 10,20,30,40,50,60,70])

% get matrix values from matrix ID
5)  ValispaceGetMatrix(217)

% push matrix values
6)  ValispacePushMatrix(217,[2,3;4,5])

% post data through REST API
7)  ValispacePost(url, data)

% get data in json format through REST API
8)  ValispaceGet(url)                       

```

## Contribute

The source files of the toolbox are in the src folder. To contribute to the toolbox, edit those files and create a new package from the ValispaceMatlabToolbox.prj file before submitting a pull request.

## Version

The current version of the Matlab toolbox is 1.3.1