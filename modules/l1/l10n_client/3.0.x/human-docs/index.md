# Localization Client — manual setup guide

**Localization Client** (`l10n_client`) lets translators fix and fill in a site's
**interface translations right on the page they're viewing**. Instead of hunting
for strings in Drupal's bulk translation UI, a translator browses the site in a
non‑English language, opens an on‑page translation pane that lists every interface
string on the current page — translated strings shown green, untranslated ones
white — picks one, and types the translation. It saves straight into Drupal's
local translation store, so corrections happen in context as you notice them.

The functional part of the project is the **`l10n_client_ui`** submodule, which
depends on core **Locale**. Users need the *use localization client ui* permission
to get the on‑page editor, and a settings form lives at **Configuration → Regional
and language → User interface translation → Localization client**, restricted to
language administrators. A separate **`l10n_client_contributor`** submodule adds
the ability to contribute your translations back to a remote localization server
(such as `localize.drupal.org`) using an API key — gated by its own permission.

A few practical notes. This 3.0.x branch is an **alpha** release, so treat it
accordingly. The on‑page pane cannot translate strings through the old **Overlay**
module, so disable Overlay (or open admin pages in new tabs) while translating the
admin interface. And if you use the contributor submodule, its localization‑server
**API key is a secret** — store it in an environment variable rather than
committing it (see [Configuration](configuration/index.md)).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   `l10n_client_ui` submodule (and optionally `l10n_client_contributor`), and set
   permissions.
2. [Configuration](configuration/index.md) — the settings form, the on‑page
   translate permission, and the contributor API key.

## Where it lives in the admin menu

The settings form is at **Configuration → Regional and language → User interface
translation → Localization client**
(`/admin/config/regional/translate/client`), behind the **Administer languages**
permission. Translators use the on‑page pane directly while browsing the site in a
non‑English language.

## How to use it

Switch the site to a non‑English language and browse to a page. Open the
translation pane to see the strings on that page, filter to find a specific one,
and enter or edit its translation — it's saved to the local translation store
immediately. (Tip: you can select text on the page and press **Ctrl + Shift + S**
to search for that string in the client.)
