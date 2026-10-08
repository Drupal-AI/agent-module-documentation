# Configuration

All of Reroute Email's behavior lives in one config object,
`reroute_email.settings`. You can edit it through the admin form, with Drush, or
per environment in `settings.php`.

## Open the settings form

1. Log in as a user with the **Administer reroute email** permission.
2. Go to **Configuration → Development → Reroute Email**
   (`/admin/config/development/reroute_email`).

## The settings, field by field

- **Enable rerouting** (`enable`, default off) — the master switch. When off,
  nothing is intercepted. When on, all outgoing mail is rerouted according to the
  options below.
- **Rerouting email addresses** (`address`) — where intercepted mail is sent.
  Accepts several addresses separated by commas, spaces, semicolons, or newlines.
  If left empty it falls back to the site email (`system.site`); if it resolves to
  an **empty string**, mail is **aborted** rather than sent — a handy way to block
  all outgoing mail.
- **Skip rerouting for these email addresses** (`allowed`) — an allowlist of
  addresses, domains, or patterns that pass through **unchanged**. Entries with a
  `*` are patterns, for example `*@example.com` (your own domain) or
  `name+*@example.com`.
- **Exempt roles** (`roles`) — mail belonging to users with the selected roles is
  not rerouted.
- **Filter by mail key** — two complementary filters:
  - `mailkeys` — reroute **only** these module names / mail keys; everything else
    passes through.
  - `mailkeys_skip` — reroute everything **except** these module names / mail
    keys.
- **Show a status message** (`message`, default on) — display a Drupal status
  message whenever a mail is rerouted or aborted.
- **Add a description to the email body** (`description`, default on) — prepend an
  explanatory block into the rerouted body listing the original To / Cc / Bcc, the
  site URL, and the mail key, so you can trace where the message was meant to go.

Lists are split on any mix of spaces, commas, semicolons, or newlines. Messages
whose recipients all fail email validation are also rerouted, so nothing is
silently dropped.

## Test Email form

After enabling, go to `/admin/config/development/reroute_email/test` and send a
message to the To / Cc / Bcc you enter. It confirms rerouting (or aborting) is
working as configured.

## Configure with Drush

```bash
drush config:set reroute_email.settings enable true -y
drush config:set reroute_email.settings address "qa@example.com" -y
drush config:set reroute_email.settings allowed "*@example.com" -y
drush config:set reroute_email.settings address "" -y   # empty => abort all outgoing mail
```

## Per‑environment override in settings.php (recommended)

The safest pattern is to control rerouting per environment so production can never
accidentally reroute (or, worse, leak) mail:

```php
// settings.php on the TEST / staging environment:
$config['reroute_email.settings']['enable'] = TRUE;
$config['reroute_email.settings']['address'] = 'your.email@example.com';

// settings.php on the LIVE / production environment:
$config['reroute_email.settings']['enable'] = FALSE;
```

The other keys (`allowed`, `roles`, `mailkeys`, `mailkeys_skip`, `description`,
`message`) can be overridden the same way.

## Per‑message override

Individual messages can force the behavior with a custom header:
`X-Rerouted-Force: TRUE` forces a message to always reroute, and
`X-Rerouted-Force: FALSE` forces it to never reroute — useful for special cases in
custom code.
