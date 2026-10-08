# Dependent List — manual setup guide

**Dependent List** (`dependent_list`) lets you build conditional (cascading) list
fields, where the options offered in one field depend on the value chosen in
another. Pick "Acquisition" as an event's main type and the subtype field shows
Auction, Bequest, Purchase; pick "Appropriation" and it shows Colonial
appropriation, Confiscation, Destruction instead. It's the classic
country → city pattern, applied to any pair of list fields on your content.

It works with core list field types (`list_string`, `list_integer`,
`list_float`) and supports both select dropdowns and radio/checkbox widgets. When
the parent field changes, the child field's options are filtered in real time via
AJAX. Under the hood it depends on core's **Options** and **Field UI** modules,
both of which Drupal enables automatically as dependencies.

There is no central settings page — you configure a dependency directly on the
child field's settings, in Field UI. This is purely a content-editing convenience:
it shapes which options an editor is offered and the value that gets stored; it has
no access-control role.

> **Testing note from the maintainers:** the module has been tested primarily with
> dropdown (select) lists. Radio buttons and checkboxes may not be fully tested —
> use those widgets at your own discretion.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. Dependencies are configured
per field, in Field UI, as described below.

## Where it lives in the admin menu

Dependent List adds no admin page of its own. You set everything up under
**Structure → Content types → *(your type)* → Manage fields** when editing a
list field.

## How to use it

1. **Create two list fields** on your content type (or other fieldable entity) —
   a *parent* field (for example "Country") with its allowed values, and a *child*
   field (for example "City") that lists every possible value.
2. **Make the child field dependent.** Go to **Structure → Content types →
   *(your type)* → Manage fields**, edit the child field, and open its
   **Dependent list configuration** section.
3. **Choose the dependency field** (the parent, e.g. "Country"), then in the table
   that appears, tick which child options should be shown for each parent value.
   Save the field.
4. **Author content.** When an editor creates or edits content, they choose a
   value in the parent field first, and the child field's options update
   automatically to match.
