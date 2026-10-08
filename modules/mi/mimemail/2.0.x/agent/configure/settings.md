# Settings

Config object `mimemail.settings` (schema `config/schema/mimemail.schema.yml`). Form
`Drupal\mimemail\Form\AdminForm` at `/admin/config/system/mimemail` (route
`mimemail.settings`, requires `administer site configuration`).

| Key | Type | Default | Meaning |
|---|---|---|---|
| `name` | string | site name | Sender name for all Mime Mail messages. |
| `mail` | email | site mail | Sender email address. |
| `simple_address` | bool | false | Use bare `user@example.com` (drop display name) for recipients. |
| `sitestyle` | bool | true | Gather the default theme's stylesheets when no `mail.css` exists in the theme dir. |
| `textonly` | bool | false | Convert all messages to plain text (overrides per-user choice). |
| `linkonly` | bool | false | Link images externally instead of embedding them (smaller messages). |
| `user_plaintext_field` | string | '' | Machine name of a boolean field on the User entity; when TRUE for a user they receive plain text only. |
| `format` | string | `full_html` | Text-format used to render the HTML body. |
| `preserve_class` | bool | false | Keep CSS `class` attributes when inlining CSS (only shown with `mimemail_compress`). |
| `advanced.incoming` | bool | false | Process incoming messages posted to the site (advanced; leave off unless you know why). |
| `advanced.key` | string | '' | Validation string for incoming messages. |

Read/write with drush:
```
drush config:get mimemail.settings
drush config:set mimemail.settings textonly true -y
```

The per-user opt-out select only lists **boolean fields attached to the User bundle** — add
one via Field UI first (e.g. `field_plain_text_email`), then choose it here.
