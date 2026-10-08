<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UK address lookup elements

Three Webform elements and two services implement address entry. All live in the parent module.

## The elements

| Machine id | FormElement class | WebformElement plugin | Purpose |
|---|---|---|---|
| `localgov_webform_uk_address` | `src/Element/UKAddressLookup.php` | `src/Plugin/WebformElement/UKAddressLookup.php` | Composite: search + Ajax lookup + select + manual address fields. |
| `localgov_forms_address_lookup` | `src/Element/AddressLookupElement.php` | `src/Plugin/WebformElement/AddressLookupElement.php` (`hidden = TRUE`) | Internal search/select sub-element carrying the Ajax callback. |
| `webform_uk_address` | `src/Element/WebformUKAddress.php` | `src/Plugin/WebformElement/WebformUKAddress.php` | Plain UK address block (address 1/2, town/city, postcode) — no lookup. |

`webform_uk_address` and `localgov_webform_uk_address` extend Webform's `WebformCompositeBase`.
`localgov_forms_address_lookup` extends core `FormElementBase`.

## Composite structure (`localgov_webform_uk_address`)

`UKAddressLookup::getCompositeElements()` builds:

- `address_lookup` (`localgov_forms_address_lookup`) — the search box + *Find address* button + result `<select>`. Receives `#address_type` (default `residential`), `#geocoder_plugins`, `#local_custodian_code`, `#always_display_manual_address_entry_btn`.
- The manual fields from `WebformUKAddress::getCompositeElements()`: `address_1`, `address_2`, `town_city`, `postcode` (each a textfield; `address_1` gets required-error "You must enter an address").
- Hidden sub-elements `lat`, `lng`, `uprn`, `ward` (class `js-localgov-forms-webform-uk-address--<x>`) so builders can read them in computed Twig. Token example: `[webform_submission:values:ELEMENT_ID:uprn]`.
- Attaches library `localgov_forms/localgov_forms.address_select`.

`UKAddressLookup::validateWebformComposite()` reconciles the two entry modes: if the manual fields
are filled it validates them and clears the search string; otherwise it drives required/"select an
address"/"enter a postcode" errors and prunes child-element errors so only the search and select
report. It bypasses validation when the element (or a parent container) is hidden by `#states`
(via `WebformHelper::isElementVisibleThroughParent()`).

`UKAddressLookup::preSave()` strips the transient `address_lookup` sub-tree and `lat`/`lng`/`ward`
from stored submission data. `formatTextItemValue()`/`formatHtmlItemValue()` render the four
address lines as one string.

## The lookup sub-element (`AddressLookupElement`)

`processAddressLookupElement()` builds a `centralhub-address-lookup` container with:

- `address_search.address_searchstring` — textfield, `#maxlength` 64, label "Postcode or street".
- `address_search.address_actions.address_searchbutton` — `#type button` with an `#ajax` callback
  `AddressLookupElement::loadAddresses` (event `click`, method `html`, wrapper `…--edit-address-options`).
- `address_select.address_select_list` — the results `<select>` (`aria-live` polite region).

`loadAddresses()` (Ajax) and the process step both call `addressSelectLookup($search, $element)`,
which invokes `\Drupal::service('localgov_forms.address_lookup')->search([$search], $plugin_ids,
$custodian_code)`. Results are cached in static properties keyed by search string / type / custodian
code / plugin ids to avoid duplicate API calls. Each result becomes a `<select>` option
(`#options[name] = display`) and the full list is exposed to `drupalSettings.centralHub.addressList`
for the client JS (`js/address_change.js`, `js/address_select.js`) to populate the manual fields.
No-result and empty-search states return a small static markup message.

## Services

- `localgov_forms.address_lookup` → `Drupal\localgov_forms\AddressLookup` (args `@geocoder`,
  `@localgov_forms.geocoder_selection`). `search()` builds a `GeocodeQuery` from the joined search
  terms (`toSearchQuery()`, attaching `local_custodian_code` as query data), runs
  `$this->geocoder->geocode($query, $providers)`, and maps each `Geocoder\Location` via
  `reformat()` into an array (name/uprn/display/street/flat/house/town/postcode/lat/lng/country/…).
  UPRN-bearing results (implementing `AddressUprnInterface`, from the OS Places provider) use the
  UPRN as the option id; others use `(lat,lon)`.
- `localgov_forms.geocoder_selection` → `Drupal\localgov_forms\Geocoders` (arg
  `@entity_type.manager`). Loads `geocoder_provider` config entities, and
  `getSelectedPlugins()`/`listSelectedAndAvailablePluginIds()` intersect the element's selected ids
  with the installed providers so only real, installed providers run.

The search text is passed to the geocoder as the **query term** only; the provider (and thus the
remote endpoint, TLS and any API key) is the admin-configured `geocoder_provider` entity, not
anything from the request.

## Configuring the element (form builder UI)

`UKAddressLookup::form()` (WebformElement plugin) adds, on the element's config form:

- **Geocoder plugins** (`geocoder_plugins`, checkboxes, required) — options are the installed
  provider labels from `Geocoders::listInstalledPluginNames()`. Providers are added at
  *Configuration → System → Geocoder → Providers*.
- **When to display the manual address entry button** (`always_display_manual_address_entry_btn`,
  radios `yes`/`no`).
- **Local authority** (`local_custodian_code`, select) — only shown when the
  `local_custodian_codes_gb` Webform options entity exists; restricts lookup to one authority for
  providers that support custodian codes (OS Places). See [../config/webform-defaults.md](../config/webform-defaults.md).

`defineDefaultProperties()` also forces `title_display` to a visible title (composites normally hide it).

## Install & operate

```bash
composer require drupal/localgov_forms localgovdrupal/localgov_os_places_geocoder_provider
drush en localgov_forms -y
```

Then add a **Geocoder provider** (OS Places for UK councils), add a *LocalGov address lookup*
element to a webform, tick the provider under **Geocoder plugins**, and (optionally) pick a local
authority. Without any installed provider selected, the lookup returns no addresses and users fall
back to manual entry. Themed by `templates/localgov-forms-uk-address-lookup.html.twig` +
`css/localgov_forms_uk_address.css` (library `localgov_forms_uk_address`).
