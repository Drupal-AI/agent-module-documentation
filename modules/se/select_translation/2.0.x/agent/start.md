<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Select Translation — agent index

Adds ONE Views filter — plugin id `select_translation_filter` (title "Select translation")
on the `node_field_data` table — that collapses a multilingual node listing to a single
best-matching translation per node. Registered via `hook_views_data_alter()`. No settings
form, no configure route (`configure` is null), no permissions, no config schema, no plugin
types of its own. The same selection algorithm is also exposed as a PHP API function and a
Drush command. Requires `language` + `views`. Installed release is 2.0.0-alpha5 (alpha).

- **Add / configure the filter in a view (modes, priorities, options)** → [plugins/views-filter.md](plugins/views-filter.md)
- **Select a translation in PHP (`select_translation_of_node`, mode syntax)** → [api/functions.md](api/functions.md)
- **Resolve a translation from the CLI** → [drush/commands.md](drush/commands.md)
