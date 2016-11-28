Import the SDK to xcode project 
Inside The project Import TLLogger 
Create an TLLogger instance 
var logger = TLLogger() 
Setup the instance 
logger.setup(BOT_KEY: "Bot API Token",CHAT_ID: "Your telegram chat id") 
And use logger.log("log) to log 
or add logger.reportNewDownload() to get notified when someone downloads your app. 
