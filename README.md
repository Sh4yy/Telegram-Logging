Import the SDK to xcode project \n
Inside The project Import TLLogger \n
Create an TLLogger instance \n
var logger = TLLogger() \n
Setup the instance \n
logger.setup(BOT_KEY: "Bot API Token",CHAT_ID: "Your telegram chat id") \n
And use logger.log("log) to log \n
or add logger.reportNewDownload() to get notified when someone downloads your app. \n
