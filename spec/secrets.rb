require 'YAML'
class Secrets
  def self.get()
    @secrets ||= YAML.load_file('secrets.yml')

  end
end
