# Sketchfab — manual setup guide

**Sketchfab** (`sketchfab`) adds a dedicated field type for embedding
[Sketchfab](https://sketchfab.com) 3D models into your content. Instead of
hand-writing iframe markup, an editor pastes a Sketchfab model URL into a field
and the module renders it as an embedded, interactive 3D-model iframe — with
fullscreen and VR attributes allowed.

It plugs straight into Drupal's standard Field UI. You add an **Embed Sketchfab**
field to any entity type and bundle (a node, a media type, and so on), the field
uses a URL widget to capture the model's address, and an Iframe formatter turns
that into the embed on display. The field can be multi-value, so a single piece
of content can show several models. The module adds no routes, permissions,
services, or settings of its own — it is a pure Field API add-on.

The module works the moment you enable it and add a field; there is nothing to
configure globally. It runs on Drupal 8, 9, and 10.

One thing worth knowing: the widget does not restrict the URL to sketchfab.com,
so an editor could in principle enter any URL to be shown in an iframe. This
requires content-editing access (it is not an anonymous-facing surface), but it
is a reason to only grant the field to trusted roles.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Once the module is enabled, add the field through the normal Field UI:

1. Go to the entity you want to add it to — for example **Structure → Content
   types → Article → Manage fields** — and choose **Add field**.
2. Pick the **Embed Sketchfab** field type and give it a label. Set the number of
   values (allowed cardinality) if you want editors to embed more than one model.
3. On the **Manage form display** tab, the field uses the *URL of the target*
   widget — an HTML5 URL input where editors paste the Sketchfab model URL.
4. On the **Manage display** tab, the field uses the *Iframe* formatter, which
   renders the model as an embedded iframe (it appends `/embed` to the stored URL
   and wraps it in a styled container).

Now editors just paste a model's Sketchfab URL into the field and the 3D viewer
appears wherever that field is displayed.
