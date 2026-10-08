# Simple Icons — manual setup guide

**Simple Icons** (`simple_icons`) lets your editors attach brand icons — the logos
from the popular [Simple Icons](https://simpleicons.org) project, 789+ of them — to
any content, and gives themers a Twig helper for printing those icons in templates.
It saves you from sourcing, optimising, and uploading brand logos by hand: the icon
set is already local, monochrome, and performance‑optimised, and editors just pick
the one they want by name.

Under the hood the module defines a `simple_icons_icon` **field type** (a short
string that stores the icon's slug), with a matching **widget** for choosing an
icon and a **formatter** for rendering it as inline SVG. Because it builds on core's
**Field** module, you can add an icon field to any fieldable entity — nodes,
taxonomy terms, users, media, paragraphs — and place it on the display like any
other field. The icon is emitted as raw SVG markup so you can style it freely with
CSS, and the markup is sanitised before output as a safety measure. Each icon
carries an accessible title naming the brand it represents.

A common pattern is a self‑service social‑media footer: build the footer as a menu
(with the Menu Item Extras module) or as a Config Pages paragraph, add a Simple
Icons field, and a client can add a new social profile — including its icon —
entirely on their own, with no support ticket. For content that is not managed
through a field, a Twig function prints a single icon by its slug, e.g.
`{{ simple_icons_icon('drupal') }}`.

The module has **no configuration form** — after the icon library is in place and
the module is enabled, the field type, widget, formatter, and Twig function are all
immediately available. It does have one important **installation prerequisite**: the
Simple Icons SVG library must be extracted into `libraries/simple-icons`. That step
is covered in [Installation](installation/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the icon library, install the
   module with Composer, and enable it.

## How to use it

There are two ways to output an icon:

- **As a field (for editors).** Add a **Simple Icons icon** field to a content type
  (or any other entity) via **Structure → … → Manage fields**. On the entity edit
  form, editors pick an icon with the provided widget; on **Manage display**, choose
  the Simple Icons formatter to render it. Use a multi‑value field for several icons,
  such as a row of social links.
- **In Twig (for themers).** Call `{{ simple_icons_icon('slug') }}` in a template,
  passing the icon's slug — the machine name each icon is known by. The available
  slugs are listed in the `icon-data.json` file in the module's root. This needs no
  field, so it is ideal for icons baked into a component or block template.

Need to add a CSS class to the icon markup? Override the module's
`simple-icons-icon.html.twig` template in your theme and edit the wrapping element.
