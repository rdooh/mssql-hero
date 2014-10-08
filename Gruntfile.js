'use strict';

module.exports = function (grunt) {
  // show elapsed time at the end
  require('time-grunt')(grunt);
  // load all grunt tasks
  require('load-grunt-tasks')(grunt);

  grunt.initConfig({

    // Clean Config
    clean: {
      dist: {
        files: [{
          dot: true,
          src: [
            '.tmp',
            'dist/*',
            '!dist/.git*'
          ]
        }]
      },
      server: ['.tmp'],
    },
    
    delay: 300,
    
    
    // Watch Config
    watch: {
      gruntfile: {
        files: '<%= jshint.gruntfile.src %>',
        tasks: ['jshint:gruntfile']
      },
      coffee: {
        files: ['<%= jshint.coffee.src %>'],
        tasks: ['coffee:glob_to_multiple']
      },
      app: {
        files: '<%= jshint.app.src %>',
        tasks: ['jshint:app'],
        options: {
          livereload: true,
          nospawn: true, //Without this option specified express won't be reloaded
          atBegin: true
        }
      },
      test: {
        files: '<%= jshint.test.src %>',
        tasks: ['jshint:test', 'nodeunit']
      }
    },



    // coffeescript processing settings
    coffee: {
      glob_to_multiple: {    
        options: {
          bare: true
        },
        expand: true,
        cwd: 'src/',
        src: ['**/*.coffee'],
        dest: '',
        ext: '.js'
      }
    },
    



    // Hint Config
    jshint: {
      options: {
        jshintrc: '.jshintrc'
      },
      gruntfile: {
        src: 'Gruntfile.js'
      },
      app: {
        src: ['app/**/*.js']
      },
      coffee: {
        src: ['src/**/*.coffee']
      },
      test: {
        src: ['test/**/*.js']
      }
    }

  });

  // Register Tasks
  // Workon
  grunt.registerTask('default', 'Start working on this project.', [
    'watch'
  ]);

  // Restart
  grunt.registerTask('init', 'first, compile coffeescript', [
    'coffee:glob_to_multiple',
    'watch'
  ]);
};
