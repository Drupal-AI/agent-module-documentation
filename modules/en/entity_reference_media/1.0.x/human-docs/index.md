# Entity Reference Media — manual setup guide

**Entity Reference Media** (`entity_reference_media`) is a set of Media
enhancements built around a reference field designed specifically for referencing
**Media** items. It is similar in spirit to core's entity-reference field, but
tailored so that data belonging to *this particular use* of a media item lives on
the reference rather than on the shared media entity itself.

The headline problem it solves: you want to add or change a **caption** for a
media item — or set **start/end** values for a video — per placement, without
editing the media entity. Because that information sits on the reference, you can
reuse the same media item in many places with a different caption or a different
video start/end each time. Alongside the field type, the module provides an
optimized **Media Library** widget and an optimized **Entity Reference** formatter
so the new field works smoothly with the media library editing experience.

It depends on core's **Media** and **Media Library** modules and runs on Drupal
8.8 through 11. Note that the module works out of the box with the Media Library
Widget and the Entity Reference Formatter; using it with *other* widgets or
formatters may require a patch or a `hook_field_formatter_info_alter()`
adjustment. This release line is a release candidate (`1.0.0-rc7`) — a long‑lived
rc usually signals a stable API in practice, but it is not a final stable release,
so test before relying on it in production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it and its Media dependencies.

There is **no configuration page** for this module — it has no settings form. You
add its field to a content type and set up its widget and formatter on the
entity's *Manage form display* and *Manage display*, described in "How to use it"
below.

## Where it lives in the admin menu

Entity Reference Media adds no admin settings page. You use it from **Structure →
Content types → *(bundle)* → Manage fields / Manage form display / Manage
display**.

## How to use it

1. On a content type (or any fieldable entity), add a new field of the Entity
   Reference Media field type, targeting your media type(s), at **Structure →
   Content types → *(bundle)* → Manage fields**.
2. On **Manage form display**, use the module's optimized **Media Library**
   widget so editors can pick media and supply the per‑reference caption (and
   video start/end where applicable).
3. On **Manage display**, use the optimized **Entity Reference** formatter to
   render the referenced media together with the per‑reference caption.
4. Reuse the same media item across multiple pieces of content, giving each use
   its own caption or video timing.
