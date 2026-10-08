<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Facets Range Input (facets_range_input) — agent index

Adds a **min/max range-input widget** and a companion **processor** to the [Facets](https://www.drupal.org/project/facets)
module, so a numeric facet is filtered by a lower/upper bound instead of a list of discrete values. Package
`Search`. License GPL-2.0-or-later. Version **2.0.0-alpha6** (pre-release). Core `^10.1 || ^11`.

## Dependencies

- `facets:facets` — provides `WidgetPluginBase`, `ProcessorPluginBase`, the `range` query type, the
  `url_processor_handler` / `facets.utility.url_generator`, and the facet entity this module plugs into.
  Composer `drupal/facets:^2.0`. No third-party PHP/JS library requirements.

## What it provides (from source)

- **Facets widget plugin** `range_input` — `src/Plugin/facets/widget/RangeInputWidget.php`
  (`RangeInputWidget extends WidgetPluginBase`). Renders the AJAX min/max form, attaches
  `facets_range_input/rangeInput`, declares query type `range`. → [plugins/widget.md](plugins/widget.md)
- **Facets processor plugin** `range_input` — `src/Plugin/facets/processor/RangeInputProcessor.php`
  (pre_query 60 / post_query 60 / build 20). Builds the placeholder range URL, parses the active bound
  (numeric-only regex), synthesises step results. → [plugins/processor.md](plugins/processor.md)
- **Form** `facets_range_input_form` — `src/Form/RangeInputForm.php` (`RangeInputForm extends FormBase`),
  two `#type => number` fields + AJAX Apply. → [forms/range-input-form.md](forms/range-input-form.md)
- **JS** `js/range-input.js` — `Drupal.behaviors.rangeInput` + jQuery `facetsRangeInputFilter` helper that
  substitutes the bounds into the facet URL and triggers a Facets refresh. → [forms/range-input-form.md](forms/range-input-form.md)
- **Two Twig templates** registered by `hook_theme` (`src/Hook/ThemeHooks.php`, autowired service +
  `#[LegacyHook]` wrapper in `.module`): `facets_range_input` (`facets-range-input.html.twig`) and
  `facets_range_input_form` (`facets-range-input-form.html.twig`). → [forms/range-input-form.md](forms/range-input-form.md)
- **Config schema** `facet.widget.config.range_input` (`config/schema/facets_range_input.schema.yml`) — the
  four per-widget label settings. → [plugins/widget.md](plugins/widget.md)
- **Library** `facets_range_input/rangeInput` (`.libraries.yml`): `css/range-input.css` (layout) + `js/range-input.js`.

## What it does NOT provide

No routes, no controllers, no permissions, no `*.links.*`, no entities, no Drush, no `config/install`. `configure`
is null — the only configuration is the per-facet widget settings edited on the Facets facet edit form. It never
builds its own database query; range filtering is delegated to the Facets `range` query type.

## Install / operate

1. `composer require drupal/facets_range_input` (pulls `drupal/facets:^2.0`).
2. `drush en facets_range_input -y`.
3. On a **numeric** facet's edit form (Configuration → Search and metadata → Facets), pick the **Range Input**
   widget; optionally set the min/max titles and placeholders. Also enable the **Range Input** processor on the
   same facet if the intermediate step results / URL rewriting are needed.

Note: the installed release is a **pre-release** (`2.0.0-alpha6`).
