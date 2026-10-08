# Formatter field — manual setup guide

**Formatter field** (`formatter_field`) adds a special kind of field whose value
*is a formatter choice*: you attach it to an entity, point it at another field,
and an editor picks how that other field is displayed on this particular entity.
Normally Drupal decides display per **bundle and view mode** — which is the right
default, but occasionally the wrong granularity.

The README's own example says it best. A "page" content type with an image field
usually uses one image style for every page. But sometimes an individual page
needs a different treatment — a full‑width hero here, a small thumbnail there — and
the only built‑in answers are to create a new view mode, a new bundle, or a
preprocess hack. Formatter field turns that choice into a **field value**,
editable right on the node form like any other field. Because the choice is stored
on the entity, it is revisioned and translatable in the usual way, and it's
visible to editors rather than buried in Manage display.

Under the hood the module provides a `FormatterItem` field type, a widget for
choosing a formatter and its settings, and a "Formatter from field" display
formatter that renders the target field using whatever was chosen.

The judgement to make is **editorial governance**. Handing display control to
editors is a deliberate loosening of the design system — exactly right for a
marketing landing page, and wrong for a strictly templated catalogue where a
hundred entities each choosing their own style will drift. Scope it to the bundles
that genuinely need it, and limit the formatters and settings the widget exposes
so choices stay within the design.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central configuration page** — you set everything up on the fields
themselves, as described in "How to use it" below.

## Where it lives in the admin menu

Formatter field adds no admin settings page. You work with it entirely in the
Field UI: **Structure → Content types → *(bundle)* → Manage fields**, then the
matching **Manage form display** and **Manage display** tabs.

## How to use it

1. Add the field you want to be **dynamically formatted** (for example an image
   field) to your entity bundle, as usual.
2. Add a **Formatter field** to the same bundle, just like any other field.
3. In the **Formatter field's instance settings**, choose which field it will
   control (the field from step 1).
4. On the bundle's **Manage display**, set the field to be formatted to use the
   **"Formatter from field"** formatter, and in that formatter's settings choose
   the correct Formatter field as its source.

Now, when an editor creates or edits an entity of that bundle, they can pick the
formatter (and its settings) for that field on this specific entity — for
instance, a full‑width image on one page and a thumbnail on another, with no new
view mode or bundle required.
