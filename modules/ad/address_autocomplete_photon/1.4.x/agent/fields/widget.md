<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The address autocomplete element, widget & client behavior

## Form element: `address_autocomplete`

`src/Element/AddressAutocomplete.php` — `#[FormElement('address_autocomplete')]`, extends
`\Drupal\address\Element\Address`. Use it directly in a form:

```php
$form['address'] = [
  '#type' => 'address_autocomplete',
  '#default_value' => [ /* address components */ ],
  '#allow_overrides' => FALSE,
  '#available_countries' => ['DE', 'FR'],
];
```

`getInfo()` adds one extra property, `#allow_overrides` (default FALSE). `addressElements()`:

1. Builds the standard Address sub-elements via `parent::addressElements()`.
2. Computes `$allowOverrides = $element['#allow_overrides'] && currentUser has 'override address fields'`.
3. Assembles `$settings` from config `address_autocomplete_photon.settings.autocomplete` plus
   `allow_overrides`, `default_country` (= `$value['country_code']`), and `format` (the country's
   address format string, resolved from `address.address_format_repository`, newlines flattened).
4. Adds a `location_field` textfield (title *"Address (with autocompletion)"*, class
   `address-autocomplete-input`, `#maxlength 2048`, `#weight -99`), required when the country's
   format has any required fields.
5. Adds wrapper class `address-autocomplete-wrapper`, attaches library
   `address_autocomplete_photon/autocomplete`, and passes `$settings` as
   `drupalSettings.addressAutocomplete`.

Helpers `prepareDefault()` / `getAddressFormat()` render the current stored address into the
single-line default using `AddressDefaultFormatter::replacePlaceholders()` and the country's
local or generic format.

## Field widget: `address_autocomplete_photon`

`src/Plugin/Field/FieldWidget/AddressAutocomplete.php` — `#[FieldWidget(id:
'address_autocomplete_photon', label: 'Address autocomplete with Photon', field_types:
['address'])]`, extends `AddressDefaultWidget`.

- `defaultSettings()` adds `allow_overrides` (FALSE).
- `formElement()` calls the parent, then sets `$element['address']['#type'] =
  'address_autocomplete'` and `$element['address']['#allow_overrides'] = (bool)
  getSetting('allow_overrides')`.
- `settingsForm()` exposes an *"Allow users to override autocompleted values"* checkbox;
  `settingsSummary()` shows its state.

Enable it via *Manage form display* on any bundle with an Address field, or with config:

```bash
drush cset core.entity_form_display.node.article.default \
  content.field_address.type address_autocomplete_photon -y
```

## Client behavior (how autocomplete actually runs)

Library `autocomplete` = `js/address-autocomplete.js` (`Drupal.behaviors.addressAutocompletePhoton`,
using `core/once`) reads `drupalSettings.addressAutocomplete`, adds the current language, and
initializes the jQuery plugin on `.address-autocomplete-input`. Library `autocomplete-plugin` =
`js/plugin/address-autocomplete-photon.jquery.js` (depends on `core/drupal.autocomplete`,
`core/jquery`):

- On init it hides/disables the individual Address sub-fields (`hideFields()`) per `mode`
  (`managed_fields_display`) and, when `allowOverrides` is on and `mode !== 'default'`, adds an
  *"Override fields"* toggle button (`Drupal.theme.addressAutocompleteToggleButton`).
- `autocompleteSource()` sends `$.getJSON('https://photon.komoot.io/api/', { lang, q: "<term>
  <countryLabel>" })`, keeps only `features` whose `properties.countrycode` matches the selected
  country, optionally de-duplicates (`removeDuplicates`), formats each label via
  `formatProperties()` using the country address `format`, and stops at `limit` results.
- `autocompleteSelect()` maps the chosen result's `properties` into the Address sub-field inputs
  using `getResponseMapping()` (name/street/housenumber/city/state/postcode/countrycode…), applies
  per-country street formatting via `formatAddressLine1()`, handles `<select>` fields by matching
  option value or label, and re-hides valid fields (`checkValidity()` / `reportValidity()` for
  invalid ones).
- `shiftPostalCodes()` collapses a `;`-separated postcode list to the first entry.
- Suggestion labels are rendered by jQuery UI autocomplete's default item renderer, which inserts
  the value with `.text()` — so Photon-returned place names are treated as text, not markup.

## Notes / caveats

- The Photon endpoint is **hardcoded** in the JS (`https://photon.komoot.io/api/`); there is no
  admin setting for a self-hosted Photon instance in this version — changing it requires patching
  the JS.
- Queries typed by the visitor are sent from the **browser** directly to the public
  `photon.komoot.io` service. There is no server-side request and no API key.
- If JavaScript is off, the plugin never initializes and the standard Address sub-fields remain
  visible and usable (graceful degradation).
- The country filter compares Photon's `countrycode` to the Address field's country value, so
  suggestions are limited to the countries the Address field permits.
