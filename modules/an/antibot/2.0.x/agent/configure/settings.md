# Configure protected forms

Config object `antibot.settings` (schema `config/schema/antibot.schema.yml`). UI at
`/admin/config/user-interface/antibot` (route `antibot.settings`, form `AntibotSettingsForm`).
Read/write with `drush config:get antibot.settings` / `drush config:set`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `form_ids` | sequence<string> | `comment_*`, `user_pass`, `user_register_form`, `contact_message_*`, `webform_submission_webform_*` | Form IDs to protect. One per line in the UI; wildcard `*` allowed. |
| `excluded_form_ids` | sequence<string> | `[]` | Form IDs that must never be protected (overrides matches in `form_ids`). |
| `show_form_ids` | bool | `false` | Debug: show every form's ID (and whether Antibot guards it) to users who can access settings. Turn on only temporarily to discover IDs. |

How it works: for each matching form, `antibot_form_alter()` swaps the form action to
`/antibot` and stores a secret key; `js/antibot.js` (library `antibot/antibot.form`) restores
the real action + key on the client, and `antibot_form_validation()` rejects submissions with a
missing/incorrect key. Users with `skip antibot` are never protected.

Example — protect a custom form:
```
drush config:set antibot.settings form_ids.5 my_custom_form -y
```
