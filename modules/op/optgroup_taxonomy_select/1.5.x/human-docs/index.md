# OptGroup Taxonomy Select — manual setup guide

**OptGroup Taxonomy Select** (`optgroup_taxonomy_select`) adds a field widget that
renders a taxonomy-term reference field as a grouped HTML `<select>`. Instead of a
long, flat dropdown of every term, the top-level terms of your vocabulary become
non-selectable `<optgroup>` headings, and their child terms become the selectable
options beneath each heading. This makes categorization fields much easier to scan
when a vocabulary has an obvious parent/child structure — for example products
grouped under category headings, or cities grouped under their country.

The widget, called **Optgroup Term Select**, works on any entity-reference field
(most naturally a taxonomy-term one). You assign it on an entity's *Manage form
display* tab — there is no admin settings page, no permissions, and no
configuration object of its own. The module also ships an optional
entity-reference **selection handler** that constrains a field to a single
vocabulary and builds the same grouped, hierarchy-aware, access-filtered list.

One thing to keep in mind: the widget produces **two visual levels only** — a
parent heading and its child options. Deeper trees are flattened under the nearest
top-level parent.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no dedicated admin page. You choose the widget on a bundle's form display
at *Structure → Content types → (your type) → Manage form display* (or the
equivalent Manage form display tab for any entity type).

## How to use it

1. Go to **Manage form display** for the bundle that has your term reference field —
   for a content type, `/admin/structure/types/manage/<bundle>/form-display`.
2. For the taxonomy-term **entity reference** field, change the widget to **Optgroup
   Term Select**.
3. Save. The field now renders as a `<select>` whose top-level terms are `<optgroup>`
   headings and whose child terms are the options.

The widget has no per-instance settings — whether it allows multiple values is
derived from the field's cardinality, and a "- None -" empty option is added for
non-required fields. Unpublished terms are automatically hidden from editors who
lack the *Administer taxonomy* permission, and term labels are safely escaped.

**Optional — single-vocabulary selection handler.** The module also registers an
entity-reference selection plugin (**OptGroup Taxonomy Select**). Choose it in the
field's *Reference type* settings to constrain the field to exactly one vocabulary
and build a grouped, dash-indented options list keyed by parent term.
