# Length Indicator — manual setup guide

**Length Indicator** (`length_indicator`) adds a small colored bar beneath a text
field's edit widget that shows editors, live as they type, whether what they've
written is too short, acceptable, optimal, or too long — measured against a target
range you configure. It's a gentle editorial nudge rather than a hard limit:
nothing is blocked, values are stored exactly as typed, and the front-end display
is untouched. It's perfect for coaxing SEO page titles, meta-description-style
summaries, teaser text, and headlines toward a house-style length.

The module is deliberately minimal. It has no field type, no admin settings page,
no permissions, and no plugins of its own. Instead it plugs into the **Manage form
display** page, adding a "Length indicator" option to the two supported core text
widgets — **Textfield** (`string_textfield`) and **Text area (multiple rows)**
(`string_textarea`). Turn it on for a field, set your target numbers, and the
colored bad/ok/good/ok/bad bar appears under that field on the edit form.

Because the settings are stored as part of the form-display configuration, they
travel with your exported config and can be tuned per form mode — for example on
the default edit form but not a custom one.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — turning the indicator on for a field
   and setting its three length numbers, field by field.

## Where it lives in the admin menu

There's no central settings page. You enable and tune the indicator per field on
each bundle's **Manage form display** page — for example **Structure → Content
types → Article → Manage form display**
(`/admin/structure/types/manage/article/form-display`).

## How to use it

In short: open the relevant Manage form display page, click the gear/cog on a
Textfield or Text area field, tick **Length indicator**, and set your target
range. The full field-by-field walkthrough is on the
[Configuration](configuration/index.md) page.
