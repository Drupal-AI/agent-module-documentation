# Entity Reference Field Autocomplete Filter — manual setup guide

**Entity Reference Field Autocomplete Filter**
(`entity_reference_field_autocomplete_filter`) adds a new entity-reference field
widget — **Filterable Autocomplete** — that narrows the autocomplete results by
bundle. It pairs the usual autocomplete box with a select list so an editor can
first choose a bundle and then only see matching referenced entities in the
suggestions.

The problem it solves is choosing from a reference field that can point at
several bundles. When a field allows, say, three content types, a plain
autocomplete mixes all of them together; this widget lets the editor scope the
search to one bundle at a time, so the options stay context-appropriate and the
right item is easier to find.

It is a site-building/fields feature and needs no global configuration — you set
it up per field on the *Manage form display* page. The underlying reference
still respects the field's target and selection settings, so the widget only
narrows what is already allowed; it has no access-control role. The module has no
additional module or library requirements.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form.
Setup happens on your reference field's form display, described in "How to use
it" below.

## Where it lives in the admin menu

The module adds no admin page. You use it from **Structure → Content types (or
other bundles) → *(bundle)* → Manage form display**, by choosing the
**Filterable Autocomplete** widget for a reference field.

## How to use it

1. Go to the host bundle's **Manage form display** and find your
   entity-reference field.
2. Change its **Widget** to **Filterable Autocomplete** and **Save**.
3. On the entity edit form, the field now shows a bundle select alongside the
   autocomplete box: pick a bundle to restrict the autocomplete suggestions to
   entities of that bundle.
