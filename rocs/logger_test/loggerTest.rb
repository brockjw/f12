require 'test/unit'
require '../logger/logger.rb'
require '../configio.rb'

class LoggerTest < Test::Unit::TestCase
	
	def test_log_info
		loggerInfo = Logger.instance
		loggedText = "Info test: #{Random.rand(100000)}"
		loggerInfo.info loggedText
		logFile = File.read("changeme.log")
		assert(logFile.include?(loggedText))
	end
	
	def test_log_warn
		loggerWarn = Logger.instance
		warnText = "Warn test: #{Random.rand(100000)}"
		loggerWarn.warn warnText
		logFile = File.read("changeme.log")
		assert(logFile.include?(warnText))
	end
	
	def test_log_error
		loggerError = Logger.instance
		errorText = "Error test: #{Random.rand(100000)}"
		loggerError.error errorText
		logFile = File.read("changeme.log")
		assert(logFile.include?(errorText))
	end
	
	def test_setConfig
		configIO = ConfigIO.instance
		configIO.read("../config.yml")
		logger = Logger.instance
		logger.setConfig(configIO)
		ioText = "configIO test: #{Random.rand(100000)}"
		logger.info ioText
		configFile = File.read("server.log")
		assert(configFile.include?(ioText))
	end	
	
end
