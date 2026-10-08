# Entity Reference Views Select — manual setup guide

**Entity Reference Views Select** (`entity_reference_views_select`) adds two form
widgets that render an entity‑reference field — one whose allowed values come from
a **View** — as a **select list**, or as **checkboxes / radio buttons**, on entity
forms. The clever part is that each option is drawn using the View's own row
output, so the choices in the form look exactly like what the View would display
elsewhere: an image and title, a rendered teaser, whatever the View produces.

Drupal core already lets an entity‑reference field use a View as its "reference
method," but out of the box it only offers autocomplete or tag‑style widgets for
entering values. This module fills the gap by turning that same View‑backed field
into a fixed set of options, which is ideal when the referenceable set is known
and short — a curated list of featured articles, a subset of taxonomy terms, a
handful of related content items. It even lets a View's contextual filters scope
which options appear.

There is nothing to install beyond enabling the module, and **no settings page,
permission, or configuration entity of its own**. You simply pick one of the two
widgets on a bundle's *Manage form display*. If a field is not actually using a
View as its reference method, the widgets fall back gracefully to a standard
select or checkbox.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The module adds no menu items or settings page. Its two widgets appear in the
widget dropdown on each bundle's **Manage form display** page (for example
`/admin/structure/types/manage/article/form-display`).

## How to use it

1. **Make the field use a View.** On the entity‑reference field's settings, set the
   **Reference method** to *Views: Filter by an entity reference view*, then pick
   the View and display that supplies the options. (You will need an existing
   "Entity Reference" View display to choose here.)
2. **Assign the widget.** Go to the bundle's **Manage form display**
   (`/admin/structure/types/manage/<bundle>/form-display`) and, for that field,
   choose one of:
   - **Entity Reference Views Select list** — renders a single‑select drop‑down.
     It has one setting, **Empty value** (default "- None -"), shown for optional
     fields.
   - **Entity Reference Views Check boxes/radio buttons** — renders radio buttons
     for a single‑value field, or checkboxes for a multi‑value field.
3. **Save.** On the entity form, the field now shows the View's rows as selectable
   options — the referenced entity's ID is the stored value, and the View's
   rendered row is the label.

You can vary the widget per form mode (for example a select on the default form
and checkboxes on a custom mode). No code is required.
