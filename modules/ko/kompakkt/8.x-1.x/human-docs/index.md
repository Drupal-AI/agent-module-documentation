# Kompakkt — manual setup guide

**Kompakkt** (`kompakkt`) lets editors embed the
[Kompakkt](https://kompakkt.de/) 3D and media viewer directly in Drupal content.
Kompakkt is an open‑source platform for viewing and annotating interactive 3D
models and media, widely used for cultural‑heritage and educational material. This
module adds a **field** you place on a content type; editors paste the URL of a
Kompakkt 3D model into it, and the interactive viewer renders on the page.

The workflow is deliberately simple. You add a field of type **Embed Kompakkt**
to a content type, configure it to use the *"URL of the target"* widget, and then
on each piece of content you paste a Kompakkt viewer link (for example
`https://kompakkt.de/viewer/index.html?entity=…`). Save, and the 3D model appears
in your content.

There are no API keys and no external accounts to configure inside Drupal — the
model is loaded from Kompakkt by URL. It supports a wide range of Drupal versions
(8 through 11).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form. All
setup happens on your content type's fields, described under "How to use it" below.

## Where it lives in the admin menu

Kompakkt adds no admin settings page. You use it entirely through the Field UI:
**Structure → Content types → *(type)* → Manage fields** to add the field, and
each entity's edit form to paste a model URL.

## How to use it

1. Go to **Structure → Content types → *(your type)* → Manage fields** and click
   **Add field**.
2. Choose the **Embed Kompakkt** field type, and configure it to use the **"URL of
   the target"** widget for input.
3. Save the field settings.
4. Create or edit a piece of that content type, and paste the URL of a Kompakkt 3D
   model (for example
   `https://kompakkt.de/viewer/index.html?entity=5d6f708c72b3dc766b27d750`) into
   the field.
5. Save the content — the 3D model now displays in the viewer on that page.

Because the viewer is loaded from a Kompakkt URL supplied by the editor, restrict
who can edit the field to trusted editors, as you would any embed field.
