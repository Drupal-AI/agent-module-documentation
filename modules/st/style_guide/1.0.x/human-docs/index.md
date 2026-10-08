# Style Guide (admin) — manual setup guide

**Style Guide (admin)** (`style_guide`) gives theme developers an admin page that
previews how a custom Drupal theme styles common HTML components — headings,
lists, tables, forms, buttons, blockquotes, colors, and whatever else you choose
to add. Rather than hunting across the site for a page that happens to show each
element, you get one place, at `/admin/appearance/style-guide`, to review the
theme's treatment of each component while you build it.

The problem it solves is theme-development feedback: front-end developers need to
see their styles applied to real markup in one view. Style Guide provides the page
and the plumbing; **you decide which components appear** by adding them to your
theme. It works by exposing a theme-settings form you extend from your theme's
`theme-settings.php` (or `.theme` file) with a `hook_form_FORMID_alter()`
implementation — each component you add there (a color palette, a set of headings,
form examples) then renders on the style-guide page. Recent versions ship a
`theme-settings.php` starting point aimed at Bootstrap 5, and the maintainer has a
companion Bootstrap SASS starter kit.

The module provides its own permissions and supports Drupal 9.2+, 10, and 11. It
has no dependencies and no separate settings form of its own — the "configuration"
is the component markup you add in your theme's code.

This guide is written for a **human** working through the admin UI and theme. If
you are an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and wire it into your theme.

## Where it lives in the admin menu

The style guide renders at **Appearance → Style guide**
(`/admin/appearance/style-guide`). Authorized users select a front-end theme there
to preview its components.

## How to use it

1. Enable the module like any other.
2. In your theme, implement `hook_form_style_guide_theme_settings_alter()` (in
   `yourtheme.theme` or `theme-settings.php`) — this is where you register the
   components you want to preview.
3. Add components inside that function. Simple markup blocks (a color palette, a
   set of headings) can be added with a render array using the `#prefix` key to
   output raw markup; form elements need to be built with the Form API, since raw
   HTML form inputs passed through `#prefix` are sanitized. The project's page
   includes worked examples for a Bootstrap color palette, typography/headings, and
   Form API inputs.
4. Visit `/admin/appearance/style-guide`, pick your theme, and review how each
   component looks.
