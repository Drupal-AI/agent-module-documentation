# Backfill formatter — manual setup guide

**Backfill formatter** (`backfill_formatter`) is a **field formatter** for
entity‑reference fields. It lets editors curate references by hand, but when the field
isn't full, it automatically fills the remaining slots with **related content that
shares the most taxonomy terms** with the current item. It's the classic "related
articles" pattern: pick a few manually, and let the module top up the rest with
genuinely similar content.

The formatter is called **Back‑fill by terms**. To find similar content it queries the
term index provided by the **Taxonomy Entity Index** module, ranks candidates by how
many taxonomy terms they share with the source entity (most shared terms first), and
lets you give certain vocabularies precedence in that ranking. It runs on Drupal 9, 10
and 11.

Because it's a display formatter rather than a configurable "settings page" feature, you
set it up on a field's **Manage display** tab. There's no separate admin form, so its
setup is described here. Under the hood it queries safely (Drupal's parametrised database
API, entity queries with access checking) and access‑checks every item it renders, so it
never shows a visitor content they aren't allowed to see.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (with Taxonomy Entity
   Index) and enable it.

## Where it lives in the admin menu

There is no dedicated settings page. You configure the formatter per field at
**Structure → Content types → *(your type)* → Manage display**
(`/admin/structure/types/manage/*/display`), or the equivalent Manage display tab for
any other entity type with a reference field.

## How to use it

1. Have an **entity‑reference field** on your content type (for example a "Related
   articles" field that references other articles), with its item limit set to however
   many references you want shown.
2. Go to that entity's **Manage display** tab and set the field's format to **Back‑fill
   by terms**.
3. Open the format's settings (the cog) to choose:
   - the **view mode** used to render the back‑filled items,
   - the **number of items** to display (up to the field's maximum),
   - which **vocabularies get precedence** when matching by shared terms.
4. Editors can then curate specific references on the content itself; any unfilled slots
   are completed automatically with the best term‑matching content.

Selection can be extended by developers via a `BackFillQuery` plugin (per‑entity‑type
handlers for node, media, comment, term and user) or a query‑alter path — see the
[`agent/`](../agent/start.md) docs for those internals.
