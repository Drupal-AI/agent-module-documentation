# Header Formatter — manual setup guide

**Header Formatter** (`header_formatter`) adds one small thing to Drupal: a
field formatter called **Header** that wraps a plain‑text field in a real HTML
heading tag — an `<h1>` through `<h6>` that you choose per display. It is the
tidy way to turn a "subtitle", "tagline", or "section title" text field into a
proper semantic heading without hand‑writing a Twig template or a theme
override.

You use it entirely from the **Manage display** tab of any entity type
(content types, taxonomy terms, users, media, paragraphs, and so on). Pick the
**Header** format for a single‑value text field, choose which heading level you
want, and save — the field then renders as, say, `<h2>About us</h2>` on the
front end. Because it is set per view mode, the same field can be an `<h1>` on
the full page and an `<h3>` in a teaser.

The module is intentionally tiny. It works with Drupal core alone, adds no
settings page, no permissions, and no submodules. The only setting it stores is
the heading level you pick for each display.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Header Formatter has no configuration page of its own. Everything happens on the
**Manage display** tab of whatever entity you are theming, for example
**Structure → Content types → *(your type)* → Manage display**
(`/admin/structure/types/manage/{type}/display`).

## How to use it

1. Make sure the field you want to style is a **single‑value** core **Text
   (plain)** (`string`) field. Multi‑value fields do not offer this formatter.
2. Go to the **Manage display** tab for that entity, bundle, and view mode.
3. In the **Format** column for your field, choose **Header**.
4. Click the gear icon on the right, pick the heading level (**H1**–**H6**, the
   default is **H2**), and click **Update**.
5. Click **Save**. The field now renders inside the heading tag you chose — for
   example a value of `About us` at level 2 becomes `<h2>About us</h2>`.

Tip: repeat this on different view modes to use different levels for the same
field — an `<h1>` hero title on the full display, a smaller `<h3>` on teasers.
