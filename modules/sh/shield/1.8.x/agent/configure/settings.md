# Settings

Config object `shield.settings` (schema `config/schema/shield.schema.yml`). Form
`Drupal\shield\Form\ShieldSettingsForm` at `/admin/config/system/shield`. Enable: check
**Enable Shield**, set **User**/**Password**, save.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `shield_enable` | bool | false | Master on/off switch. |
| `credential_provider` | string | `shield` | Where credentials come from: `shield` (plain config), `key` (password in a Key entity), `multikey` (user+pass in one Key). |
| `credentials.shield.user` / `.pass` | string | '' | Username/password when provider is `shield`. |
| `credentials.key.user` / `.pass_key` | string | '' | Username + Key entity id holding the password (`key` provider). |
| `credentials.multikey.user_pass_key` | string | '' | Key entity id holding both username & password (`multikey`). |
| `print` | string | `Hello!` | Greeting shown in the browser's Basic Auth dialog. `[user]`/`[pass]` tokens allowed. |
| `debug_header` | bool | false | Add `X-Shield-Status` response header explaining the decision. |
| `allowlist` | string | '' | Newline-separated IPs / CIDR ranges that bypass the shield. |
| `domains` | text | '' | Domain patterns (host) that are publicly accessible. |
| `method` | int | 0 | Path mode: `0` EXCLUDE (listed paths bypass), `1` INCLUDE (only listed paths are protected). |
| `paths` | text | '' | Newline-separated path patterns for the mode above. |
| `http_method_allowlist` | sequence | `[]` | HTTP methods that bypass (e.g. `options` for CORS). |
| `allow_cli` | bool | true | Let CLI (drush) run without prompting. |
| `unset_basic_auth_headers` | bool | true | Strip Basic Auth headers before Drupal so core `basic_auth` doesn't conflict. |

Storing credentials in a **Key** entity (providers `key`/`multikey`) keeps the password out
of exported config — requires the `drupal/key` module. A migration (`shield_settings.yml`)
imports D7 settings.
