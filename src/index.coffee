# Require the MSSQL module
SQL = require("mssql")


# Private Functions
_varchars = []

_ints = []

_processVarChars = (ps)->
  for varchar in _varchars
    ps.input varchar[0], SQL.VarChar(varchar[1])
  return

_processInts = (ps)->
  for int in _ints
    ps.input  int, SQL.Int()
  return

_processAll = (ps)->      
  _processInts(ps)
  _processVarChars(ps)
  return


# Run the fail method, if it exists
_fail = (err, fail)->
  if fail and err
    fail(err)
  else if err
    console.log err
  return


exports = module.exports = (config) ->
#   console.log "config added when initiated"
  return (req, res, next) ->
    # console.log "when a request comes in, this is run"
    
    # create the Hero object if it doesn't exist
    # req.Hero = {} if !req.Hero
    # create the connectionHero
    req.mssqlHero =

      AddVarChar: (key, length) ->
        _varchars.push [key,length]
        return

      AddInt: (key) ->
        _ints.push key
        return
      
      # Method that simply performs VarChar prep
      InputVarChar: (key, length) ->
        @._ps.input key, SQL.VarChar(length)
        return
         
      # Method that simply performs VarChar prep
      InputInt: (key) ->
        @._ps.input key, SQL.Int()
        return
      
      # 
      query: (query, params, success, fail) ->
        # console.log "connecting..."
        # global connection
        SQL.connect config, (err) =>
          _fail(err,fail) if err
          # console.log "made connection"
          ps = new SQL.PreparedStatement()
          _processAll(ps)
          ps.prepare query, (err) =>
            _fail(err,fail) if err
            ps.execute params, (err, recordset) =>
              _fail(err,fail) if err
              # console.log "executing"
              
              ps.unprepare (err) =>
                _fail(err,fail) if err
                success(recordset)
                return
              return
            return
          return
        return
    next()    
      