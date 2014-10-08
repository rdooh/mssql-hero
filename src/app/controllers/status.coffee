status = require("express").Router()
jsonResponse = require("./../heros/jsonResponseHero.js")()

status.use (req, res, next)->
  console.log("Status requested by "+req.Hero.response.metaData.ip) 
  next()
  return


.get '/', (req, res, next) ->
  req.Hero.response.metaData.success = true
  jsonResponse.send req, res, next
  next()
  return


.get '/error', (req, res, next) ->
  req.Hero.response.metaData.success = false
  req.Hero.response.metaData.message = "there has been an error"
  jsonResponse.send req, res, next
  next()
  return


# GET status
module.exports = status
