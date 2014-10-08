#======================================
# HeaderHero
#======================================
'use strict'


module.exports = (req, res, next) ->
  
  # Collect and set initial metaData
  req.Hero = 
    response:
      metaData: 
        ip: req.ip
        user_agent: req.headers["user-agent"]
  
  console.log "HeaderHero run"
  #======================================
  # Set headers and control access
  #======================================
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');
  res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type');
  res.setHeader('Access-Control-Allow-Credentials', true);
  #======================================
  
  # if
  next() # make sure we go to the next routes and don't stop here
  # else, we should kill the connection and return errors, or similar
  
  return
#======================================
