# Rollbar — manual setup guide

**Rollbar** (`rollbar`) connects your Drupal site to the
[Rollbar](https://rollbar.com/) error‑tracking and monitoring service, so that
errors are collected and grouped in one dashboard instead of getting lost in the
database log. It reports from both sides of your site: **server‑side**, it plugs
into Drupal's logger and forwards the log messages you choose (PHP errors, warnings,
exceptions) to Rollbar; and **client‑side**, it injects the Rollbar JavaScript
snippet so uncaught browser errors and unhandled promise rejections are reported too.

Everything is driven from a single settings form. You paste in two Rollbar access
tokens — one for the server stream and one for the browser — flip the master
**enabled** switch, and set an **environment** label (like `production` or `staging`)
so your reports are separated per environment. From there you control exactly which
log severities are sent, which noisy logger channels to exclude, and which
sensitive field names to scrub out of reports before they leave your server.

There are a few privacy‑ and noise‑control knobs worth knowing about: **person
tracking** can attach the current user's ID (or, on the "Full" setting, their
username and email — a GDPR consideration the form flags), a **host allow‑list**
restricts client‑side reporting to specific domains, and an **ignored headers** list
lets you switch off reporting for requests carrying a given header (handy for
silencing uptime bots). Nothing is sent to Rollbar until you turn the module on and
supply a token, so it stays quiet on local and dev environments by default.

Because the access tokens are secrets, the recommended approach is to keep them out
of exported configuration and provide them through environment variables via a
`settings.php` override — see [Installation](installation/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and supply your tokens safely.
2. [Configuration](configuration/index.md) — the settings form, field by field.

## Where it lives in the admin menu

Its settings form is at **Configuration → Services → Rollbar**
(`/admin/config/services/rollbar`), reachable by users with the **administer
rollbar** permission.

## How to use it

1. Create a project in your Rollbar account and copy its **server** (`post_server_item`)
   and **client** (`post_client_item`) access tokens.
2. Install and enable the module.
3. Open the settings form, paste in the tokens (or wire them from environment
   variables), set the **environment**, choose the **log levels** to forward, and tick
   **enabled**.
4. Trigger a test error and confirm it shows up in your Rollbar dashboard.

The field‑by‑field walkthrough is in [Configuration](configuration/index.md).
