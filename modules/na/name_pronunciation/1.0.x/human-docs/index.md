# Name Pronunciation — manual setup guide

**Name Pronunciation** (`name_pronunciation`) provides a purpose‑built field type
for capturing and playing back the correct pronunciation of a person's name.
Content editors can record audio straight from their browser's microphone or
upload a pre‑recorded clip, and optionally add a written (phonetic) spelling such
as "CARE‑sun". Visitors then see a simple, accessible speaker button that plays
the pronunciation when clicked.

It solves a real accessibility and inclusivity problem for people‑focused content
— staff directories, author bios, speaker lists, alumni registries, and profile
pages — anywhere a name deserves to be said correctly. The module is fully
self‑contained: it depends only on Drupal core and uses the browser's native
MediaRecorder API for recording, so there are no external libraries to install
and no third‑party services involved.

Under the hood it ships three pieces that work together: a **field type** that
stores an audio file reference plus the optional written pronunciation, a
**recorder widget** for the edit form (record‑in‑browser or upload), and a
**player formatter** that renders the accessible play button on display. It has
no routes, permissions, or settings page — it is a pure field module, so access
is governed entirely by the host entity's normal field access.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — all setup happens on the
field itself, described in "How to use it" below.

## How to use it

You add the field to whichever entity holds people — commonly a user account or a
"Person"/"Staff" content type:

1. Go to **Structure → Content types** (or the user account settings), pick the
   bundle, and open **Manage fields → Add field**.
2. Choose **Name Pronunciation** as the field type and give it a label.
3. In the field settings, configure the allowed audio file extensions (MP3, WAV,
   OGG, and similar) and the maximum recording duration.
4. On **Manage form display**, the field uses the recorder widget: editors get a
   **Record/Stop** button, an **Upload** field, a **Written Pronunciation** text
   field, and a description field. They can preview a recording before saving.
5. On **Manage display**, choose the player formatter and decide whether to show
   the description and written pronunciation, and customize the button text.

When a visitor views the content, they see the speaker button and can click (or
keyboard‑activate) it to hear the name. The player automatically serves the best
audio format the visitor's browser supports.
