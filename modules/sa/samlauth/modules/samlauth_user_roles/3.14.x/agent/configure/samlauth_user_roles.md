# Configure SAML attribute → Drupal role mapping

Edit at **`/admin/config/people/saml/user-roles`** (route
`samlauth_user_roles.configure_form`, permission `configure saml`). Data lives in the config
object **`samlauth_user_roles.mapping`** (schema:
`config/schema/samlauth_user_roles.schema.yml`).

## Config keys

| Key | Type | Meaning |
|---|---|---|
| `saml_attribute` | string | Name of the SAML attribute/claim holding group/role values (e.g. `groups`, `memberOf`). |
| `saml_attribute_separator` | string | If set, splits a single attribute value into multiple values on this delimiter. |
| `value_map` | sequence | Each entry = `{ attribute_value, role_machine_name }` — maps an incoming value to a Drupal role. |
| `default_roles` | sequence of role ids | Roles granted to every SAML user regardless of attributes. |
| `unassign_roles` | sequence of role ids | Roles removed first (before defaults + mapped roles are added), keeping membership in sync. |
| `only_first_login` | boolean | Only adjust roles on the user's first SAML login (leaves later manual edits untouched). |
| `log_unknown` | boolean | Log attribute values / roles that don't resolve to an existing role. |

## How it works

Single event subscriber (`UserRolesEventSubscriber`, service
`samlauth_user_roles.event_subscriber`) on **`SamlauthEvents::USER_SYNC`**:

1. If `only_first_login` and `!$event->isFirstLogin()`, do nothing.
2. Remove `unassign_roles`, then add `default_roles`.
3. Read `saml_attribute` from the event's attributes (split on `saml_attribute_separator` if set),
   look each value up in `value_map`, and add the matching roles (`$account->addRole(...)`).
4. Marks the account changed so samlauth saves it; unknown values are logged when `log_unknown`.

No plugins or own permissions; reuses samlauth's `configure saml`. Note: prepopulated authmap
entries mean "first login" isn't recognised, so `only_first_login` won't act on those users.
