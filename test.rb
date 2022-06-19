all_tests = Dir.glob('**/*_test.rb')
all_tests.each { |test_path| require_relative test_path }
