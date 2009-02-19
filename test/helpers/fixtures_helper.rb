module FixturesHelper
  def fixture(name)
    RESPONSES[name]
  end
end

Test::Unit::TestCase.send(:include, FixturesHelper)