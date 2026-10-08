# Paragraphs Summary Formatter — manual setup guide

**Paragraphs Summary Formatter** (`paragraphs_summary`) adds a field formatter called
**"Paragraphs enhanced summary"** for [Paragraphs](https://www.drupal.org/project/paragraphs)
fields. Instead of rendering every referenced paragraph, it renders only the
paragraph bundles you choose, in a view mode you choose, up to a limit you set —
perfect for showing a compact "summary" of a long Paragraphs field in a teaser,
card, or listing display.

A common use is showing just the first text or hero paragraph of a page as an excerpt
on an index or search page, while the full display still shows everything. You can
also allow all bundles but switch to a lighter view mode, or cap the number of items
rendered without restricting bundles.

It's a single formatter plugin with no admin settings page, no permissions, and no
Drush. It depends on the Paragraphs module and reuses core's recursive‑render
protection, so nested paragraph loops are guarded against automatically.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Paragraphs.

## How to use it

There's no admin menu item — you select this formatter per field on an entity's
**Manage display** tab (`/admin/structure/…/display`). It only appears for Paragraphs
fields (technically, `entity_reference_revisions` fields whose target is a paragraph).

1. Go to the **Manage display** tab of the content type (or other entity) and the
   display/view mode you want to change — for example the *Teaser* display of a node.
2. Find your Paragraphs field and change its **Format** to **Paragraphs enhanced
   summary**.
3. Click the formatter's cog to configure three settings:

| Setting | Default | What it does |
|---|---|---|
| **Allowed bundles** | *(none checked)* | Checkboxes of the field's eligible paragraph bundles. Only ticked bundles are rendered; **leaving them all unticked means all bundles are allowed**. |
| **View mode** | `default` | Which paragraph view mode each rendered item uses. |
| **Limit** | `1` | The maximum number of items rendered. `0` means unlimited. |

4. Click **Update**, then **Save**.

For example, to show only the first *text* paragraph in a teaser, allow just the
`text` bundle, pick a light view mode, and leave the limit at `1`. The setting is
stored in the entity's view‑display config; see the sibling
[`agent/configure/formatter.md`](../agent/configure/formatter.md) for the storage
shape and a Drush example.
