module Testzed
  class Schema
    def initialize(schema_string)
      @tree = parse schema_string
    end

    private

    def parse(schema_string)
      tree = {definitions: {}}
      current_definition = nil
      schema_string.each_line do |line|
        case line
        when /^\s*definition\s(?<name>\w+)\s\{\}$/
          tree[:definitions][$~[:name].to_sym] = {}
        when /^\s*definition\s(?<name>\w+)\s\{$/
          current_definition = $~[:name].to_sym
          tree[:definitions][current_definition] = {}
        when /^\s*relation\s(?<name>\w+):\s(?<target>\w+)$/
          tree[:definitions][current_definition][:relations] ||= {}
          tree[:definitions][current_definition][:relations][$~[:name].to_sym] = {target: $~[:target].to_sym}
        when /^\s*relation\s(?<name>\w+):\s(?<target>\w+)\#(?<relation>\w+)$/
          tree[:definitions][current_definition][:relations] ||= {}
          tree[:definitions][current_definition][:relations][$~[:name].to_sym] = {target: $~[:target].to_sym, relation: $~[:relation].to_sym}
        when /^\s*permission\s(?<name>\w+):\s(?<target>\w+)$/
          tree[:definitions][current_definition][:permissions] ||= {}
          tree[:definitions][current_definition][:permissions][$~[:name].to_sym] = {target: $~[:target].to_sym}
        end
      end
      tree
    end
  end
end
