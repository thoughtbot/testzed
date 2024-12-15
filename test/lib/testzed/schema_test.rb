require "minitest/autorun"
require_relative "../../../lib/testzed"

class SchemaTest < Minitest::Test
  def test_it_initializes_with_a_schema_string
    schema_string = <<~SCHEMA_ZED
      definition user {}
      definition role {
        relation organization: organization
        relation member: user
      }
      definition organization {
        relation system_manager: role#member
        permission manage_system: system_manager
      }
    SCHEMA_ZED

    schema = Testzed::Schema.new(schema_string)
    assert_equal schema.instance_variable_get(:@tree), {
      definitions: {
        user: {},
        role: {
          relations: {
            organization: {target: :organization},
            member: {target: :user}
          }
        },
        organization: {
          relations: {
            system_manager: {target: :role, relation: :member}
          },
          permissions: {
            manage_system: {target: :system_manager}
          }
        }
      }
    }
  end
end
