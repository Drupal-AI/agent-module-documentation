# Configure Rules — reaction rules, components, settings

![Reaction Rules list](../../../../../../../screenshots/rules/4.0.x/rules.png)

All UI lives under **Admin → Configuration → Workflow → Rules** (`/admin/config/workflow/rules`).
Config entities export/deploy with `drush config:export`.

## Create a Reaction Rule (event → conditions → actions)

1. Go to `/admin/config/workflow/rules/reactions/add` (route `entity.rules_reaction_rule.add_form`).
2. Give it a **label** and pick one or more **events** (e.g. "After saving a new entity",
   "User has logged in", "Cron maintenance tasks are performed"). Events come from the
   `RulesEvent` plugin manager (defined in `*.rules.events.yml`, some derived per entity type/bundle).
3. Edit the rule (`entity.rules_reaction_rule.edit_form`) and add **conditions** (each a
   `Condition` plugin, e.g. "Data comparison", "Entity is of bundle", "User has role") and
   **actions** (each a `RulesAction` plugin, e.g. "Show a message on the site", "Send email",
   "Add user role"). Conditions may be grouped with AND/OR; actions run in order and can loop.
4. Save. The rule is stored as a `rules_reaction_rule` config entity (config prefix `rules.reaction.*`)
   and fires automatically on the chosen event.

Reaction rule routes (all under `/admin/config/workflow/rules/reactions/...`):
`add`, `edit/{id}`, `delete/{id}`, `enable/{id}`, `disable/{id}` — all require
`administer rules` **or** `administer rules reactions`.

## Reusable logic — Rules Components

A **Rules component** (`rules_component` entity, config prefix `rules.component.*`) is a saved,
parameterized rule/action-set with its own context variables that you invoke from other rules
(as the "Rules component" action) or from code. Manage at
`/admin/config/workflow/rules/components` (`entity.rules_component.collection`); add a rule
component at `/admin/config/workflow/rules/components/add/rule`. Use this to avoid duplicating
the same action chain across many reaction rules.

**Reaction rule vs component:** a `rules_reaction_rule` is bound to events and runs automatically;
a `rules_component` is standalone reusable logic that something else must call.

## Settings — `rules.settings`

Form at `/admin/config/workflow/rules/settings` (route `rules.settings`, permission
`administer rules`). Config object `rules.settings`:

| Key | Default | Meaning |
|---|---|---|
| `system_log.log_level` | `warning` | Level at which rule evaluation errors are logged to the system log |
| `debug_log.enabled` | `false` | Turn on the Rules debug log (trace what fired and why) |
| `debug_log.system_debug` | `false` | Also send debug output to the system log |
| `debug_log.log_level` | `debug` | Level for the debug log channel |

## Permissions (`rules.permissions.yml`)

| Permission | Gates |
|---|---|
| `administer rules` | All Rules configuration and the settings form (full admin) |
| `administer rules reactions` | Reaction rule add/edit/delete/enable/disable |
| `administer rules components` | Rules component add/edit/delete |
| `bypass rules access` | Configure any event/condition/action regardless of per-plugin restrictions (restricted) |
| `access rules debug` | View the Rules debug log |

## Drush commands (`rules:*`)

Provided by `src/Drush/Commands/RulesDrushCommands.php`:

- `drush rules:list [rule|component]` (aliases `rules-list`, `rlst`) — list reaction rules and/or components.
- `drush rules:enable [machine_name]` (`renb`) — enable a reaction rule.
- `drush rules:disable [machine_name]` (`rdis`) — disable a reaction rule.
- `drush rules:delete <machine_name>` (`rdel`) — permanently delete a rule.
