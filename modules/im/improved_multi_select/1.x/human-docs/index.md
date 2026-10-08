# Improved Multi Select — manual setup guide

**Improved Multi Select** (`improved_multi_select`) replaces Drupal's default,
awkward `<select multiple>` boxes with a friendly **two‑panel "dual list box"**
widget. Instead of ctrl‑clicking items in a cramped scroll list, editors get an
*available* panel on one side, a *selected* panel on the other, add/remove buttons
between them, a search box to filter long lists, and (optionally) up/down buttons
to reorder their choices.

It is a purely front‑end enhancement: it adds no field type or widget of its own
(in the base module) and doesn't change what gets stored — it just restyles the
multi‑selects that are already on your forms. You decide where it applies from a
single settings page: enhance **every** multi‑select on the site, only certain
**paths**, or only elements matching specific **CSS/jQuery selectors**. From the
same page you tune the search/filter behaviour and the button labels.

Because it only changes the widget's appearance, the visual order a user arranges
in the *selected* panel is not persisted by an ordinary list or entity‑reference
field. If you need the chosen order saved onto the entity, enable the bundled
**IMS Options Widget** submodule, which provides a real field widget for that.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and the optional IMS Options Widget submodule.

## Where it lives in the admin menu

The settings page is at **Configuration → User interface → Improved Multi Select**
(`/admin/config/user-interface/ims`). It is gated by core's **Administer site
configuration** permission — the module defines no permission of its own.

## How to use it

After enabling the module, open the settings page and decide **when** the widget
should replace multi‑selects. The module activates on the first of these that is
true:

- **Replace all multi‑select lists** — turn the enhancement on for every
  `<select multiple>` on every page.
- **Paths** — list request paths (one per line, `*` wildcard and `<front>`
  supported) to activate on, for example `/node/*/edit`.
- **Selectors** — list jQuery/CSS selectors (one per line) to target specific
  fields, for example `#edit-field-tags` or `select[multiple]`.

Then tune the experience with the remaining options:

- **Placeholder text** — the hint shown in the search box.
- **Filter type** — how the search matches: *partial* (default), *exact*, *any
  words*, *any words (partial)*, *all words*, or *all words (partial)*. The
  non‑partial modes require whole‑word matches.
- **Allow JS regular expressions** — let power users filter with regular
  expressions.
- **Orderable** — show *Move up* / *Move down* buttons and keep the order items
  were added.
- **Clear the filter on group select** — reset the search when an option group is
  chosen (rather than cross‑filtering).
- **Remove the required attribute** — strip the HTML5 `required` attribute from the
  hidden underlying select so server‑side validation still works.
- **Button labels** — customise the glyphs/text for Add (`>`), Add all (`»`),
  Remove (`<`), Remove all (`«`), and (when orderable) Move up / Move down.

Save the form and reload a page with a multi‑select to see the two‑panel widget.

### Persisting the chosen order

A normal list/entity‑reference field will not remember the order shown in the
*selected* panel. To store that order on the entity, enable the **IMS Options
Widget** submodule and use its field widget on the field's *Manage form display*.
