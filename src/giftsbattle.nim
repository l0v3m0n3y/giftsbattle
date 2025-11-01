import asyncdispatch, httpclient, json, strutils

const api = "https://giftsbattle.com/api/v1"
var headers = newHttpHeaders({
    "Connection": "keep-alive",
    "Host": "giftsbattle.com",
    "Content-Type": "application/json",
    "accept": "application/json, text/plain, */*"
  })

proc auth*(initData:string): Future[void] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let json = %* {"init_data": initData}
    let response = await client.post(api & "/auth/webapp/telegram",body = $json)
    let body = await response.body
    headers["Authorization"]= "Bearer " & body.strip().replace("\"", "") 
  finally:
    client.close()

proc get_me*(): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let response = await client.get(api & "/user")
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc get_cases*(offset:int=0): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let response = await client.get(api & "/cases/category_and_cases/?limit=100&offset=" & $offset)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc my_upgrade_items*(offset:int=0): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let response = await client.get(api & "/upgrade/user_items/?limit=50&offset=" & $offset)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc get_contests*(offset:int=0): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let response = await client.get(api & "/contests/?limit=10&offset=" & $offset)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc get_refs*(): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let response = await client.get(api & "/user/get-refs")
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc my_ref_link*(): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let response = await client.get(api & "/user/ref")
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc my_items*(offset:int=0): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let response = await client.get(api & "/user/items?limit=10&offset=" & $offset)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc case_info*(id:string): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let response = await client.post(api & "/cases/" & id & "/limit_information/",body="")
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()
