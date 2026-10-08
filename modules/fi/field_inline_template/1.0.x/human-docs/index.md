# Field Inline Template — manual setup guide

**Field Inline Template** (`field_inline_template`) lets site builders define an
**inline template** for rendering a field's output — Twig‑style markup written
and stored right in the display configuration, instead of creating a separate
theme template file. The template is edited through the **CodeMirror** code
editor, which gives you syntax highlighting and a comfortable editing experience
for the markup.

It's a practical way to give a field a custom display without touching your
theme: no `field--…​.html.twig` file, no theme deployment, just the template
saved with the display. It works both on an entity's **Manage display** and in
**Layout Builder** at the display‑mode level.

Because an inline template can contain markup and template logic, **treat the
ability to configure these templates as a trusted, developer‑level capability**.
Only grant its permission to site builders you trust, in the same way you would
guard other "can write template code" features. The module depends on the
[CodeMirror Editor](https://www.drupal.org/project/codemirror_editor) module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Security coverage note.** At the documented version Field Inline Template is
> **not covered by Drupal's security advisory policy**. Combined with the fact
> that inline templates hold markup/logic, restrict the configuring permission to
> trusted users and review before relying on it in production.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its CodeMirror dependency.

There is **no central configuration page** for this module — it has no site‑wide
settings form. You configure an inline template per field on the display,
described in "How to use it" below.

## Where it lives in the admin menu

Field Inline Template adds no admin page of its own. You use it from **Structure
→ Content types (or any fieldable entity) → *(bundle)* → Manage display** (or in
**Layout Builder**), where the inline‑template formatter appears in the field's
format list. Grant the module's permission to the trusted roles that should be
allowed to edit inline templates.

## How to use it

1. Go to the display you want to edit — **Manage display** for a bundle, or a
   Layout Builder display.
2. For the field you want to customise, choose the **inline template** formatter.
3. In the formatter's settings, write your Twig‑style template in the CodeMirror
   editor. The template controls how that field's value is rendered.
4. Save the display and view the entity to see your custom output.

> **Note on scope.** The module supports Manage display and Layout Builder at the
> display‑mode level. Per‑entity Layout Builder ("Allow each content item to have
> its layout customized") is noted by the maintainers as untested.
