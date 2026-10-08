# MediaElement.js — manual setup guide

**MediaElement.js** (`mediaelement`) plays your local audio and video `file` fields through
the [MediaElement.js](https://www.mediaelementjs.com/) player — a consistent, skinned HTML5
player that works across browsers. It plugs in as two **field formatters** (extending Drupal
core's own file video/audio formatters) plus a small global settings form for choosing where
the player library comes from and its default dimensions.

Set a field to use the **MediaElement video** or **MediaElement audio** formatter on the
entity's *Manage display* tab, and that file field is rendered with the player. Each formatter
adds options such as the HTML `preload` behavior (auto / metadata / none) and an optional
download link with custom text; the video formatter can additionally show a **poster image**
pulled from another image field on the same bundle, at a chosen image style.

The one thing you must decide up front is **where the player library loads from**. On a fresh
install the module is set to **local**, expecting a self‑hosted copy of MediaElement.js at
`/libraries/mediaelement/build` — until you either place the library there or switch the source
to **CDNJS** in the settings form, the players won't actually run. That choice, an "attach
sitewide" switch, and default/override dimensions all live on the module's config form, guarded
by the **Administer mediaelement** permission. The module depends on core's **File** module.

This guide is written for a **human** clicking through the admin UI. If you want the formatter
settings, config keys, permission and theming details for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs.

## Contents

1. [Installation](installation/index.md) — install the module, supply the player library, and
   enable it.
2. [Configuration](configuration/index.md) — the global settings form (library source, sitewide
   attach, dimensions), field by field.

## Where it lives in the admin menu

The global settings form is at **Configuration → Media → MediaElement.js configuration**
(`/admin/config/media/mediaelement/config`), reachable by users with the *Administer
mediaelement* permission. The per‑field player options live on each entity's **Manage display**
tab (`/admin/structure/.../display`), not on the config form.

## How to use it

After setting the library source (see [Configuration](configuration/index.md)), turn on the
player for a field:

1. Go to the **Manage display** tab of the content type (or other entity) that has an audio or
   video `file` field.
2. In the **Format** column, choose **MediaElement video** or **MediaElement audio**.
3. Click the **cog** (⚙) to set the field options:
   - **Preload** — `auto`, `metadata`, or `none` (controls how much loads before play).
   - **Download link** — show a link to download the file, with your own **link text**.
   - **Poster image** (video only) — pick another image field on the same bundle to use as the
     poster, and the **image style** to render it at.
4. Click **Update**, then **Save**. Reload a page showing the field to see the player.
