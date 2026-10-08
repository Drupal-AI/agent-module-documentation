# Entity Embed — manual setup guide

**Entity Embed** (`entity_embed`) lets editors drop any Drupal entity — a node,
a media item, a file, a user, a taxonomy term — straight into a rich‑text field
using a CKEditor toolbar button. Instead of re‑uploading an image or copying an
article's HTML, an editor clicks the embed button, picks the entity, and Drupal
inserts a small placeholder. When the page is rendered, Entity Embed's text
filter swaps that placeholder for the fully rendered entity — respecting access
control and cache metadata — so edits to the source entity automatically flow to
every place it is embedded.

The key idea is that each embed is drawn by an **Entity Embed Display** plugin, so
the same entity can appear as a view mode (e.g. "Teaser"), as an image with a
chosen image style, as a file download link, or through a custom renderer. Site
builders create one or more **Embed buttons** that decide which entity type,
which bundles, and which display plugins an editor is allowed to choose — and can
optionally wire in an Entity Browser so editors pick from existing content.

Entity Embed does **not** work the moment you enable it — it needs a little setup:
you create at least one embed button, add that button to a text format's CKEditor
toolbar, and turn on the "Display embedded entities" filter for that format. It
depends on core's **Editor**, **Filter**, and **System** modules plus the contrib
**Embed** module (`drupal/embed`), and it optionally integrates with **Entity
Browser** for selecting existing entities. There are no submodules. It ships
CKEditor 4 and CKEditor 5 integrations and a Twig `{{ entity_embed(...) }}`
function for embedding from templates.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its Embed
   dependency) with Composer, then enable it.
2. [Configuration](configuration/index.md) — create an embed button and turn on
   the filter so editors can start embedding.

## Where it lives in the admin menu

Entity Embed has no single settings page. Its setup happens in two existing admin
areas:

- **Embed buttons** live at **Configuration → Content authoring → Text editor embed
  buttons** (`/admin/config/content/embed/button`), where you create and scope the
  buttons editors will use.
- The **filter** is enabled per text format at **Configuration → Content authoring →
  Text formats and editors** (`/admin/config/content/formats`), where you also drag
  the embed button into the CKEditor toolbar.

See [Configuration](configuration/index.md) for the step‑by‑step.
