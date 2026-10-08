# Configure flags

![Flags list](../../../../../../../screenshots/flag/5.0.x/flags.png)

Flags are config entities `flag.flag.*` (schema `config/schema/flag.schema.yml`). Manage at
`/admin/structure/flags` (route `entity.flag.collection`; add form
`entity.flag.add_form`). Requires `administer flags`.

Key config properties per flag:

| Key | Meaning |
|---|---|
| `id` / `label` | Machine name / human name. |
| `entity_type` | Flaggable entity type (e.g. `node`, `comment`, `user`). |
| `bundles` | Bundles the flag applies to (empty = all). |
| `global` | TRUE = one shared state for the site; FALSE = per-user. |
| `flag_short` / `flag_long` / `flag_message` | Flag link text, description, confirmation message. |
| `unflag_short` / `unflag_long` / `unflag_message` | Unflag equivalents. |
| `unflag_denied_text` | Shown when a user may flag but not unflag. |
| `flag_type` | Id of the Flag Type plugin (see plugins doc). |
| `link_type` | Id of the Action Link plugin (ajax_link, confirm, reload, field_entry). |
| `flagTypeConfig` / `linkTypeConfig` | Nested plugin config. |
| `weight` | Ordering. |

Because flaggings are entities, add fields to them at the flag's *Manage fields* tab
(e.g. a reason field on a "report" flag). Flags are exportable YAML like any config.
`system.action.flag_delete_flagging` provides a bulk delete-flagging action.
