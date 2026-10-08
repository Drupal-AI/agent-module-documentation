<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Better Parent — menu-parent tree browser (frontend)

The entire module is one asset library attached by one hook. There is no server-side logic beyond
attaching the library; all behavior is in the browser.

## Install / enable

`drush en better_parent`. No configuration, no permissions, no settings route (`configure` is
null). Core requirement `^10 || ^11`; the only runtime dependency is core `jquery`.

## How the library is attached

`better_parent.module` — `better_parent_form_alter(array &$form, FormStateInterface $form_state,
string $form_id): void` (line 15) implements `hook_form_alter()` with **no `$form_id` guard**. It runs:

    $form['scheduler_settings']['#attached']['library'][] = 'better_parent/better_parent';

Notes for anyone reasoning about it:
- The library is appended under the `scheduler_settings` render element, autovivifying that key on
  forms that don't have it. `#attached` bubbles during rendering regardless of the element it sits
  on, so the CSS/JS load on rendered forms; the render system ignores the stray key.
- The JS is self-gating: it does nothing unless `#edit-menu-menu-parent` (core's menu "Parent
  item" select on the node form's menu-settings section) exists on the page.

## Library definition

`better_parent.libraries.yml` defines `better_parent`:
- `js/better_parent.menu.js`
- `css/better_parent.css` (component group)
- dependency: `core/jquery`

## JS / DOM behavior (`js/better_parent.menu.js`)

IIFE over `window.jQuery`. On `$(document).ready`:
1. Locate `menuSelect = $("#edit-menu-menu-parent")`; if absent, no-op.
2. Insert an `#better_parent_item_toggle` link labeled "(browse)" after the select. Clicking it
   calls `_better_parent_item_toggle_control()`.

Toggle (`_better_parent_item_toggle_control`): builds the tree once (lazy), then swaps visibility —
hides the native `<select>` and shows `#better_parent_item` (label → "(select)"), or reverses it
(label → "(browse)"). `_better_parent_item_pre_select()` opens the branches down to the currently
selected option, marks it, and scrolls it into view.

Tree build (`_better_parent_item_setup`): iterates the select's `<option>` elements. Nesting depth
is derived from the leading dashes in each option label — `_better_parent_item_determine_level()`
matches `/^-+\s/` and computes `(len-1)/2`; `_better_parent_item_clean_label()` strips the dashes
for display. It assembles a nested `<ul id="better_parent_item">` with `<li>`/`<a>` nodes whose `id`
is the option value. Clicking a tree `<a>`:
- clears any prior `.selected`, marks this one `.selected`;
- writes the value back with `select.val(anchor.attr("id"))` — the native select remains the source
  of truth submitted with the form;
- if the node has children, slide-toggles the child `<ul>` and toggles the `.opened` class.
Nodes with children get `.hasChildren`; all `<ul>` start hidden.

## Styling (`css/better_parent.css`)

Styles `#better_parent_item` (200px scrollable list), the toggle link, and tree rows. Row icons use
`images/menu-leaf.gif` (leaf), `menu-collapsed.gif` (`.hasChildren`), and `menu-expanded.gif`
(`.opened.hasChildren`). `.selected` rows are bold.

## Operating notes

- Nothing to configure; the enhancement appears on the node menu-settings section automatically.
- It changes only presentation. The submitted value is whatever the underlying core select holds,
  so removing the module leaves the plain dropdown with no data migration.
- The tree is built from labels core already rendered (indentation dashes). If a theme/module
  changes those option labels' dash convention, the depth inference degrades to a flatter tree.
