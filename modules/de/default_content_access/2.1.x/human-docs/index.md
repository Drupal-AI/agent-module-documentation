# Default Content Access — manual setup guide

**Default Content Access** (`default_content_access`) is a small add‑on that makes
the **Default Content** and **Content Access** modules work together. Default
Content lets you export nodes (and other content) to files so they can be shipped
inside a recipe or install profile and imported into a fresh site. Content Access
lets you set per‑node and per‑content‑type view/edit/delete permissions. On their
own, when you export content with Default Content, those Content Access permission
settings are *left behind*. This module fills that gap: when Default Content
exports and imports nodes, it also **exports and imports their Content Access
settings**, so the access rules travel with the content.

That makes it a **developer / devops helper** for anyone distributing content as
part of a recipe or install profile who wants the access configuration reproduced
automatically on import — rather than re‑applying it by hand on every new site.

It is worth being precise about what it does and does not do. This module does **not
itself decide access** at runtime — that remains the job of the Content Access
module. What it does is **serialize** the Content Access settings so they are
reproduced on import. Because you are effectively distributing access configuration,
review the exported settings before you ship them, so you do not accidentally
publish content with the wrong permissions baked in. The module has no runtime
access‑control role of its own and lives in the **Web services** package.

> **Heads up:** the module's documentation notes that, for now, the
> `default_content` module needs to be patched with two issues
> ([#2640734] and [#2698425]) for export/import to work fully. Check the project
> page for the current status before relying on it in production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (with Default
   Content and Content Access) and enable it.

This module has **no settings form**. It works automatically as part of the Default
Content export/import process, and the access rules themselves are configured in the
**Content Access** module — so there is no separate Configuration section in this
guide.

## Where it lives in the admin menu

Default Content Access adds no configuration page of its own. You set the access
rules in the **Content Access** module (per content type at
**Structure → Content types → *(type)* → Access control**, and per node on each
node's **Access control** tab), and you run exports/imports through **Default
Content** (typically via Drush). This module simply ensures the Content Access
settings are included in that export/import.
