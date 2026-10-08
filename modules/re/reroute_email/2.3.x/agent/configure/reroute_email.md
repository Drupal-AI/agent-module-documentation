# Configure rerouting — `reroute_email.settings`

Settings form at `/admin/config/development/reroute_email` (route `reroute_email.settings`,
permission `administer reroute email`). Test form at `/admin/config/development/reroute_email/test`
(route `reroute_email.test_email_form`). All behavior is stored in the single config object
`reroute_email.settings` (schema: `config/schema/reroute_email.schema.yml`).

## Settings keys

| Key | Type | Default | Meaning |
|---|---|---|---|
| `enable` | boolean | `false` | Master switch — reroute outgoing mail when `true` |
| `address` | string | *(unset → falls back to `system.site` mail)* | Destination address(es) for rerouted mail. If it resolves to an **empty string**, mail is **aborted** instead of sent |
| `allowed` | string | `''` | Allowlist — addresses/domains/patterns that pass through un-rerouted (e.g. `foo@bar.com, *@example.com, name+*@ex.com`) |
| `roles` | sequence | `{}` | Role IDs whose users' mail is exempt from rerouting |
| `mailkeys` | string | `''` | Reroute **only** these module names / mail keys (all others pass through) |
| `mailkeys_skip` | string | `''` | Reroute everything **except** these module names / mail keys |
| `description` | boolean | `true` | Prepend an explanatory block (original To/Cc/Bcc, site URL, mail key) into the rerouted email body |
| `message` | boolean | `true` | Show a Drupal status message when a mail is rerouted/aborted |

Lists (`address`, `allowed`, `mailkeys`, `mailkeys_skip`) are split on any mix of spaces,
commas, semicolons, or newlines. Allowlist entries containing `*` become patterns
(`*` matches one address part). Recipients that fail email validation, and messages where
**all** recipients are invalid, are rerouted.

## Configure via drush

```bash
drush config:set --input-format=yaml reroute_email.settings enable true -y
drush config:set reroute_email.settings address "qa@example.com" -y
drush config:set reroute_email.settings allowed "*@example.com" -y
drush config:set reroute_email.settings address "" -y   # empty ⇒ abort all outgoing mail
```

## Override in settings.php (per-environment)

Recommended pattern — enable on test, disable on production:

```php
// settings.php on the TEST environment:
$config['reroute_email.settings']['enable'] = TRUE;
$config['reroute_email.settings']['address'] = 'your.email@example.com';

// settings.php on the LIVE environment:
$config['reroute_email.settings']['enable'] = FALSE;
```

Other overridable keys mirror the table above: `allowed`, `roles` (array), `mailkeys`,
`mailkeys_skip`, `description`, `message`.

## Test email form

`/admin/config/development/reroute_email/test` sends a message to the To/Cc/Bcc you enter
(mail id `reroute_email_test_email_form`) so you can confirm rerouting/aborting works.
