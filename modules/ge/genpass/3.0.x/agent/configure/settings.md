# Configure genpass

All configuration is the single config object **`genpass.settings`**. There is **no
dedicated form** — genpass alters the core Account settings form
(`/admin/config/people/accounts`, route `entity.user.admin_form`), adding three sections.
Defaults live in `config/install/genpass.settings.yml`; the schema
(`config/schema/genpass.schema.yml`) is `FullyValidatable` with range constraints.

## Keys (defaults shown)

| Key | Default | Type / range | Meaning |
|---|---|---|---|
| `genpass_length` | `12` | int 5–32 | Length of generated passwords. |
| `genpass_mode` | `2` | int 0–2 | User password entry on **registration**: `0` required, `1` optional (blank → generated), `2` restricted (always generated, no field). |
| `genpass_admin_mode` | `1` | int 1–2 | Admin creating/editing a user: `1` may set a password, `2` cannot (hidden). |
| `genpass_display` | `0` | int 0–3 | When to show the generated password once: `0` none, `1` admin, `2` user, `3` both. |
| `genpass_override_core` | `true` | bool | Use `GenpassPasswordGenerator` in place of core `DefaultPasswordGenerator` everywhere. |

The integer constants are defined on `Drupal\genpass\GenpassInterface`
(`PASSWORD_REQUIRED/OPTIONAL/RESTRICTED = 0/1/2`, `PASSWORD_ADMIN_SHOW/HIDE = 1/2`,
`PASSWORD_DISPLAY_NONE/ADMIN/USER/BOTH = 0/1/2/3`).

## Interlock with core email verification

A `GenpassMode` constraint ties `genpass_mode` to `user.settings:verify_mail`. When
"Require email verification when a visitor creates an account" is **on**, the registration
form has no password field, so only `genpass_mode: 2` (restricted) is valid — saving `0`/`1`
in that state is rejected by validation.

## Read / set with drush

```bash
# Read the whole object or a single key
drush config:get genpass.settings
drush config:get genpass.settings genpass_length

# Set values (validate against schema on import; config:set writes directly)
drush config:set genpass.settings genpass_length 20 -y
drush config:set genpass.settings genpass_mode 1 -y          # optional entry
drush config:set genpass.settings genpass_display 3 -y       # show to admin + user
drush config:set genpass.settings genpass_override_core true -y
```

Changing settings via the admin form invalidates the `genpass` cache tag (character sets are
cached under cid `genpass:character_sets`, tag `genpass`). After a raw `config:set`, run
`drush cr` (or `drush cache:invalidate:tags genpass`) so cached character sets refresh.
