# Custom Login Url — manual setup guide

**Custom Login Url** (`custom_login_url`) moves Drupal's `/user/*` account pages —
including the login form — to a secret base path that you define in `settings.php`.
With it in place, bots hammering the well-known `/user` and `/user/login` endpoints
get a plain **404** instead of a login form, while your staff sign in at a path only
they know, such as `/my_login_url/login`.

This is a lightweight, dependency-free **security-through-obscurity** layer. It has
no admin UI and no configuration entity: the secret path lives entirely in a single
`settings.php` value, so it never appears in exported configuration and can differ
per environment (dev, staging, production). When set, the module relocates every
`/user/*` route behind your prefix, forces the old `/user` canonical to 404 so
scanners can't even confirm a Drupal login exists there, and preserves the normal
login/user page theming at the new path.

Be clear about what it is and isn't: it **hides** the login path, it does not
**harden** authentication. Anyone who learns the secret path reaches the standard
login form. Treat it as one layer on top of real controls — flood/rate limiting,
strong passwords, and two-factor authentication — not a replacement for them.

This guide is written for a **human** operator. If you want terse, token-cheap
references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set your secret login path in
   `settings.php` and rebuild the route cache.

## Where it lives in the admin menu

Nowhere — there is no settings form and no permission. All configuration is the one
`$settings['custom_login_pattern']` value in `settings.php`.

## How to use it

Enable the module, then set your secret path in `settings.php` and run `drush cr`.
Until you set the value, the site behaves normally (the default is the unchanged
`/user/`). See [Configuration](configuration/index.md) for the exact value, the
validation rules, and which routes move.
