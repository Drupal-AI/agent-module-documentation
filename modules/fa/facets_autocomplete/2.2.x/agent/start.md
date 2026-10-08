<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Facets autocomplete (facets_autocomplete) — agent index

Adds one **Facets widget plugin**, `autocomplete` (class `AutoCompleteWidget`), that renders a
facet as a type-ahead text field instead of a checkbox/link list. All matching happens **client
side** in `js/autocomplete-widget.js`: the widget's `build()` dumps every facet result value (and
its facet URL) into `drupalSettings`, and the JS filters that array by prefix as the visitor types.
There is **no server route, controller, service, or AJAX endpoint** — the module is a widget +
library only.

- Depends on `facets:facets`. Composer: `drupal/facets ^2.0 || ^3.0`, core `^9.2 || ^10 || ^11`.
- **No settings page** (`configure` route is null). The widget is chosen and configured per facet
  inside the Facets UI (`facet.widget.config.autocomplete` schema). No own permissions, drush, or
  hooks that matter to integrators (only trivial `hook_help` / `hook_theme`).

Solution docs:
- **Select & configure the autocomplete widget on a facet** → [configure/widget.md](configure/widget.md)
- **Restyle / extend the front end (library, CSS classes, drupalSettings shape)** → [theme/library.md](theme/library.md)

Key facts:
- Widget plugin id: `autocomplete`; class `Drupal\facets_autocomplete\Plugin\facets\widget\AutoCompleteWidget`
  (annotation label "Textfield with autocomplete").
- Config schema key: `facet.widget.config.autocomplete` (extends `facet.widget.default_config`).
  Own keys: `show_reset_link`, `reset_text`, `hide_reset_when_no_selection`, `default_option_label`;
  plus inherited `show_numbers`.
- Facet config entity: type `facets_facet`, prefix `facets.facet.` — the widget lives under
  `widget.type: autocomplete` / `widget.config`.
- Library: `facets_autocomplete/drupal.facets_autocomplete.autocomplete-widget`.
- drupalSettings root: `drupalSettings.facets_autocomplete.autocomplete_widget[<facet_id>]`
  with `results`, `urls`, `default_value`, `reset_url`.
- It is a **widget**, not a new facet type: switching a facet to/from it changes one setting and
  needs no re-index. Matching is prefix-only and case-insensitive; picking a value redirects to
  that value's facet URL (single-select navigation, not a form submit).
