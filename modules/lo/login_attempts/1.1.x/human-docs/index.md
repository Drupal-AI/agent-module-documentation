# Login Attempts — manual setup guide

**Login Attempts** (`login_attempts`) is a small usability layer over Drupal's
built‑in brute‑force protection. Drupal core already blocks an account
temporarily after too many failed logins (its *flood control*), but it does so
silently — a user just sees another failed attempt with no sense of how close they
are to being locked out. Login Attempts closes that gap by showing a warning on
the login form telling the user **how many failed attempts they've made and how
many remain** before their account is temporarily blocked.

Under the hood it reads core's own flood configuration (`user.flood`) and the core
`flood` table to count the non‑expired failed attempts, then displays a message
along the lines of "you have N failed attempts and can try M more times before
your account will be blocked temporarily." The warning appears once the number of
failed attempts reaches a threshold, so users aren't nagged on a single typo.

Two things are worth being clear about. First, this module **builds on** core
flood control — it does not replace or weaken it. Core still does the actual
blocking at the configured threshold; Login Attempts only surfaces the count.
Second, showing the exact remaining count does give a would‑be attacker feedback
on how close they are to lockout — but because core blocks at the threshold
regardless, this is a small and common trade for clearer feedback to legitimate
users.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no settings form of its own** — Login Attempts reads Drupal core's
flood limits. Tuning those limits is described below.

## How it fits together

Login Attempts has no configuration page. The numbers it displays come straight
from Drupal core's flood settings, so if you want to change *how many* attempts
are allowed or *how long* a lockout lasts, you adjust **core's** flood
configuration, not this module.

Core's login flood limits live in the `user.flood` configuration
(`user_limit`, `user_window`, and the IP‑based limits). They aren't exposed on a
standard admin form, so administrators typically override them in `settings.php`
— for example:

```php
$config['user.flood']['user_limit'] = 5;
$config['user.flood']['user_window'] = 3600;
```

Whatever thresholds you set there are the numbers Login Attempts will count
against and display on the login form. Enable the module, set your flood limits to
taste, and the remaining‑attempts warning appears automatically.
