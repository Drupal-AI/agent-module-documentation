# Simple Hierarchical Select — manual setup guide

**Simple Hierarchical Select** (`shs`), usually just called **SHS**, replaces the
long, flat taxonomy dropdown on a form with a chain of **cascading select
boxes** — one per level of the hierarchy. Pick a top-level term and a fresh
dropdown appears listing its children; pick one of those and the next level
appears, and so on down the tree. Each level's options are loaded on demand over
AJAX, so even a very deep vocabulary (categories, regions, product types,
country → state → city) stays fast and easy to navigate.

SHS provides a field **widget** (`options_shs`) that you attach to a taxonomy
term-reference field, a matching **formatter** (`entity_reference_shs`) that
displays a stored term together with its full ancestry, and cascading versions of
the core Views taxonomy filters so you can offer the same guided drill-down as an
exposed filter. It respects term publish status, shows translated term names when
content translation is on, and supports multi-value fields (each value gets its
own selector row).

There is **no global settings page** — you configure SHS per field, on the
entity's *Manage form display* and *Manage display* tabs, and per view. One
optional submodule, **SHS Chosen** (`shs_chosen`), layers the Chosen jQuery
plugin on top of the level selects to make them searchable and styled.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the alter hooks,
the AJAX endpoint, and the Backbone theming layer — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and the optional Chosen submodule.

There is no separate configuration page — SHS has no global settings form. See
**How to use it** below for enabling the widget on a field.

## Where it lives in the admin menu

SHS adds no admin menu item or settings form of its own. You configure it in the
places you already manage a field's display:

- **Structure → (content type / entity) → Manage form display** — to turn on the
  cascading widget.
- **Structure → (content type / entity) → Manage display** — to use the ancestry
  formatter.
- In a **View's** filter settings — to expose the cascading filter.

## How to use it

### Turn on the cascading widget

1. You need an **entity-reference** field that points at **taxonomy terms** and
   whose handler targets **exactly one vocabulary**. (SHS deliberately refuses
   fields that target several vocabularies or non-term entities.)
2. Go to **Manage form display** for the entity and, for that field, choose the
   **Simple hierarchical select** widget. For Chosen styling, choose **Simple
   hierarchical select: Chosen** (needs the `shs_chosen` submodule).
3. Optionally open the widget's settings gear and enable **Force selection of
   deepest level**, which requires the editor to drill all the way to a leaf term
   (this is enforced on the server too, not just in the browser).

On the form the field now renders as a chain of dropdowns: choosing a parent term
reveals a new dropdown of its children, and the deepest choice is what's stored.
Multi-value fields get an **Add another item** control that adds another
hierarchical selector row.

> Note: the settings form also lists options to create new terms/levels from
> within the widget, but those are **disabled in this release** — the feature is
> not implemented in 2.0.x.

### Display the selection with its ancestry

On **Manage display**, set the field's formatter to **Simple hierarchical
select** (`entity_reference_shs`). It renders the stored term as its full path
(root → … → selected term) as a list. Its one option, **Link**, wraps each label
in a link to that term's page.

### Use it as a Views exposed filter

SHS enhances the core **"Has taxonomy terms"** and **"Has taxonomy terms (with
depth)"** filters so they can be exposed as the same cascading hierarchical
select. If Search API is installed, its term filter is likewise upgraded. Just add
and expose one of those filters in your view.
