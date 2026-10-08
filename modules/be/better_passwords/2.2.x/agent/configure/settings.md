# Configure Better Passwords

One config object, `better_passwords.settings`, with three integer keys. Shipped defaults
(`config/install/better_passwords.settings.yml`):

```yaml
length: 8
strength: 3
auto_generate: 1
```

| Key | Type | Default | Meaning |
|---|---|---|---|
| `length` | integer | `8` | Minimum password length in characters. `0`/empty disables the length check. Form description quotes NIST: "≥ 8 characters". |
| `strength` | integer | `3` | Minimum zxcvbn score (0–4). Select options: `4` Strongest, `3` Strong, `2` Moderate, `1` Weak, `0` Do not check strength. `0`/empty disables the strength check. |
| `auto_generate` | integer | `1` | Auto-generate initial passwords for accounts created by an admin. `0` Never, `1` Optional (adds an "Auto-generate password" checkbox on the register form), `2` Required (hides the password fields; a 64-char password is generated). |

## Admin UI

Route `better_passwords.admin_settings` → `/admin/config/people/passwords`
(menu: *Configuration → People → Passwords*), a standard `ConfigFormBase`
(`BetterPasswordsSettingsForm`, form id `better_passwords_settings`). `length` is a number
field; `strength` and `auto_generate` are selects with the options above. Requires the
`administer better passwords` permission.

## Read / set via drush

```bash
drush cget better_passwords.settings                 # show all three keys
drush cget better_passwords.settings strength        # single key

drush cset better_passwords.settings length 12 -y    # require 12 chars
drush cset better_passwords.settings strength 4 -y    # require the strongest score
drush cset better_passwords.settings auto_generate 2 -y  # force auto-generated admin passwords
```

## Config schema

`config/schema/better_passwords.schema.yml` types `better_passwords.settings` as a
`config_object` with three `integer` keys (`length`, `strength`, `auto_generate`) — so the
values are validated integers, not free strings. To deploy the policy, export/import
`better_passwords.settings` like any other simple config.

## Notes

- There is **no** per-role or per-form override — the policy is global and applies to every
  `password_confirm` element on the site.
- `strength: 0` and `length: 0` each turn *only that* check off; you can run length-only or
  strength-only.
