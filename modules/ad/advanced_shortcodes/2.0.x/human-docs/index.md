# Advanced Shortcodes — manual setup guide

**Advanced Shortcodes** (`advanced_shortcodes`) extends the contributed
**Shortcode** module with a set of ready-made **Bootstrap-style shortcodes** you
can drop into any text. Shortcodes are square-bracket codes — like
`[alerts]…[/alerts]` — that get turned into HTML when the page renders, so an
author can produce styled components without writing markup or needing a theme
change.

This module adds nine such shortcodes: **alerts**, **column**, **row**,
**accordion** / **accordions**, **icon**, **jumbotron**, **progress**, and
**hr**. Each renders a piece of Bootstrap markup — coloured alert boxes,
responsive grid columns and rows, collapsible accordions, inline icons, a hero
"jumbotron" banner, progress bars, and horizontal rules. The module ships its own
Bootstrap CSS/JS and attaches it on the front end automatically (it skips admin
pages), so the components are styled out of the box.

Because the shortcodes are just an add-on to a text-format filter, you turn them
on per text format and decide which roles can use that format — see
[Configuration](configuration/index.md) for the steps.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside its Shortcode dependency.
2. [Configuration](configuration/index.md) — enable the shortcode filter on a text
   format and choose which shortcodes to allow.

## Where it lives in the admin menu

Advanced Shortcodes has no settings page of its own. It becomes active when you
enable the **Shortcode** filter on a text format under **Configuration → Content
authoring → Text formats and editors**
(`/admin/config/content/formats`). After that, authors simply type the shortcodes
into content.

## How to use it

Once the filter is enabled on a text format (see
[Configuration](configuration/index.md)), type a shortcode into any field that
uses that format — in the CKEditor source view or a plain-text field. A few
examples:

- **Alert box:** `[alerts type="info"]Your message here[/alerts]` — the `type`
  values are `1`/`success`, `2`/`info`, `3`/`warning`, `4`/`danger`.
- **Grid columns:** `[column cols="6" begin="1" end="1"]…[/column]`, with optional
  `xs`/`sm`/`md`/`lg` breakpoint attributes. Use the `row` shortcode's `begin`
  attribute to open a row wrapper and `end` to close it.
- **Accordion:** wrap `[accordion title="…" icon="…" id="…"]body[/accordion]`
  items inside `[accordions]…[/accordions]`.
- **Icon:** `[icon class="fa fa-star"][/icon]`.
- **Jumbotron banner:** `[jumbotron title="Welcome"]intro text[/jumbotron]`.
- **Progress bar:** `[progress percent="50"][/progress]`.
- **Horizontal rule:** the `hr` shortcode.

You can pass an extra `class` attribute to any shortcode to add your own CSS
classes. Each shortcode's usage tips also appear in the "filter tips" shown below
the text format's editor.
