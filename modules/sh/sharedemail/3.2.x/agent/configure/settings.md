<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings

Config object: **`sharedemail.settings`** (schema `config/schema/sharedemail.schema.yml`).
Form: `Drupal\sharedemail\Form\SharedEmailSettingsForm` (a `ConfigFormBase`).
Route: `sharedemail.settings_form` → **`/admin/config/people/shared-email`**
(permission `administer shared email`; menu link under People).

## Keys

| Key | Type | Default | Meaning |
|---|---|---|---|
| `sharedemail_msg` | text | a long default warning (see below) | Warning shown after saving an email already used by another user. Only displayed to users with `access shared email message`. |
| `sharedemail_allowed` | string | `''` (empty) | Comma-separated allowlist of email addresses that may be shared. **Empty = any address may be shared.** The uniqueness bypass only applies when the address matches (case-insensitive substring) or the list is empty. |

Default `sharedemail_msg`:
> "The e-mail address you are using, has already been registered on this site by another user. You should be aware that personal information such as password resets will be sent to this address. We strongly recommend changing your registered address to a different e-mail address. …"

## Read / set via Drush

```bash
drush config:get sharedemail.settings
drush config:get sharedemail.settings sharedemail_allowed

# Restrict shareable addresses to two:
drush config:set sharedemail.settings sharedemail_allowed 'team@example.com,info@example.com' -y
# Change the warning message:
drush config:set sharedemail.settings sharedemail_msg 'Heads up: this email is shared with another account.' -y
```

Note: the allowlist match is a case-insensitive `stripos` substring test against the whole allowlist
string, so an entry like `example.com` effectively allows every address at that domain.
