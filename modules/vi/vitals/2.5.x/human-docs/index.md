# Vitals — manual setup guide

**Vitals** (`vitals`) exposes a Drupal site's health as a single JSON document
at a token-protected URL, so an external monitoring service can poll it. The
payload reports the Drupal core version, the PHP version, the active default and
admin themes, and any pending or security updates (pulled from core's Update
module). Point an uptime checker, a CI/CD gate, or a fleet dashboard at the URL
and you get machine-readable status without anyone logging into the admin UI.

The endpoint lives at `/vitals/{token}`, where `{token}` is a 128-character
random secret. Vitals compares the token in the URL to the stored one in a
timing-safe way and wraps the check in Drupal's flood control (10 attempts per
IP per hour), so the URL is hard to brute-force. A failed or missing token
returns either a 404 (the default, which hides that the endpoint exists at all)
or a 403 — your choice. You generate and rotate the token from the settings
form, and you can choose which of the health checks appear in the payload.

Vitals is also extensible: it defines a `vitals_check` plugin type, so a custom
module can add its own health metric (queue depth, last cron run, anything
JSON-serialisable) that then shows up alongside the built-in checks.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — generating the token, choosing the
   403-vs-404 behaviour, and picking which checks are exposed.

## Where it lives in the admin menu

The settings form sits at **Configuration → Web services → Vitals**
(`/admin/config/services/vitals`) and needs the **Administer vitals**
permission. The health endpoint itself is `/vitals/{token}` and is meant to be
called by machines, not browsed by admins.
