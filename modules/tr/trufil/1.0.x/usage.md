<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Trufil (True Exposed Filters) is a Views exposed-form plugin that turns plain exposed filter, sort and pager elements into friendlier widgets (autocomplete, links, radio/select, date pickers, single on/off checkbox, hidden), without any jQuery dependency.
---
It is a fork of the well-known Better Exposed Filters module rebuilt around native HTML5 elements and a plugin architecture. Selecting the "Trufil" exposed form plugin on a View unlocks per-filter widget configuration plus general options such as auto-submit (with configurable delay and text-field exclusion), a "secondary/advanced options" collapsible group, an always-visible reset button, and input-required behaviour. Widgets are provided by three plugin managers — filter, sort and pager — each with its own annotation and base classes, so additional widgets can be contributed.

The module is purely a display/configuration layer for Views: it defines no routes, no permissions and no services beyond the widget plugin managers and a helper, and it performs no data mutation or network access. All configuration happens inside the Views UI (a design/site-builder task gated by Views' own `administer views` permission). Known limitations documented by the project: a core checkboxes bug may need a patch, and multiple exposed filters on the same field can behave unexpectedly.
---
- Enable the "Trufil" exposed form plugin on a View's exposed form settings.
- Render an exposed filter as an autocomplete text field, radios or select.
- Turn radio/select exposed filters into a list of links.
- Provide an option list widget for "List (text)" style fields.
- Use a native HTML5 date picker for date exposed filters.
- Render a numeric exposed filter with a number widget.
- Offer a single on/off checkbox filter.
- Hide an exposed filter element while keeping its value.
- Enable auto-submit so results refresh without a Submit click.
- Configure the auto-submit delay for text fields (default 500ms).
- Exclude text fields from auto-submit while keeping it for selects.
- Hide the Submit button when auto-submit is active.
- Move advanced filters into a collapsible "Advanced options" secondary group.
- Always show a Reset button on the exposed form.
- Require input before a View returns results.
- Choose per-filter widgets independently within one View.
- Apply a friendlier sort widget (links or radios) to exposed sorts.
- Apply a widget to the exposed pager (items-per-page).
- Alter widget options programmatically via `hook_trufil_options_alter`.
- Build a custom widget by extending the filter/sort/pager plugin base classes.