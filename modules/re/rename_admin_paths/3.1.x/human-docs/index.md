# Rename Admin Paths — manual setup guide

**Rename Admin Paths** (`rename_admin_paths`) replaces the familiar `/admin` and
`/user` prefixes in your site's URLs with custom terms of your choosing — for
example `/admin` → `/backend` and `/user` → `/member`. The two prefixes are
controlled independently, so you can rename one, both, or neither.

People reach for this module for two reasons. The first is light **hardening**:
moving the well‑known Drupal URLs off their defaults makes the site a little harder to
fingerprint and cuts down on the automated bot traffic that hammers predictable paths
like `/user/register` and `/user/login`. The second is **branding**: matching the
backend URL to a client or organization convention. Because Drupal builds admin links
from route names rather than hard‑coded paths, your menus, toolbar, and most links
follow the rename automatically.

It is important to be clear about what this is *not*. Renaming the paths is
**security‑by‑obscurity, not access control** — it hides the default URLs but does
nothing to stop someone who finds the new ones. Treat it as one defense‑in‑depth
layer alongside real permissions and authentication hardening, never as a substitute.
A few hard‑coded paths in some modules and Views‑generated report links won't be
rewritten either.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form's two toggles and
   replacement fields, explained.

## Where it lives in the admin menu

Its settings form sits at **Configuration → System → Rename Admin Paths**
(`/admin/config/system/rename-admin-paths`), gated by a dedicated **Administer path
admin** permission.

## How to use it

Enable the module, open its settings form, tick the prefix (or prefixes) you want to
rename, type a replacement term, and save. The new URLs take effect immediately —
the module rebuilds the router on save and even redirects you to the settings form at
its new address. See [Configuration](configuration/index.md) for the details and the
validation rules. To undo a rename, just untick the toggle and save to restore the
original prefix.
