# Settings

Config object `sophron.settings` (schema `config/schema/sophron.schema.yml`,
`config/schema/sophron.data_types.schema.yml`). UI at `/admin/config/system/sophron`
(route `sophron.settings`, form `Drupal\sophron\Form\SettingsForm`). Read/write with
`drush config:get sophron.settings` / `drush config:set`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `map_option` | int | 0 | Which map backs the manager: MimeMap default map, Drupal core map, or a custom class. |
| `map_class` | string | `''` | Fully-qualified custom map class (when `map_option` selects "custom"). |
| `map_commands` | mapping/sequence | `{}` | Ordered list of map mutation commands (e.g. add/remove a type↔extension mapping) applied when the map initializes. |

The settings form also surfaces mapping **errors** and **gaps** (via
`getMappingErrors()` / `determineMapGaps()`); Sophron reports these through
`hook_requirements` on the status report. Map commands are applied during the
`MapEvent::INIT` event — see [../extend/events.md](../extend/events.md).
