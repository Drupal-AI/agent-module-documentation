# Grouped checkboxes — manual setup guide

**Grouped checkboxes** (`grouped_checkboxes`) provides a form widget that groups
checkboxes by their parent — most usefully, taxonomy term checkboxes grouped under
their vocabularies. Instead of one long, flat list of options, editors get tidy,
collapsible sections, which makes selecting from hierarchical or grouped options far
easier.

Terms are grouped into their vocabularies, and vocabularies with nothing selected
stay collapsed by default, so a form with many options stays manageable. If the
field is multi‑value it uses checkboxes; if it's single‑value it uses radios.

It's a content‑editing convenience that only affects how options are *presented* —
it doesn't change the options themselves, the stored data, or access in any way.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no settings page** for this module. You use it by picking its widget on
a field's form display, described below.

## How to use it

1. Add an **entity reference** field and set its target entity type to **Taxonomy
   term**.
2. Configure the allowed vocabularies as usual on the field settings.
3. Go to the entity's **Manage form display** and change the field's widget to
   **Grouped checkboxes/Radios**.

That's all. If the field is multi‑value, the widget renders grouped checkboxes; if
single‑value, grouped radios. Terms appear neatly grouped by vocabulary, with empty
vocabularies collapsed.
