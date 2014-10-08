#======================================
# All basic requirements
#======================================
app = require("express")()
app.use require("express-error-handler")()
app.use require("body-parser")()
jsonResponse = require("./heros/jsonResponseHero.js")()

#======================================
# End all basic requirements
#======================================




#======================================
# ErrorHandler: middleware to use for all requests
#======================================
# Set up a custom error handler to reduce full crashes
app.use( (err, req, res, next) ->
  console.log "Custom Error Handler"
  console.log(err)
  next(err)
)
#======================================
# End ErrorHandler: middleware
#======================================






#======================================
# Router: middleware to stop when favicon requested
#======================================
app.get "/favicon.ico", (req, res) ->
  res.writeHead 200, 
    'Content-Type': 'image/x-icon'
  res.end()
  return
#======================================
# End Router: middleware
#======================================




#======================================
# Router: middleware to use for all requests
#======================================
# Deal with headers
app.use require("./heros/headerHero.js")
#======================================
# End Router: middleware
#======================================





#======================================
# Load the external Routers
#======================================



#======================================
# !Status
#======================================
app.use "/status", require "./controllers/status.js"
#======================================



# New route test
# this is where we can add some generic first steps, making sure to allow 'next' to pass through
app.use((req, res, next)->
  console.log("Clean-up actions, for ALL calls.") 
  next()
  return
)



#======================================
# Catch-all route
#======================================
# You must complete all other route 'next' calls,
# otherwise this will take over...
app.get( '*', (req, res, next) ->
  # test if headers already sent - if not, send false
  if res.headersSent is false
    req.Hero.response.metaData.success = false
    req.Hero.response.metaData.message = "resource requested is unavailable or doesn't exist"
    jsonResponse.send req, res, next
    
  return
)
#======================================








#======================================
# Start the server
#======================================
app.listen 9090
console.log "App has started on 9090"
#======================================



