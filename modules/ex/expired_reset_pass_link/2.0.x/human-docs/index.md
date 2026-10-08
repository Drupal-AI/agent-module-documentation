# Expired Reset Pass Link — manual setup guide

**Expired Reset Pass Link** (`expired_reset_pass_link`) gives you control over how
long a password‑reset (one‑time login) link stays valid. Out of the box, Drupal
hard‑codes that window at 24 hours — a reset link a user requests remains usable
for a full day. This module surfaces that timeout as an editable setting on the
account settings page, so you can shorten (or lengthen) it to suit your site's
security posture.

Why it matters: a password‑reset link is effectively a temporary key to an
account. The longer it stays valid, the wider the window in which a leaked or
forwarded link — sitting in an inbox, a log, or a forwarded email — could be
abused. Tightening the timeout to, say, an hour narrows that window considerably
while still giving legitimate users time to click through. It's a small, focused
security‑hardening setting.

The module has no dependencies of its own and supports Drupal 10, 11, and 12. It
simply exposes a value that core already understands, so there's nothing exotic
going on under the hood — it just makes a previously code‑only setting editable in
the UI.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — set the reset‑link timeout on the
   account settings page (or in `settings.php`).

## Where it lives in the admin menu

After enabling, the new **password‑reset link timeout** setting appears on the
account settings page at **Configuration → People → Account settings**
(`/admin/config/people/accounts`). See [Configuration](configuration/index.md).
