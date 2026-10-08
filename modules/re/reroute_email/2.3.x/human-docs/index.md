# Reroute Email — manual setup guide

**Reroute Email** (`reroute_email`) intercepts every outgoing email your Drupal
site sends and redirects it to one or more predefined test addresses — or aborts
it entirely. It's the standard safety net for **non‑production sites**: when you
clone a live site to staging or a local dev copy, password resets, order
confirmations, and notifications would otherwise go out to real customers.
Reroute Email makes sure they land in your test inbox instead.

Under the hood it uses Drupal's `hook_mail_alter()` (forced to run last) to catch
each message and rewrite its To / Cc / Bcc to the address you configure. If you
leave the destination address empty, mail is **aborted** instead of sent. You can
also **allowlist** addresses, domains, or patterns (like `*@example.com`) so
genuinely internal mail still goes through, exempt users with certain roles, and
filter by mail key so only specific modules' mail is rerouted. Rerouted messages
are logged and get `X-Rerouted-*` headers recording their original recipients,
and a built‑in **Test Email** form lets you confirm the setup works.

All behavior lives in a single `reroute_email.settings` config object, so you can
configure it through the admin form, with Drush, or — the recommended pattern —
per environment in `settings.php` (enabled on test, hard‑disabled on production).
The module has no dependencies. It defines a pluggable rerouting handler type, and
the bundled **`reroute_email_symfony_mailer`** submodule adds a handler for the
Symfony Mailer transport. This is a **release candidate** (2.3.0‑rc2).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and note the optional submodule.
2. [Configuration](configuration/index.md) — the settings form field by field,
   the `settings.php` per‑environment pattern, and the Test Email form.

## Where it lives in the admin menu

- **Settings** — *Configuration → Development → Reroute Email*
  (`/admin/config/development/reroute_email`).
- **Test Email form** — `/admin/config/development/reroute_email/test`, for
  sending a test message to confirm rerouting.

Both are gated by the **Administer reroute email** permission.

## How to use it

On a test or staging site, open the settings form, tick **Enable rerouting**, and
enter the address(es) that should receive the intercepted mail. Optionally
allowlist your own domain and choose roles or mail keys to exempt. Then use the
**Test Email** form to confirm messages are being rerouted. On production, keep
rerouting **disabled** — ideally hard‑set in `settings.php`. See
[Configuration](configuration/index.md) for the details.
