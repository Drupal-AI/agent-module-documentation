<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Widget plugin `range_input` (RangeInputWidget)

File: `src/Plugin/facets/widget/RangeInputWidget.php`
Class: `Drupal\facets_range_input\Plugin\facets\widget\RangeInputWidget extends WidgetPluginBase implements ContainerFactoryPluginInterface`
Annotation: `@FacetsWidget(id = "range_input", label = "Range Input", description = "A widget that creates two input forms for min and max to create a range.")`

## Purpose

The widget the site builder selects on a numeric facet so it renders as a min/max range form instead of a list of
discrete facet links. It injects the `form_builder` service (`create()` / constructor) to build the AJAX form.

## Configuration (per-facet widget settings)

`defaultConfiguration()` returns four string keys (merged over the parent):

- `minimum_title` = `Minimum`
- `maximum_title` = `Maximum`
- `minimum_placeholder` = `Min`
- `maximum_placeholder` = `Max`

`buildConfigurationForm()` exposes each as a `#type => textfield` (labels "Minimum - title", "Maximum - title",
"Minimum - placeholder", "Maximum - placeholder"). These are persisted under the facet entity's widget config and
typed by schema `facet.widget.config.range_input` (extends `facet.widget.default_config`) in
`config/schema/facets_range_input.schema.yml`; all four are `type: label`.

## build()

`build(FacetInterface $facet)`:

1. `parent::build()`, then `$facet->getResults()` + `ksort()`. If there are **no results**, returns the parent
   build unchanged (it needs at least one result URL as a template).
2. Takes the first result and `getUrl()->toString()` as the base URL — this is the facet's own routed URL
   produced by the Facets URL generator (see [processor.md](processor.md) `build()` which sets result URLs to a
   placeholder token URL).
3. Attaches library `facets_range_input/rangeInput`.
4. Reads `$facet->getActiveItems()`; if `$active[0][0]` / `$active[0][1]` are set, copies them into
   `drupalSettings.facets.rangeInput[<facetId>].currentValues.minimum|maximum` so the JS can re-populate the
   inputs. Also sets `facetId` and `url` in that drupalSettings bucket.
5. Sets `#theme = 'facets_range_input'`, builds the form via
   `$this->formBuilder->getForm(new RangeInputForm($facet, $this->getConfiguration()))` into `$build['form']`, and
   sets `$build['type']` to a `#markup` of the widget type with underscores swapped for hyphens.

## getQueryType()

Returns `'range'`. Filtering is therefore delegated to the Facets **range query type** — this module builds **no
database query of its own**. The bounds reach that query type as the parsed active item (see
[processor.md](processor.md) `preQuery()`), which is constrained to numeric characters.

See [../forms/range-input-form.md](../forms/range-input-form.md) for the form, JS and templates.
