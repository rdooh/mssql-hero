'use strict';

module.exports = function (grunt) {
  // show elapsed time at the end
  require('time-grunt')(grunt);
  // load all grunt tasks
  require('load-grunt-tasks')(grunt);

  grunt.initConfig({
    
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
      coffee: {
        src: ['src/**/*.coffee']
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
