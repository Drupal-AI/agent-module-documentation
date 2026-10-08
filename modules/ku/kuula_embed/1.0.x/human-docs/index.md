# Kuula Embed — manual setup guide

**Kuula Embed** (`kuula_embed`) lets you embed a [Kuula](https://kuula.co/) 360°
panorama or virtual tour on your Drupal content. Kuula is a platform for sharing
360° photos and tours; this module adds a **field** you place on any content type
(or other fieldable entity), into which editors paste a Kuula share/embed URL. The
panorama then renders in an `<iframe>` on the page, complete with fullscreen and
motion‑sensor (gyroscope/accelerometer) support so visitors can look around.

Under the hood it provides a small Field API set — a field type (`kuula_field`,
which stores the embed URL plus a "use CSS" flag), a widget for entering the URL,
and a formatter for rendering it. Out of the box the embed displays at a fixed
100% × 640 size; enabling the field's **use CSS** setting instead adds a
`ku_embed` class so you can control sizing from your theme's stylesheet.

There are no API keys or accounts to configure inside Drupal — the panorama is
loaded from the Kuula URL an editor supplies. Because that URL is rendered
directly into the iframe, restrict who can edit the field to trusted editors, as
you would with any raw‑embed field. It supports a wide range of Drupal versions
(8 through 11).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form. All
setup happens on your content type's fields and display, described under "How to
use it" below.

## Where it lives in the admin menu

Kuula Embed adds no admin settings page. You use it entirely through the Field UI:
**Structure → Content types → *(type)* → Manage fields** to add the field, and
**Manage display** to configure how it renders.

## How to use it

1. Go to **Structure → Content types → *(your type)* → Manage fields** and click
   **Add field**.
2. Choose the **Kuula Embed** field type and save the field settings. In the field
   settings you can enable **use CSS** if you'd rather size the panorama with your
   theme's `ku_embed` class than use the default 100% × 640 size.
3. On **Manage display**, confirm the field uses the Kuula formatter so the
   panorama renders (rather than showing the raw URL).
4. Create or edit content of that type and paste the **Kuula share/embed URL** for
   the panorama into the field, then save.

You can add the field to nodes, media, taxonomy terms, or any fieldable entity, and
use a multi‑value field to show several panoramas on one entity. Style the embedded
iframe from your theme via the `ku_embed` class when **use CSS** is enabled.
