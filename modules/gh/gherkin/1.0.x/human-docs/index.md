# Gherkin Script — manual setup guide

**Gherkin Script** (`gherkin`) adds a dedicated **media type** for storing
internal *Gherkin* scripts — the plain‑text, Given/When/Then syntax used to write
Behaviour‑Driven Development (BDD) scenarios. Instead of keeping your feature
files loose in the codebase or pasting them into a plain text field, you store
them as first‑class **media entities**, each with a proper field widget and
formatter.

Editing is done through the **ACE editor**, a code editor that gives your Gherkin
text syntax‑aware highlighting and a comfortable writing surface right inside
Drupal. Because of that, the module depends on the **ACE Editor** module and the
`ace-builds` JavaScript library, which needs a little one‑time Composer setup (see
Installation).

The module builds on core **Media** and **Editor** and is aimed at teams who want
to keep their BDD scripts alongside the rest of their content.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — prepare Composer for the ACE library,
   install the module, and enable it.

There is **no dedicated settings form** for this module — it works through the
standard Media system. You manage Gherkin scripts under **Content → Media**, and
adjust the field's widget and formatter through the media type's *Manage form
display* and *Manage display* like any other media type.

## Where it lives in the admin menu

Gherkin scripts are managed as media at **Content → Media**
(`/admin/content/media`). The Gherkin media type itself is configured under
**Structure → Media types** (`/admin/structure/media-types`), where you can adjust
its fields, form display (the ACE editor widget), and display formatter.

## How to use it

1. After installing and enabling the module (see Installation), a **Gherkin**
   media type is available.
2. Go to **Content → Media → Add media → Gherkin** to create a new script.
3. Write or paste your Gherkin scenario into the ACE editor field, then save.
4. Reference the media from content as you would any media item, and the
   configured formatter renders the stored script.
