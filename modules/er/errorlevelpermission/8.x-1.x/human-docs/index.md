# Error Level Permission — manual setup guide

**Error Level Permission** (`errorlevelpermission`) changes *who* gets to see
on‑screen PHP errors, warnings and notices. Normally Drupal's "Error messages to
display" setting is all‑or‑nothing for everyone; this module overrides that with a
**permission**, so error output can be shown to a trusted role (developers, site
builders, a dedicated debugger role) while ordinary and anonymous visitors never
see it.

Why bother? On‑screen PHP errors can leak sensitive detail — file paths, SQL
fragments, stack traces — that helps an attacker map your site. Gating error
display behind a permission is a small but real piece of information‑disclosure
hardening, and a good complement to setting the site's error‑display level
appropriately for production. The module has no other access‑control role: grant
the "see errors" permission only to people you trust with that detail.

The module is deliberately tiny. It depends only on Drupal core, provides its own
permission, and starts working the moment you enable it and assign the permission —
there is no settings form to fill in.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and assign the permission.

There is **no configuration page** for this module — it has no settings form. All
you do is grant its permission, described below.

## How to use it

Once the module is enabled, decide which roles should see error output:

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Find the permission provided by **Error Level Permission** (the one that lets a
   role see PHP errors/warnings/notices).
3. Tick it **only** for the roles you trust — typically an Administrator or a
   dedicated developer/debugger role. Leave it unchecked for Anonymous,
   Authenticated, and any editor role.
4. Click **Save permissions**.

From then on, users in a permitted role continue to see PHP errors as configured,
while everyone else does not — regardless of the site‑wide error‑display setting.
Pair it with an appropriate production value under **Configuration → Development →
Logging and errors** for defence in depth.
