# No Markup — manual setup guide

**No Markup** (`nomarkup`) strips the wrapper HTML around a rendered field so the
field outputs just its raw value — no `<div class="field …">`, no label wrapper,
no item wrapper. This is handy when you are feeding Drupal data into a component
library, a design‑system template, or a decoupled/headless front end where
Drupal's default markup would only get in the way.

The module works entirely through a per‑formatter toggle. On any field's *Manage
display* row, it adds a **Remove field markup** option. When you enable it, the
field renders through a bare template that prints only the field's value(s). For
multi‑value fields it joins the values with a separator you choose (the default
is `|`). And for entity‑reference fields shown with the *Rendered entity*
formatter, an extra option, **Remove markup on the referenced entity**, strips the
wrapper markup from the referenced entity too. The module also ships a Views
**style** plugin that renders rows with no additional markup.

There is no settings page, no permission, and no dependency — it is a pure
display‑layer helper. Your choice is stored as a third‑party setting on the
field's formatter in the view‑display config, so it exports and imports with the
rest of your configuration.

This guide is written for a **human** using the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

No Markup has no admin page of its own. You use it on each entity's **Manage
display** page (for example **Structure → Content types → Article → Manage
display**), and its Views style appears when you choose a style for a view.

## How to use it

1. Go to the bundle's **Manage display** page and pick the view mode you want to
   affect (you can leave the default view mode's markup intact and strip it only
   in, say, a headless view mode).
2. Click the gear/cog icon on the field's row.
3. Tick **Remove field markup**. If the field holds multiple values, set a
   **multi‑value separator** (default `|`). If it is an entity‑reference field
   rendered as a *Rendered entity*, you can also tick **Remove markup on the
   referenced entity**.
4. Click **Update**, then **Save**. The field's summary will then read that the
   field renders without markup.

To render a whole view's rows with no extra wrappers, choose the **No Markup**
style when configuring the view's format. To turn the behavior off again, untick
**Remove field markup** and save.
