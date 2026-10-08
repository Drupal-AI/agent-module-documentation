# Term Reference Tree — manual setup guide

**Term Reference Tree** (`term_reference_tree`) replaces the plain checkbox or
select widget on a taxonomy term-reference field with a hierarchical,
expand/collapse **checkbox tree** that mirrors the vocabulary's parent-child
structure. Editors pick terms in context — drilling into branches — instead of
scanning a flat list. It also ships a matching field **formatter** that renders the
selected terms back to visitors as a nested tree.

Both the widget (id `term_reference_tree`, "Term reference tree") and the formatter
(id `term_reference_tree`, "Term Reference Tree") apply to `entity_reference`
fields — in practice taxonomy term reference fields. On a multi-value field, one
tree collects every value; on a single-value field the tree renders as radio
buttons instead of checkboxes. The tree is built from whatever vocabularies the
field's reference settings allow, so restricting a field's target vocabularies
controls what the tree shows.

The widget has several per-field settings — collapse the tree by default, allow
only leaf terms, auto-select ancestors, add a select-all control, cascade a parent
toggle down to its children, and cap the tree's depth — all configured on the
field's *Manage form display*. There is **no global settings form**, no
permissions, and no Drush commands; everything lives in the field-display
configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

Term Reference Tree has no menu item or settings form. You use the **widget** from
a bundle's **Manage form display** tab (for example **Structure → Content types →
*(your type)* → Manage form display**) and the **formatter** from the matching
**Manage display** tab.

## How to use it

### The tree widget (editing)

1. Make sure you have an **entity-reference field that targets taxonomy terms** on
   your content type. The widget only appears for entity-reference fields — not
   text, number, or other field types.
2. Go to **Manage form display** for that bundle.
3. In the **Widget** column for your term-reference field, choose **Term reference
   tree**.
4. Click the gear/cog icon to open the widget settings and adjust any of these:
   - **Start minimized** *(default on)* — render the tree collapsed by default, so
     a long vocabulary keeps the form compact.
   - **Leaves only** *(default off)* — only terms with no children are selectable,
     preventing editors from tagging with broad parent categories.
   - **Select parents** *(default off)* — automatically include a term's ancestors
     whenever it is selected (useful for faceted navigation). *Only available on
     unlimited-cardinality fields.*
   - **Select all** *(default off)* — add a check/uncheck-all control. *Only on
     unlimited-cardinality fields.*
   - **Cascading selection** *(default none)* — when a parent is toggled, cascade
     the change to its children: *none*, *select + deselect*, *only on select*, or
     *only on deselect*. *Only on unlimited-cardinality fields.*
   - **Max depth** *(default 0 = unlimited)* — show terms only this many levels
     deep, so editors choose among high-level categories rather than every
     micro-term.
5. Click **Update**, then **Save** the form display.

On a single-value field the tree shows radio buttons, and the three
unlimited-cardinality-only options (select parents, select all, cascading
selection) do not apply.

### The tree formatter (display)

To show the selected terms back to visitors as a nested tree, go to the bundle's
**Manage display**, and in the **Format** column for the same field choose **Term
Reference Tree**. The formatter has no settings. Pairing the tree widget (input)
with the tree formatter (display) gives a consistent hierarchical look on both the
edit form and the rendered page.

### In custom forms

Developers can reuse the underlying `checkbox_tree` render element directly in a
custom form to build a hierarchical taxonomy selector without a field. See the
[agent API doc](../agent/api/render.md) for the element properties and a code
example.
