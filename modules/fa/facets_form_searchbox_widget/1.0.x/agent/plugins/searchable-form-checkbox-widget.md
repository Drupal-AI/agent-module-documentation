<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `facets_form_searchable_checkbox` widget plugin

File: `src/Plugin/facets/widget/SearchableFormCheckboxWidget.php`
Class: `Drupal\facets_form_searchbox_widget\Plugin\facets\widget\SearchableFormCheckboxWidget`
extends `Drupal\facets_form\Plugin\facets\widget\CheckboxWidget`
implements `FacetsFormWidgetInterface`, `ContainerFactoryPluginInterface`; uses `FacetsFormWidgetTrait`.

## Plugin definition

`@FacetsWidget(id = "facets_form_searchable_checkbox", label = "Searchable Checkboxes (inside form)", description = "A configurable widget that shows checkboxes as a form element and provides a search input.")`.
Because it implements `FacetsFormWidgetInterface`, Facets Form lists it as a selectable widget for facets rendered
through a Facets Form. It defines no plugin type of its own — it is one instance of the Facets widget type.

## Construction

`create()` injects the `renderer` service; the constructor calls `parent::__construct(...)` (CheckboxWidget also
takes the renderer) and stores `$this->renderer`. The renderer is inherited from the parent; this subclass does not
call it directly.

## build(FacetInterface $facet)

1. Gets processed checkbox items from `parent::build($facet)[$facet->getFieldIdentifier()]` and runs
   `$this->processItems($items, $facet)` (from `FacetsFormWidgetTrait`).
2. Iterates `$this->processedItems` to assemble `$options` (value → label), `$default_value` (checked values),
   `$depths`, `$ancestors`, and `$options_attributes`. Any item at index `>= soft_limit` gets
   `class => ['facets-soft-limit-checkbox']`.
3. Returns a render array keyed by `$facet->id()` whose root is a **fieldset**:
   - `#title` = the facet name when `show_title` is set, else NULL.
   - `#access` = `!empty($this->processedItems) && !$facet->getOnlyVisibleWhenFacetSourceIsVisible()`.
   - `#attributes`: `data-drupal-facets-form-ancestors` = `Json::encode($ancestors)`,
     `data-drupal-facet-id` = `$facet->id()`, `data-soft-limit` = the configured soft limit, and
     class `facets-form-searchable-checkbox`.
   - `facets_widget_searchbox_label` — `#markup` (via `Markup::create()`) a `<label>` (id `label_<facetid>`,
     for `<facetid>`, interpolating `$facet->id()`) with the translated text *"Search"*.
   - `facets_widget_searchbox` — `#type => textfield`, id `<facetid>`, class
     `facets-form-searchable-checkbox-searchbox`, `aria-labelledby => label_<facetid>`, placeholder *"Search"*.
     This is the client-side filter box (see [../behavior/rendering.md](../behavior/rendering.md)); it is not a
     submitted value.
   - `<facetid>` — `#type => checkboxes` with `#options`, `#options_attributes`, `#default_value`,
     `#disabled` = `disabled_on_empty && empty($items)`, `#after_build => [[static::class, 'indentCheckboxes']]`
     (indentation helper from the parent/trait), plus `#depths`, `#ancestors`, `#indent_class`. The facet labels
     are the standard Form API `#options` values.
   - `facets_no_results` — `#markup` `<div class="no-results-message hidden">No results found.</div>`.
   - `facets_show_more` / `facets_show_less` — `#markup` hidden `<a>` links ("Show more" with a count span /
     "Show less").

## buildConfigurationForm()

Calls `parent::buildConfigurationForm()` then adds:

- `soft_limit` — `#type => select`, title *"Soft limit"*, options `[0 => 'No limit'] + [50,40,30,20,15,10,5,3]`,
  description *"Limit the number of displayed facets via JavaScript."*
- `soft_limit_settings` — an empty `#type => container`, hidden via `#states` when `soft_limit` is 0.

The chosen `soft_limit` is persisted in the facet entity's widget configuration by Facets; this module ships no
config object or schema for it.

## prepareValueForUrl()

`return array_keys(array_filter($form_state->getValue($facet->id(), [])));` — turns the checked checkboxes into the
list of active facet values the Facets Form submits to the query. This is the `FacetsFormWidgetInterface` contract.
