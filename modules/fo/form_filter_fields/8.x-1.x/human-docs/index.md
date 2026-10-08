# Form Filter Fields — manual setup guide

**Form Filter Fields** (`form_filter_fields`) creates dependent‑field
relationships on content and media edit forms, so the options shown in one
select field are filtered by the value an editor picked in another,
"controlling" field. It's the classic *Country → State* or *Manufacturer →
Model* pattern: choose the parent, and the child list narrows to only the
choices that make sense.

What makes this module distinctive is that **a View does the filtering**. You
build a View that takes a term ID from the controlling field as a contextual
filter and outputs the allowed options for the target field. Because the logic
lives in a View, you order, group, and constrain the results however you like —
and you can drive several dependent fields at once, which is where the module
was created to go beyond what Business Rules could do.

It works with select lists, radio buttons, checkboxes, and select2‑style
widgets, on both node and media bundles. One documented limitation: it does
**not** work with Inline Entity Form (IEF), which builds forms through a
different mechanism. Also keep in mind that the filtering is an editorial
convenience applied to the form's option set — it is not a server‑side security
boundary, so don't rely on it alone to reject out‑of‑range submitted values.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — build the View and define each
   field dependency in the admin UI, field by field.

## Where it lives in the admin menu

Dependencies are managed at **Configuration → Content authoring → Form Filter
Fields** (`/admin/config/content/form_filter_fields`), which requires the
**Administer site configuration** permission. See
[Configuration](configuration/index.md) for the full walkthrough.
