# Field Sample Value — manual setup guide

**Field Sample Value** (`field_sample_value`) lets you configure a **sample value
generator per field**, so that when Drupal needs plausible placeholder data — for
demo content, previews, or default content — your fields are filled with something
sensible instead of generic filler. It adds options to the field configuration
page where you pick how a sample value for that field is produced.

It's a site‑building and development convenience with no front‑end behavior of its
own. The sample values are administrator‑configured and only come into play when
something generates content; they aren't shown to end users in production unless
the generated content is actually published.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central configuration page** for this module. You set the sample
value generator directly on each field, described in "How to use it" below.

## How to use it

1. Go to **Structure → Content types → *(your type)* → Manage fields** (or the
   Manage fields screen of any fieldable entity).
2. Edit the field you want to seed with sample data.
3. On the field's configuration page, use the **Field Sample Value** options to
   choose the sample value generator for that field.
4. Save the field. From then on, whenever sample/default content is generated for
   that entity, the field is filled using the generator you selected.

Because these values feed content generation rather than live pages, enable the
feature deliberately on the fields where realistic demo data helps, and leave it
off elsewhere.
