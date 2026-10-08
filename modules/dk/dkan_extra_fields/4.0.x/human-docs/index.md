# DKAN extra fields — manual setup guide

**DKAN extra fields** (`dkan_extra_fields`) makes the individual properties of a
DKAN dataset's JSON metadata available as **extra fields** (pseudo‑fields) that
you can place, order, hide and theme on the node display. DKAN stores dataset
metadata as a single JSON structure mapped to a schema, so properties like
publisher, license, contact, keywords or spatial coverage aren't normally
individual Drupal fields you can drag around in *Manage display*. This module
registers each schema property as an extra field so you can build a tailored
dataset detail page without writing custom Twig or preprocess code.

It handles enum values and multi‑property items with dedicated theme hooks
(`dkan_extra_field`, `dkan_extra_field_enum` and `dkan_extra_field_item`), each
with many theme suggestions, so you can style a property differently per view mode
or relabel a property's key. For finer control over labels and values you can
implement `hook_preprocess_HOOK()` for `dkan_extra_field_item`.

The module is **display‑only**: it has no routes, no permissions and performs no
writes — it simply renders metadata already stored on the entity. One important
setup requirement: it expects a bundled patch, **`4310-plus.patch`**, applied to
DKAN. Apply that patch, enable the module, then arrange the new extra fields on
your content type's display.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, apply the
   required DKAN patch, and enable the module.

There is **no settings form** — setup happens on the content type's *Manage
display* tab, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page. You use it from the DKAN content type's display
settings — for example **Structure → Content types → *(data)* → Manage display**
(`admin/structure/types/manage/data/display`).

## How to use it

1. Make sure the bundled `4310-plus.patch` is applied to DKAN (see
   [Installation](installation/index.md)) and enable the module.
2. Go to the DKAN content type's **Manage display** tab.
3. The dataset's schema properties now appear as extra fields. Drag the ones you
   want into visible regions, reorder them, and hide the ones you don't want
   rendered.
4. For custom output, override the module's theme hooks in your theme, or
   implement `hook_preprocess_dkan_extra_field_item()` to tune labels and values.
5. Repeat per view mode (for example a teaser that shows only a few properties) —
   the display config is exportable per content type.
