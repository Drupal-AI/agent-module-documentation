A samlauth submodule that maps arbitrary SAML attributes sent by the IdP onto Drupal user fields, and can also use those attributes to link a SAML login to an existing Drupal account.

---

`samlauth_user_fields` subscribes to samlauth's `USER_SYNC` and `USER_LINK` events to extend the built-in name/email sync with any number of custom attribute→field mappings. Each mapping stores a SAML `attribute_name`, the target `field_name` on the user entity, and an optional `link_user_order` used when matching existing users. Mappings are managed in the UI at **Admin → Config → People → SAML → SAML user fields attribute mapping** (`/admin/config/people/saml/user-fields`), gated by the parent module's `configure saml` permission; all data lives in the `samlauth_user_fields.mappings` config object. On `USER_SYNC` it writes the mapped attribute values onto the account (calling `markAccountChanged()` so samlauth saves once); on `USER_LINK` it can find and link an existing Drupal user by the mapped field values, honouring `link_first_user` (pick the first match when several exist) and `ignore_blocked` (skip blocked accounts). Note a known limitation: for multi-value attributes only the first value is currently used. It requires the `samlauth` module.

---

- Map a SAML `displayName` attribute to the user's real-name field on every login.
- Populate a custom `field_department` from an IdP department attribute.
- Store an employee number or cost centre attribute on a user field.
- Sync a phone number attribute into a Drupal telephone field.
- Fill profile fields (address, job title, office) from SAML claims automatically.
- Keep mapped user fields up to date on each SAML login (re-synced via USER_SYNC).
- Link a first-time SAML login to an existing Drupal account by a mapped field value.
- Match on a unique attribute (e.g. staff ID stored in a user field) to find the right account.
- Use `link_user_order` to control the priority of fields when several could match.
- Pick the first matching account when multiple users match, via `link_first_user`.
- Skip blocked user accounts when linking, via `ignore_blocked`.
- Add, edit and delete attribute→field mappings through the admin UI.
- Deploy attribute-to-field mappings as configuration between environments.
- Extend samlauth's default name/email sync without writing a custom event subscriber.
- Provision new SAML-created users with a full profile from IdP attributes.
- Centralise user-profile data in the IdP and reflect it in Drupal on login.
