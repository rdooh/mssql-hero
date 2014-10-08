var SQL, exports, _ints, _processAll, _processInts, _processVarChars, _varchars;

SQL = require("mssql");

_varchars = [];

_ints = [];

_processVarChars = function(ps) {
  var varchar, _i, _len;
  for (_i = 0, _len = _varchars.length; _i < _len; _i++) {
    varchar = _varchars[_i];
    ps.input(varchar[0], SQL.VarChar(varchar[1]));
  }
};

_processInts = function(ps) {
  var int, _i, _len;
  for (_i = 0, _len = _ints.length; _i < _len; _i++) {
    int = _ints[_i];
    ps.input(int, SQL.Int());
  }
};

_processAll = function(ps) {
  _processInts(ps);
  _processVarChars(ps);
};

exports = module.exports = function(config) {
  return function(req, res, next) {
    if (!req.Hero) {
      req.Hero = {};
    }
    req.Hero.mssqlHero = {
      AddVarChar: function(key, length) {
        _varchars.push([key, length]);
      },
      AddInt: function(key) {
        _ints.push(key);
      },
      InputVarChar: function(key, length) {
        this._ps.input(key, SQL.VarChar(length));
      },
      InputInt: function(key) {
        this._ps.input(key, SQL.Int());
      },
      query: function(query, params, success, fail) {
        SQL.connect(config, (function(_this) {
          return function(err) {
            var ps;
            if (err) {
              console.log(err);
            }
            ps = new SQL.PreparedStatement();
            _processAll(ps);
            ps.prepare(query, function(err) {
              if (err) {
                console.log(err);
              }
              ps.execute(params, function(err, recordset) {
                if (err) {
                  console.log(err);
                }
                ps.unprepare(function(err) {
                  if (err) {
                    console.log(err);
                  }
                  success(recordset);
                });
              });
            });
          };
        })(this));
      }
    };
    return next();
  };
};
