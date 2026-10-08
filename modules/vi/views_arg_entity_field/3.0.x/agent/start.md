<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Arg Entity Field — agent index

One Views `argument_default` plugin, `current_entity_field_value` ("Field value from Current
Entity"), that fills a contextual filter from a field on the entity in the current route.
No settings page (`configure` null), no permissions, no services, no Drush, no plugin types.
Provides a config schema and one update hook.

- **Add it to a contextual filter, the six options (entity type, field, empty value,
  multiple-values handling, separator, delta), route resolution and caching** →
  [configure/argument.md](configure/argument.md)

Key facts:
- Class `CurrentEntityFieldValue` extends `ArgumentDefaultPluginBase`, implements
  `CacheableDependencyInterface` (cache context `url`, max-age PERMANENT, merges the source
  entity's cache tags into the view).
- Current entity = `current_route_match->getParameter(<entity_type_id>)`; only
  content entity types are offered.
- Field is stored as `field_name:property` (main property shown by field name; other
  properties shown as `field:property`). The `entity` computed property is skipped.
- `hook_update_8201` converts a string `single_value_delta` to integer.
