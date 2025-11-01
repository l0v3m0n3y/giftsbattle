# giftsbattle
telegram mini app api for gifts battle bot nim-lang library
# Example
```nim
import asyncdispatch,giftsbattle,json
waitFor auth("initData")
let data = waitFor get_me()
let me_info=data["user"]
echo me_info["first_name"].getStr()
echo data["balance"]
echo data["telegram_id"]
echo data["telegram_username"].getStr()
echo data["photo_url"].getStr()
```

# Launch (your script)
```
nim c -d:ssl -r  your_app.nim
```
