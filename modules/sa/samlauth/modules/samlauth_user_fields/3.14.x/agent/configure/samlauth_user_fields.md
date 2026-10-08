# Configure SAML attribute → user-field mapping

Manage mappings at **`/admin/config/people/saml/user-fields`** (route
`samlauth_user_fields.list`, permission `configure saml`); add/edit/delete via
`samlauth_user_fields.add` / `.edit` / `.delete`. Everything is stored in the config object
**`samlauth_user_fields.mappings`** (schema: `config/schema/samlauth_user_fields.schema.yml`).

## Config keys

| Key | Type | Meaning |
|---|---|---|
| `field_mappings` | sequence of mappings | Each mapping = `{ attribute_name, field_name, link_user_order }`. |
| `field_mappings[].attribute_name` | string | The SAML attribute name sent by the IdP. |
| `field_mappings[].field_name` | string | The Drupal user entity field to write it to. |
| `field_mappings[].link_user_order` | integer | Priority used when matching an existing user by this field (see USER_LINK). |
| `link_first_user` | boolean | When several users match during linking, link the first one instead of failing. |
| `ignore_blocked` | boolean | Skip blocked accounts when searching for a user to link. |

## How it works

The module is only an event subscriber (`UserFieldsEventSubscriber`, service
`samlauth_user_fields.event_subscriber.user_sync`) on the parent module's events:

- **`SamlauthEvents::USER_SYNC`** → writes each mapped attribute value onto the account and calls
  `markAccountChanged()` so samlauth persists it. Runs for new and existing users.
- **`SamlauthEvents::USER_LINK`** → looks up an existing Drupal user whose field(s) match the
  incoming attribute values (ordered by `link_user_order`, honouring `link_first_user` and
  `ignore_blocked`) and calls `setLinkedAccount()`.

Limitation: for multi-value SAML attributes only the first value is used
(https://www.drupal.org/i/3522489).

There are no plugins or extra permissions; it reuses samlauth's `configure saml`.
