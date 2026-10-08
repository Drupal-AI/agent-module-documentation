# Field Group Definition List — manual setup guide

**Field Group Definition List** (`field_group_dl`) adds a **Definition list**
display formatter to the Field Group module. When you group a set of fields
together on an entity's display, this formatter renders that group as a semantic
HTML definition list (`<dl>`): each field's label becomes a `<dt>` and its value
becomes the matching `<dd>`. It is the clean, accessible way to present
label/value pairs — product attributes, event details, author/date metadata —
without resorting to ad‑hoc table markup.

It extends the contrib
**[Field Group](https://www.drupal.org/project/field_group)** module, which is
what lets you organize fields into groups on the display in the first place. Field
Group Definition List simply contributes one more formatter option to that
module. It works in the **view** (display) context only — not on entity forms —
and it automatically hides each grouped field's own label in favour of the `<dt>`
label, so you get a tidy definition list rather than doubled‑up labels.

There are no routes, permissions, services, or settings of its own; it only
affects rendered output. You control everything from the standard Field Group
formatter settings, including an optional HTML `id` and extra CSS classes, and
you can override its Twig template (`field-group-dl.html.twig`) in your theme for
custom markup.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Field Group.

There is **no site‑wide configuration page** for this module. You add the group
and choose the Definition list formatter on your entity's display, described
below.

## Where it lives in the admin menu

Field Group Definition List adds no admin page of its own. You use it from the
Field Group UI on an entity's **Manage display** tab — for a node, **Structure →
Content types → *(type)* → Manage display**
(`/admin/structure/types/manage/{type}/display`).

## How to use it

1. Go to the **Manage display** tab for your entity.
2. Add a new field group (using the *Add group* control that Field Group
   provides) and choose **Definition list** as the group's format.
3. Move the fields you want into that group.
4. Optionally set the group's HTML **id** and extra **classes** in the group's
   formatter settings for theming.
5. Save. On rendered pages the grouped fields appear as a `<dl>`, with each
   field's label as a `<dt>` and its value as a `<dd>`, and the fields' individual
   labels hidden automatically.
