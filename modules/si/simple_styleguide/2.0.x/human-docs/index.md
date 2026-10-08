# Simple Styleguide — manual setup guide

**Simple Styleguide** (`simple_styleguide`) builds a single "living styleguide" page
at `/simple-styleguide` that shows your theme's components rendered with the site's
real CSS, all in one place. Instead of hunting across the site to see how headings,
buttons, tables, and form elements look, front‑end developers, designers, and
stakeholders get one reference URL that reflects the actual, current styling.

The page has three parts. First, a set of **built‑in patterns** — eleven common HTML
building blocks (headings, text, lists, blockquotes, horizontal rules, tables,
alerts, breadcrumbs, forms, buttons, and pagination) that you switch on or off from a
settings form. Second, a **colour palette**: you list your brand colours and the page
shows each one as a swatch with its hex value, CSS class name, and a usage note.
Third, your own **custom patterns** — reusable snippets like a card or hero component
that you add as individual entries.

Because custom patterns are stored as configuration entities, they export with the
rest of your config and deploy cleanly across environments — your component inventory
lives in code, not in a separate tool. The styleguide page is automatically marked
`noindex, nofollow`, so it never shows up in search results.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and grant the right permissions.
2. [Configuration](configuration/index.md) — choose the built‑in patterns, define
   your colour palette, and add and reorder custom patterns.

## Where it lives in the admin menu

- The styleguide page itself is at **`/simple-styleguide`** and is visible to anyone
  with the **Access style guide** permission.
- The settings form is at **Configuration → Styleguide → Settings**
  (`/admin/config/styleguide/settings`).
- Custom patterns are managed at **Configuration → Styleguide → Patterns**
  (`/admin/config/styleguide/patterns`).

## How to use it

After enabling the module, open the settings form to pick which built‑in patterns you
want and to enter your colour palette, then add any custom components of your own.
Grant the **Access style guide** permission to whoever should be able to view the
page, and the **Administer style guide** permission to whoever maintains the custom
patterns. The full walkthrough is in [Configuration](configuration/index.md).
