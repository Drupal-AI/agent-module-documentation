# Entity Display Template — manual setup guide

**Entity Display Template** (`entity_display_template`) lets you override how an
entity view mode renders by writing a small **inline Twig template** right on the
**Manage Display** page — no theme file, no custom module. For a chosen view mode
you flip a checkbox, type your Twig into a CodeMirror editor, and from then on
that view mode renders your markup instead of the default field output.

The problem it solves is repetition. If you build many view modes (for example
lots of predefined block types for rapid, non-programmer-friendly assembly),
crafting a `.html.twig` file in your theme for each one gets tedious fast. This
module keeps the template next to the display it belongs to, stored as a
third-party setting on the view-display config entity, so it deploys with your
configuration export. Inside the template you print fields by machine name —
`{{ field_body }}`, `{{ field_image }}` — and you get a handful of helper
variables too (`link`, `entity_id`, `active_theme`, `base_path`,
`current_language`, `user_is_admin`, `user_is_logged_in`, and front-page flags).

It works as soon as you enable it — there is nothing to switch on globally. Its
one dependency is **CodeMirror Editor** (`codemirror_editor`), which supplies the
syntax-highlighted code box on the display form.

One caveat to understand before you use it: whoever can edit a view display can
write Twig that runs for **every visitor** of that view mode. The template is
executed without Twig's sandbox, so editing it is effectively equivalent to
granting PHP access. Keep the display-administration permission limited to people
you already trust at that level, and do not enable this module on sites where
semi-trusted users can reach Manage Display.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in
   CodeMirror Editor, and enable the module.
2. [Configuration](configuration/index.md) — the per-view-mode "Display Template
   options" editor on Manage Display, the Twig variables you can use, and the
   security caveat.

## Where it lives in the admin menu

There is no dedicated settings page. Everything happens on a bundle's **Manage
Display** tab — **Structure → (your entity type) → Manage display** (pick the
view mode you want to override). The module adds a **Display Template options**
section to that form.
