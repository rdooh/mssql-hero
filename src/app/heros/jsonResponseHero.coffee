#======================================
# jsonResponseHero
#======================================
'use strict'

moment = require("moment")

module.exports = () ->

  #======================================
  # Standard json response with structured data and metadata
  send: (req, res, next)->
  
    Response = req.Hero.response
  
    # Add some date information
    Response.metaData.now = moment()
    Response.metaData.time = Response.metaData.now.format('MMMM Do YYYY, h:mm:ss a')
    Response.metaData.unix = Response.metaData.now.format('X')
    
    if Response.data isnt null and Response.data isnt undefined
      Response.metaData.count = Response.data.length
      Response.metaData.columns = Response.data.columns
    
    
    res.json Response
    res.end()
    console.log "Response sent"
    next()
    return