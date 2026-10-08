# Rules actions & tokens

## Action plugins (`src/Plugin/RulesAction/`)

| Plugin id | Class | Purpose |
|---|---|---|
| `apigee_edge_actions_log_message` | `LogMessage` | Logs a message (context: `message`, `level`) to the `apigee_edge_actions` logger channel — category "Apigee". Handy to trace/react in a reaction rule. |
| *(overrides `rules_system_send_email_to_users_of_role`)* | `SystemEmailToUsersOfRole` | Replaces Rules' core "Send email to all users of a role" action to fix parameter upcasting so it works with Apigee entity context. |

Both are used like any Rules action inside a reaction rule triggered by one of the
[Apigee events](../events/events.md).

## Tokens (`apigee_edge_actions.tokens.inc`)

`hook_token_info_alter()` / `hook_tokens()` expose the Apigee entity (and related member/product)
from the triggering event as tokens, so email/log actions can print e.g. the app name, developer
email, team name, or product. This is what the bundled example rules use to compose notification
emails.

## Example rules
The `apigee_edge_actions_examples` submodule installs ready-made reaction rules (config in
`modules/apigee_edge_actions_examples/config/optional/`):
- `notify_site_admins_when_app_is_created`
- `notify_developer_when_adding_a_new_app`
- `notify_developer_when_added_to_a_team`
- `log_a_message_when_team_is_deleted`

Enable it to see working configurations you can clone.
