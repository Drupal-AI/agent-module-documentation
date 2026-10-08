# Template breadcrumb — manual setup guide

**Template breadcrumb** (`template_breadcrumb`) lets you render an entity's
breadcrumb trail *inside* its content template, instead of only in the page‑level
breadcrumb region. It exposes the breadcrumb as something you can place on a
content type's display, so a themer can output it in the template with
`{{ content.template_breadcrumb }}` and control exactly where in the content
structure the breadcrumb appears.

The problem it solves is placement. By default Drupal renders the breadcrumb in a
fixed region defined by the theme, which is not always where a design wants it —
sometimes the trail belongs within the article body, above a title block, or inside
a specific layout region. This module hands that decision to the themer by making
the breadcrumb available as a field in the entity's view mode. The breadcrumb still
reflects the current path and context; the module has no content or access role of
its own.

This module is a **theming tool**, so it does not "just work" on enable — you
configure the view mode to include the breadcrumb and then output it in your Twig
template (see below). It has no module dependencies of its own, **but** it relies on
your site producing a usable breadcrumb: use either the **Easy Breadcrumb**
(`easy_breadcrumb`) module, or apply the core breadcrumb patch referenced in the
module's documentation (drupal.org issue 2884217) if you are using core breadcrumbs.
There are no submodules.

This guide is written for a **human** setting the module up through the admin UI and
theme. If you want terse, token‑cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enable the breadcrumb on a view mode
   and output it in your template.

## How to use it

Enable the breadcrumb on the content type's display (its **Manage display** screen),
then in your theme's template render it with `{{ content.template_breadcrumb }}` at
whatever position you want. See [Configuration](configuration/index.md) for the
full walkthrough.
