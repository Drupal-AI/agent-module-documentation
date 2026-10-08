# Field Fallback — manual setup guide

**Field Fallback** (`field_fallback`) lets you nominate one field as the
**fallback** for another. When the primary field is left empty, Drupal uses the
value of the fallback field in its place. It works with all field types.

The classic example is images. Say a content type has a *header image* shown on
the node page and a *teaser image* shown in listings. Editors reliably fill in
the header image but often skip the teaser image. Configure the teaser image to
fall back to the header image, and any node without a teaser image simply reuses
its header image in the overview — while an editor who *does* want a different
teaser (perhaps because the header is portrait and the listing needs landscape)
can still upload one to override the fallback.

Because a fallback value is just another field on the same entity, this is a
display/content convenience with essentially no new access surface — the fallback
value is subject to its own field access. Still, it is worth confirming that the
field you choose as a fallback is an appropriate source and that its visibility
matches the field it stands in for.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (note the optional Paragraphs‑related dependencies).

There is **no site‑wide configuration page** for this module. You choose a
fallback per field, on the field's own settings, described below.

## Where it lives in the admin menu

Field Fallback adds no admin page of its own. You configure a fallback on the
field itself: create or edit a field through Field UI — for a node field,
**Structure → Content types → *(type)* → Manage fields → *(field)* → Edit** —
and the module adds a dropdown listing the fields that can serve as a fallback.

## How to use it

1. Go to the field that should have a fallback (the *teaser image*, in the
   example above) and open its settings via **Manage fields → Edit**.
2. In the **fallback field** dropdown the module adds, choose the field whose
   value should be used when this one is empty (the *header image*).
3. Save the field settings.
4. From then on, whenever content leaves the primary field empty, its fallback
   field's value is used instead; filling in the primary field overrides the
   fallback as normal.
