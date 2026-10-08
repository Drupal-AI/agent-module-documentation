<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush integration: `field:create --enum-class`

The module defines **no standalone Drush command**. Instead `src/Drush/EnumFieldHooks.php`
(`class EnumFieldHooks extends DrushCommands`, constructed with `module_handler`) hooks into core
Drush's existing `field:create` command via Drush attributes.

| Hook | Attribute | Effect |
|---|---|---|
| `hookOption()` | `#[CLI\Hook(type: HookManager::OPTION_HOOK, target: 'field:create')]` | Adds an optional `--enum-class` option to `field:create` (only when enum_field is installed). |
| `hookFieldStorage()` | `#[CLI\Hook(type: HookManager::ON_EVENT, target: 'field-create-field-storage')]` | When `--field-type` is `enum_integer` or `enum_string`, injects the resolved value into `settings.enum_class` on the new field storage. |

`getEnumClass()` reads `--enum-class`; if it is unset and the terminal is interactive it prompts
"Enum class" via `$this->io()->ask()`. So the option is what wires the `enum_class` storage setting
(see `../fields/enum-fields.md`) when a field is created from the CLI.

```bash
# Create an enum field non-interactively
drush field:create node article \
  --field-name=field_status \
  --field-label=Status \
  --field-type=enum_string \
  --enum-class='App\Enum\Status'
```

Requires `drush/drush >= 12.0` (composer.json declares `conflict: drush/drush <12.0`). Omitting
`--enum-class` in an interactive shell triggers the prompt; omitting it non-interactively creates
the field with an empty `enum_class` (fill it in later).
