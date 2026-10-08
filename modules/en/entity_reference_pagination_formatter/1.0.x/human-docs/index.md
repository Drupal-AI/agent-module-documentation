# Entity reference pagination formatter — manual setup guide

**Entity reference pagination formatter** (`entity_reference_pagination_formatter`)
is a field formatter for entity-reference fields that **paginates** the referenced
entities. When a field references many entities, rendering them all at once is slow
and unwieldy; this formatter shows them a group of *N* items at a time and provides
a "next" link to reveal the rest.

The "next" link can be clicked manually, or — thanks to the
[Ajax Link](https://www.drupal.org/project/ajax_link) module it depends on — load
the next batch of entities **automatically via AJAX**, in place, without a full
page reload. A typical use is a recipe's long list of ingredient references, or any
"related content" field with a large number of items, where you want to keep the
initial page light while still letting visitors page through everything.

It is purely a display formatter — it has no content or access role of its own, and
the referenced entities respect their own access when rendered. It depends on the
contributed **Ajax Link** module and runs on Drupal 10.3+, 11, and 12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Ajax Link
   dependency with Composer, then enable it.

There is **no configuration page** for this module — it has no site‑wide settings
form. You select the formatter and set its page size on the field's *Manage
display*, described in "How to use it" below.

## Where it lives in the admin menu

Entity reference pagination formatter adds no admin settings page. You use it from
**Structure → Content types (or any fieldable entity) → *(bundle)* → Manage
display**.

## How to use it

1. Go to the **Manage display** page of an entity that has an entity-reference
   field (for example **Structure → Content types → Recipe → Manage display**).
2. Set that field's **Format** to the Entity reference pagination formatter.
3. Open the format settings (the gear icon) and set how many items to show per
   page. If you want the "next" link to load the following items automatically,
   ensure the Ajax Link behaviour is in use.
4. Click **Update**, then **Save** the display.

The field now renders the first group of referenced entities with a "next" link to
reveal further groups — manually, or automatically via AJAX.
