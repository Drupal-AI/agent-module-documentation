# Publishing options — manual setup guide

**Publishing options** (`publishing_options`) lets you create your own custom
publishing flags for content, alongside the ones Drupal ships with. Out of the
box, core gives every node two boolean toggles — *Promoted to front page* and
*Sticky at top of lists*. This module adds an admin interface where you can
define as many extra on/off flags as you like — a "Featured", "Archived", "Show
in sidebar", or any other simple yes/no marker your editorial team needs.

Each option you create becomes a boolean flag that editors can tick in the
*Promotion options* section of the node add/edit form. You associate each flag
with the content types it should apply to, so a "Featured" flag can appear only
on Articles while an "Archived" flag appears everywhere. The flags are plain
metadata — they don't grant or restrict access on their own; their meaning comes
from how you use them in your theme, Views, or custom logic.

Speaking of Views: the module integrates with the Views module and provides
plugins for fields, filters, and contextual filters, so you can build lists that
show, filter by, or argue on any custom publishing option you create.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create and manage your custom
   publishing options, and wire them to content types.

## Where it lives in the admin menu

Once enabled, the module adds a management screen at **Configuration → Content
authoring → Publishing options**
(`/admin/config/content/publishing-options`). This is where you add, edit, and
remove your custom options. See [Configuration](configuration/index.md) for the
step‑by‑step.
