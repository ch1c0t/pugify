through = require 'through2'
pug = require 'pug'

module.exports = (file) ->
  if /\.pug$/.test file
    through (buffer, _encoding, next) ->
      try
        string_of_js_function = pug.compileClient buffer.toString 'utf8'
        module_body = "#{string_of_js_function}\n\nmodule.exports = template;"
        @push module_body
      catch error
        @emit 'error', error
        return
      next()
  else
    through()
