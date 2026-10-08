<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# client_config_care Drush commands

`Commands/ClientConfigCareCommands` (extends `DrushCommands`):

| Command | Does |
| --- | --- |
| `client_config_care:generate_fixtures` | Create sample/fixture config blocker entities (testing). |
| `client_config_care:show_all_blockers` | List all current config blockers (name, when, who). |
| `client_config_care:delete_all_blockers` | Remove every config blocker entity. |
| `client_config_care:delete_config_blocker_by_name <name>` | Delete the blocker(s) for a given config name. |
| `client_config_care:is_activated` | Report whether protection is currently active (via `Deactivator`). |

Typical flow: `show_all_blockers` to audit what is protected before a deploy, `delete_config_blocker_by_name` to release a specific item you now want the import to overwrite, `is_activated` to confirm the filter is engaged.
