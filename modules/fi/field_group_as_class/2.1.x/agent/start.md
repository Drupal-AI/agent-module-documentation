# Field Group as Class — agent index

Adds one `field_group` **view**-context formatter, `asclass`, that wraps a field group and sets a CSS
class from a chosen `string`/`list_string` field on the same entity. Requires the contrib `field_group`
module. No settings page (`configure` null), no permissions, no Drush.

- **Add the "As Class" group, the `field_class` setting, static classes/id, supported entities** →
  [configure/formatter.md](configure/formatter.md)

Key facts:
- Plugin: `AsClass` (`@FieldGroupFormatter id = "asclass"`, `supported_contexts = {"view"}`,
  `supported_field_types = {"string","list_string"}`).
- Setting `field_class` (config schema `field_group.field_group_formatter_plugin.asclass`) names the field
  whose first value becomes the class; only non-base string/list_string fields on the bundle are offered.
- Render element `field_group_as_class` (`AsClassElement`, `#theme_wrappers = ['container']`) applies
  `#options.attributes.class` (static classes) + `#field_class` (the dynamic value) to the wrapper.
- Works for entity types: node, paragraph, taxonomy_term, block_content.
