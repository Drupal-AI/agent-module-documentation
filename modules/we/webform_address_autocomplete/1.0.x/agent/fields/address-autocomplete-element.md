<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Address-autocomplete Webform element

The module ships one Webform element that replaces Webform core's Address composite with an
autocompleting version.

## Element identity

- WebformElement plugin: `src/Plugin/WebformElement/WebformAddressAutocomplete.php`
  - id `webform_address_autocomplete`, label **"Address autocomplete"**,
    category **"Advanced elements"**, `composite = TRUE`, `multiline = TRUE`,
    `states_wrapper = TRUE`. Extends Webform's `WebformAddress`, so it inherits the same
    composite sub-elements: `address`, `address_2`, `city`, `state_province`, `postal_code`,
    `country` (plus `given_name`/`family_name`/`organization` from the base).
- Render element: `src/Element/WebformAddressAutocomplete.php`, `@FormElement("webform_address_autocomplete")`,
  extends `Drupal\webform\Element\WebformAddress`.

## Adding it to a webform

Edit a webform → **Add element** → "Address autocomplete" (under *Advanced elements*). No
per-element configuration is required; the active provider is a **site-wide** setting (see
[../configure/settings.md](../configure/settings.md)). If no provider is selected the element
shows a `messages--warning` item pointing to the settings page.

Sub-element order and per-field HTML `autocomplete` attributes are tuned through the element's
**Custom properties** (Advanced tab), e.g. `address__weight: 10`, `city__autocomplete: address-level2`
(see the module README for the full list).

## How suggestions reach the browser

`Element\WebformAddressAutocomplete::getInfo()` appends a `#process` callback,
`processAutocomplete()`, which:

1. adds class `webform_address_autocomplete` to the inner `address` textfield;
2. attaches library `webform_address_autocomplete/webform_address_autocomplete`;
3. sets `#autocomplete_route_name` = `webform_address_autocomplete.addresses` and
   `#autocomplete_route_parameters['country']` = the composite's current `country_code`;
4. sets the placeholder "Please start typing your address...".

This reuses Drupal core's autocomplete machinery (`core/drupal.autocomplete`). As the user
types, the browser calls the module's own JSON route:

```
GET /webform-address-autocomplete/addresses?q=<typed text>&country=<ISO code>
```

Route `webform_address_autocomplete.addresses` (`_format: json`) →
`Controller\WebformAddressAutocomplete::handleAutocomplete()`: it reads `q` (trimmed of `"`)
and optional `country`, joins them as `"<q>||<country>"`, and passes that to the active
provider's `processQuery()`. The JSON response is an array of suggestion objects with keys
`street_name`, `town_name`/`city`, `zip_code`, `administrative_area`, `label`, and sometimes
`location` (`longitude`/`latitude`). This route is the server-side proxy: the external
geocoding API is called from PHP, so the provider API key stays on the server.

## Client-side behavior (JS)

Two scripts in the attached library:

- `js/webform_address_autocomplete.js` — `Drupal.behaviors.webform_address_autocomplete`.
  Overrides the jQuery-UI autocomplete `select` handler on `input.webform_address_autocomplete`
  so that choosing a suggestion writes `ui.item.street_name`, `zip_code`, `town_name` and
  `administrative_area` into the composite's `-address`, `-postal-code`, `-city` and
  `-state-province` sub-inputs (matched by `data-drupal-selector`).
- `js/webform_address_autocomplete_override.js` — wraps core's
  `Drupal.autocomplete.extractLastTerm` to quote the whole term, so commas in a one-line
  address don't split it into multiple search terms (otherwise only the text after the last
  comma would be queried).

Library `webform_address_autocomplete` depends on `core/jquery`, `core/once`, `core/drupal`,
`core/drupal.autocomplete`.
