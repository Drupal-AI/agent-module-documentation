# Paragraphs Horizontal Rule — manual setup guide

**Paragraphs Horizontal Rule** (`paragraphs_hr`) provides one small, focused
thing: a **horizontal-rule (divider) paragraph type**. When you build pages out
of Paragraphs, editors sometimes just need a clean visual break between two
sections. This module gives them an `<hr>` paragraph they can drop in for exactly
that — no fields to fill in, just a divider.

Out of the box the paragraph offers two divider "types", implemented as CSS
classes: **Thin** (`hr--thin`) and **Thick** (`hr--thick`). A developer can
change or extend the available options by implementing
`hook_paragraphs_hr_allowed_values_alter()` in a custom module. Note that the
module only outputs the rule and its class — your site's **theme is responsible
for the actual CSS** that styles those thin/thick variants.

It is purely a presentation element: it has no settings page, no permissions, and
no access-control role. It is designed to be used alongside the **Paragraphs**
module and works across Drupal 8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. Setup is just adding the HR
paragraph to your content and styling the divider classes in your theme, as
described below.

## How to use it

1. Make sure the **Paragraphs** module is enabled and you have a Paragraphs field
   on a content type.
2. Enable Paragraphs Horizontal Rule (see [Installation](installation/index.md)).
   It registers a horizontal-rule paragraph type automatically.
3. Edit a piece of content, add a paragraph to your Paragraphs field, and choose
   the **horizontal rule** type. Pick **Thin** or **Thick** if that choice is
   offered.
4. In your theme, add CSS for the `hr--thin` and `hr--thick` classes so the
   dividers look the way you want. The module supplies the markup; the styling is
   yours.

> **For developers:** to offer more than the built-in Thin/Thick options,
> implement `hook_paragraphs_hr_allowed_values_alter(&$options)` in a custom
> module and return your own class ⇒ label pairs.
