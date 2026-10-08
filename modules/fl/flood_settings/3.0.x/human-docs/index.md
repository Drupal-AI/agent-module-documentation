# Flood settings — manual setup guide

**Flood settings** (`flood_settings`) gives you a simple admin form for tuning
Drupal's failed‑login flood protection — the limits that temporarily block an IP
address or a username after too many failed login attempts. Drupal core has this
protection built in, but it ships **no UI** for it: the limits live in the
`user.flood` configuration object and are normally only editable through config
import or by hand‑editing `settings.php`. This module puts them behind a
friendly form so a non‑developer admin can adjust them.

The form reads and writes five values of core's `user.flood` config: how many
failed logins are allowed per IP address and over what time window, the same two
limits per username, and a "username only" mode that tracks lockouts per account
regardless of source IP. Attempt counts are offered as a fixed list (1–500) and
time windows as human‑readable intervals (1 minute up to 1 day, plus a "None
(disabled)" option).

That's the whole module — it is a thin editor over core's existing flood
configuration. There is no config schema of its own, no Drush command, and no
plugin; it simply writes core's `user.flood` keys, and your changes take effect
immediately for core's login flood checks. Access is gated by its own **Manage
flood settings** permission, which you can grant to a non‑admin role.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the flood settings form, every
   value it edits, and the permission that guards it.

## Where it lives in the admin menu

The form sits at **Configuration → System → Flood settings**
(`/admin/config/system/flood`), gated by the **Manage flood settings**
permission.
