# Image Hotspots — manual setup guide

**Image Hotspots** (`image_hotspots`) lets editors mark regions of an image with
labelled points, turning a flat picture into an annotated image a visitor can
explore. It answers a need a caption can't: sometimes the information *is where
something is* — a product photo labelling its features, a floor plan marking rooms,
a diagram identifying parts, a team photo naming people, a map with points of
interest.

The reason to do this with overlaid markup rather than by baking labels into the
image is that overlaid text stays **text**: it remains translatable, searchable,
readable by a screen reader, and correct the moment a label changes. Baked‑in text
is none of those things. Hotspots are also responsive — when the image scales, the
points scale proportionally with it. The module integrates with core's image
module, so you can add hotspots to any image field, and it is designed to be used
**while viewing the image** rather than on the node edit form.

Creating, updating and deleting hotspots happens through the module's own routes,
gated by an **`edit image hotspots`** permission. A couple of things are worth
holding in mind. The permission is **per‑site, not per‑image** — anyone who holds
it can annotate any image the site displays, which matters where images belong to
different teams. And an annotated image is an **accessibility** question: points
positioned over a picture are meaningless without a keyboard path and a text
alternative that conveys the same information, in order. Note also that this release
is a **beta** (8.x‑1.0‑beta5) on core `^10.1 || ^11`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central settings form** for this module. You grant the permission and
then create hotspots directly on displayed images, described in "How to use it"
below.

## Where it lives in the admin menu

Image Hotspots adds no configuration page of its own. The one administrative step is
granting access: on **People → Permissions** (`/admin/people/permissions`), find and
assign **Edit image hotspots** to the roles that should be able to annotate images.
Everything else happens on the front end, on the images themselves.

## How to use it

1. Enable the module and grant the **Edit image hotspots** permission to the
   appropriate role(s).
2. Make sure the image you want to annotate is displayed through a normal image
   field on a page.
3. As a user with the permission, view that page. The module provides an editing
   affordance on the displayed image that lets you place a point and give it a text
   label.
4. Add as many labelled points as you need; they are saved via the module's
   create/update routes. Because hotspots are stored as text and positioned
   responsively, they stay correct as the image scales and can be translated.
5. To remove a point, use the delete action on the hotspot while viewing the image.

Accessibility reminder: whenever you annotate an image, make sure the same
information is available to keyboard and screen‑reader users — for example in the
image's alt text or nearby body text — so the annotation isn't the only way to get
the message.
