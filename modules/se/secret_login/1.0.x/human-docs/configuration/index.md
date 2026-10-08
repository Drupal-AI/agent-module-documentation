# Configuration

Secret Login is configured by an administrator in Drupal's configuration: you
define a **secret path**, map it to a **user account**, and optionally use the
one-time **token** flow.

## Create a secret URL

As an administrator, open the module's configuration and create a secret login
entry:

- **Custom path** — the slug that appears in the login URL
  (`/secret-login/access/<custom-path>`). This string is effectively the
  password, so treat it like one (see below).
- **User account** — the account a visitor will be logged in as when they hit the
  path.
- **Active toggle** — a button to enable or disable the entry.
- **Token option** — optionally use the one-time token flow, which issues a login
  URL whose token is valid for about an hour before a new one is generated.

Once saved and active, visiting `/secret-login/access/<custom-path>` logs the
visitor in as the mapped user.

## Good practice

- **Use a long, high-entropy path** — a random string, not a memorable word or
  vanity slug.
- **Disable or delete entries** as soon as you no longer need them, and rotate the
  path if you suspect it has leaked (it can appear in logs and history).
- Consider whether Drupal core's own one-time login link (`drush uli`) or a
  proper SSO module meets your need instead, since those do not expose a reusable
  password-in-the-URL.

## Save and test

After saving an entry, test the path from a private/incognito window with no
session. The path should be treated as a secret credential.
