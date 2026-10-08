<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the autocomplete widget on a facet

`facets_autocomplete` ships a single Facets widget plugin:

- **id:** `autocomplete`
- **class:** `Drupal\facets_autocomplete\Plugin\facets\widget\AutoCompleteWidget` (extends
  `Drupal\facets\Widget\WidgetPluginBase`)
- **label:** "Textfield with autocomplete"

It is not a new facet type — it is one of the widget choices offered when you edit any existing
facet. Nothing about the facet's source, field, query, or index changes; switching to/from it is a
one-setting change and needs **no re-index**.

## Select it (UI)

Facets UI: *Configuration → Search and metadata → Facets* → edit the facet → in the facet's edit
form set the **Widget** to *Textfield with autocomplete*, then the widget's own settings appear
below. Save.

## Settings

Stored on the facet config entity under `widget.config`. Schema key
`facet.widget.config.autocomplete` (`config/schema/facets_autocomplete.widgets.schema.yml`), which
extends `facet.widget.default_config`.

| Key | Type | Default | Effect |
| --- | --- | --- | --- |
| `show_reset_link` | boolean | `FALSE` | Render a reset link (as the field suffix) that clears the active filter. |
| `reset_text` | label | `Reset` | Text of that reset link. Required in the form when `show_reset_link` is on. |
| `hide_reset_when_no_selection` | boolean | `FALSE` | Only show the reset link while a facet item is active. |
| `default_option_label` | label | `''` | Placeholder text for the text field (HTML `#placeholder`). |
| `show_numbers` | boolean | inherited from Facets base | When on, appends ` (N)` (the result count) to each suggestion and to the shown value. |

`defaultConfiguration()` sets `show_reset_link`, `hide_reset_when_no_selection` and `reset_text`;
`default_option_label` is read defensively (`?? ''`). `show_numbers` comes from the Facets widget
base config.

## Set it without the UI

Drush (facet id shown as `MY_FACET`):

```bash
drush config:set facets.facet.MY_FACET widget.type autocomplete -y
drush config:set facets.facet.MY_FACET widget.config.show_reset_link true -y
drush config:set facets.facet.MY_FACET widget.config.reset_text 'Clear' -y
drush config:set facets.facet.MY_FACET widget.config.default_option_label 'Type to filter…' -y
```

PHP (uses `FacetInterface::setWidget($id, array $config)`):

```php
$facet = \Drupal::entityTypeManager()->getStorage('facets_facet')->load('MY_FACET');
$facet->setWidget('autocomplete', [
  'show_numbers' => TRUE,
  'show_reset_link' => TRUE,
  'reset_text' => 'Reset',
  'hide_reset_when_no_selection' => FALSE,
  'default_option_label' => 'Type to filter…',
]);
$facet->save();
```

## What happens at runtime

`AutoCompleteWidget::build()` (called by Facets when the facet block renders):

1. Iterates `$facet->getResults()` — the results **Facets already computed** from the Search API
   query (so they honour the facet source / search index, including its access filtering; the
   widget does not re-query).
2. For each result that has a URL it fills two maps:
   `autocomplete_values[rawValue] = Html::escape(displayValue) [ + " (count)" ]` and
   `autocomplete_urls[displayValue [+ " (count)"]] = url->toString()`.
3. Attaches the library `facets_autocomplete/drupal.facets_autocomplete.autocomplete-widget` and
   writes to `drupalSettings.facets_autocomplete.autocomplete_widget[<facet_id>]`:
   `results` (the value map), `urls` (label → facet URL), `default_value` (label of the active
   item, if any) and `reset_url`.
4. Renders a core `textfield` element (id and `data-id` = the facet id, class `autocomplete-facet`)
   with the placeholder and, when enabled, the reset link as `#field_suffix`.

`js/autocomplete-widget.js` then does everything else on the client: on each keystroke it keeps
suggestions whose start matches the typed text (prefix match, case-insensitive — `substr(0, len)`,
not a substring/contains search); clicking or Enter-selecting a suggestion sets
`window.location.href` to that value's facet URL (single-select navigation, replacing the current
filter), and the reset link navigates to `reset_url`. The typed string is never sent to the server
for matching.

## Notes / gotchas

- Because the whole value list is filtered in JS, a facet with a very large number of values ships
  all of them in the page's `drupalSettings` — the same set Facets would render in any other widget.
- Prefix-only matching: visitors must know how a value begins. A facet meant for browsing may work
  better as a truncated list than as autocomplete.
- `show_numbers` is part of the label used as the `urls` map key, so the count is part of what the
  JS matches against and displays.
