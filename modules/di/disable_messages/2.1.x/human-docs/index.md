# Disable Messages — manual setup guide

**Disable Messages** (`disable_messages`) lets a site administrator suppress
specific Drupal status, warning, and error messages so end users never see them.
Drupal core prints every message added by a module — "Article X has been
created.", "The changes have been saved.", and so on — but many of those are noise
for visitors. This module filters them out just before they render.

You list the messages to hide, one per line, in a textarea on the settings form.
Each line is treated as a **regular expression** matched against the whole
message, so you use `.*` as a wildcard — for example `Article .* has been
created.` catches every "created" confirmation regardless of the title. On top of
the pattern list, you can limit filtering to (or exclude) specific pages, exempt
certain user IDs, strip HTML before matching, and — with permission checking on —
hide whole message *types* from roles that lack the matching "view messages"
permission. A debug mode can dump which messages were filtered, and why, at the
bottom of the page while you tune your patterns.

Everything lives in a single configuration object, so your curated blocklist
travels with your exported config across environments. There are no entities,
plugins, services, or Drush commands — just one settings form and a small set of
permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form and permissions,
   field by field.

## Where it lives in the admin menu

The settings form is at **Configuration → Development → Disable messages**
(`/admin/config/development/disable-messages`), gated by the **Administer disable
messages** permission.

## How to use it

Enable the module, open the settings form, add one regular‑expression pattern per
line for each message you want to hide, and save. See
[Configuration](configuration/index.md) for the full set of options and how the
patterns work.
