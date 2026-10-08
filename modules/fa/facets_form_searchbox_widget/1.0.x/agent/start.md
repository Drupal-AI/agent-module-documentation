<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Facets Form Searchbox Widget (facets_form_searchbox_widget) — agent index

Adds one **Facets widget plugin** that renders a facet as form checkboxes inside a **Facets Form** and puts a
client-side searchbox above the list to filter values as the visitor types. Display-layer only. Package `Custom`.
License GPL-2.0-or-later. Version `1.0.x` (installed as a dev checkout — info.yml has no `version:`).
Core `^9.2 || ^10.0 || ^11`.

## Dependencies

- `facets:facets` — the Facets framework (provides the widget plugin type and the base rendering this extends).
- `facets_form:facets_form` — provides `FacetsFormWidgetInterface`, `FacetsFormWidgetTrait`, and the
  `CheckboxWidget` this plugin subclasses so the facet renders as a submitted form element.

No composer.json ships with the module; `composer_requirements` is empty. No PHP library dependencies.

## What it provides (from source)

- **One widget plugin**: `Drupal\facets_form_searchbox_widget\Plugin\facets\widget\SearchableFormCheckboxWidget`
  (id `facets_form_searchable_checkbox`, label *"Searchable Checkboxes (inside form)"*), extending
  `Drupal\facets_form\Plugin\facets\widget\CheckboxWidget`. Builds a fieldset containing a searchbox textfield,
  the `#type => checkboxes` list, a hidden "No results found." message, and hidden "Show more" / "Show less"
  links. Adds a **Soft limit** select to the widget config form. → [plugins/searchable-form-checkbox-widget.md](plugins/searchable-form-checkbox-widget.md)
- **One asset library** `facets_form_searchbox_widget/searchable_facets` (`.libraries.yml`): `js/searchable-facets/scripts.js`
  + `css/searchable-facets.css`, depending on `core/drupalSettings`, `core/jquery`, `core/drupal`. The JS behavior
  filters the checkbox rows on keyup and enforces the JavaScript soft limit. → [behavior/rendering.md](behavior/rendering.md)
- **Three Twig templates** + `hook_theme()`, `hook_theme_suggestions_alter()`, `hook_theme_suggestions_input_alter()`
  in `facets_form_searchbox_widget.module` that supply the markup and theme suggestions for the widget.
  → [behavior/rendering.md](behavior/rendering.md)

## What it does NOT provide

No routes, controllers, permissions, forms of its own, config objects, **config schema** (no `config/schema/`),
`config/install`, entities, services, or Drush. `configure` is null. The one setting (`soft_limit`) is stored in
the facet entity's widget configuration by the Facets module. It has no access-control role — it only changes how a
facet is displayed; result access still follows the search index.

## Install / operate

1. `composer require drupal/facets_form_searchbox_widget` (needs `facets` + `facets_form` enabled).
2. `drush en facets_form_searchbox_widget -y`.
3. Edit a facet at **Configuration → Search and metadata → Facets** that is presented through a Facets Form and
   choose the **"Searchable Checkboxes (inside form)"** widget; set its *Soft limit*; save and clear caches.
