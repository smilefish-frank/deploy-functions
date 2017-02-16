
stage=$1;
functionsVersion=$2;
libraryVersion=$3;

echo The stage is $1, the function version is $functionsVersion, the node library version is $libraryVersion

rm -Rf functions-deploy
mkdir functions-deploy
cd functions-deploy

git clone https://github.com/smilefish-frank/google-functions.git

echo cd into google-functions
cd google-functions

git checkout "$functionsVersion"
rm -Rf .git
rm -Rf node_modules
rm -Rf .vscode
rm -Rf logs

echo cd into location
cd location

mkdir node_modules
cd node_modules

echo Copy the $stage config for deployment in node_modules/node-library directory
cp ../../../../config-$stage.js config.js

echo 'Clone the node library version $libraryVersion'
git clone https://github.com/smilefish-frank/node-library.git

echo cd into the node-library
cd node-library

git checkout "$libraryVersion"
rm -Rf .git
rm -Rf node_modules
rm -Rf .vscode
rm -Rf logs

echo cd from node-library
cd ..
pwd

echo cd from node_modules
cd ..
pwd

gcloud config set project brandify-$stage
gcloud alpha functions deploy getLocation --stage-bucket brandify-functions-playground --trigger-topic get-location

echo cd out of the location directory
cd ..
pwd

echo cd from google-functions
cd ..
pwd

echo cd from functions-deploy
cd ..
pwd

rm -Rf functions-deploy
