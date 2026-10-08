# Media Inline Frame — manual setup guide

**Media Inline Frame** (`media_iframe`) adds a new Media *source* called "Inline frame"
so you can build a media type backed by an `<iframe>` URL. In plain terms: it lets your
editors store and reuse arbitrary embeddable URLs — Google Maps, calendars, forms,
Power BI / Grafana / Metabase dashboards, external video players, booking widgets — as
proper media entities, the same way images and documents live in the Media Library.

Core Media already has an oEmbed source, but that only works with URLs from registered
oEmbed providers. Media Inline Frame is more open: whatever URL you allow (governed by
the underlying `iframe` field's own settings) can be embedded. Editors can even paste a
URL straight into the Media Library modal to create a new iframe media item on the spot.

There is **no settings page** for this module — you configure it entirely through the
standard Media type UI, exactly like any core media source. You create a media type,
choose "Inline frame" as its source, and Drupal wires up an "Inline Frame URL" field and
a sensible view display for you. The module requires Drupal 11, PHP 8.2+, core's **Media**
module, and the contributed **Iframe** field module (which supplies the actual field
type).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the Iframe
   dependency) and enable the module.

## Where it lives in the admin menu

Media Inline Frame has no admin form of its own. You work with it under **Structure →
Media types** (`/admin/structure/media`), where "Inline frame" appears as a choice in
the **Media source** dropdown when you add or edit a media type.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Media types → Add media type**.
3. Give it a name (e.g. "Remote page"), choose **Media source: Inline frame**, and
   save.
4. Drupal automatically creates the source field (labelled **Inline Frame URL**) and
   sets the view display to render it with the Iframe formatter.
5. Editors can now create items of this media type — either from the normal media add
   form, or by pasting a URL into the **Iframe URL** box in the Media Library modal.

From then on, an iframe media item behaves like any other media entity: reference it
from a media field, embed it via the rich‑text editor, list it in a view, or reuse the
same embedded dashboard across many pages with a single source of truth. To restrict who
can create iframe media, use the standard media type / entity permissions.
