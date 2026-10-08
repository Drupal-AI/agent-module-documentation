# Field Group Modal Bootstrap — manual setup guide

**Field Group Modal Bootstrap** (`field_group_modal_bootstrap`) adds a **Field
Group display formatter** that renders a group of fields inside a **Bootstrap 5
modal window** when an entity is viewed. It's a clean way to tuck secondary or
lengthy content — extra specifications, long descriptions, supplementary media —
behind a "view details" style popup without writing any custom theming or
JavaScript.

It plugs straight into the [Field Group](https://www.drupal.org/project/field_group)
module. On an entity's *Manage display* you add a group, choose the **Modal
Bootstrap** format, and the fields you place in that group are rendered inside a
modal dialog triggered from the entity display. The formatter lets you set the
modal's HTML `id` and add extra HTML attributes, and it attaches core's
`drupal.dialog` libraries for the dialog behaviour.

The module is **display‑only**: it works on the entity *view* context, has no
routes, permissions, or settings pages of its own, and stores nothing outside
the field group's own settings. Its one external requirement is that **Bootstrap
5 assets are present** — either from a Bootstrap 5.x theme or added to your
site's libraries.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and Field Group, and make sure Bootstrap 5 assets are available.

There is **no configuration page** for this module — it has no settings form.
The modal is set up on your entity's *Manage display*, described in "How to use
it" below.

## Where it lives in the admin menu

Field Group Modal Bootstrap adds no admin page. You use it from **Structure →
Content types (or any fieldable entity) → *(bundle)* → Manage display**, where
its formatter appears in the list of field group formats.

## How to use it

1. On the display you want (a node's *Manage display*, for example), click **Add
   group** and choose the **Modal Bootstrap** format.
2. Move the fields you want inside the modal into that group.
3. In the group's format settings, optionally set an **element id** and any
   **extra HTML attributes** for the modal element.
4. Save the display.

When the entity is viewed, the grouped fields render inside a Bootstrap 5 modal
opened from the entity display, keeping teasers and primary content compact
while the detail stays one click away.

> **Bootstrap 5 is required at render time.** If your site doesn't use a
> Bootstrap 5.x theme, add Bootstrap 5's CSS/JS to your site libraries so the
> modal is styled and behaves correctly. See
> [Installation](installation/index.md).
