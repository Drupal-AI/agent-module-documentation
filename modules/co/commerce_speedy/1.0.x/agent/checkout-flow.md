<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# commerce_speedy — checkout & pickup UI (routes, forms, session)

## Routes (`commerce_speedy.routing.yml`)

All require `_permission: 'access content'` (checkout must work for anonymous buyers). `_format:
json` on the autocompletes.

| Route / path | Handler | Purpose |
|---|---|---|
| `commerce_speedy.site_autocomplete` `/commerce-speedy/speedy-site-autocomplete` | `SiteAutocompleteController` | City/village autocomplete via `location/site`. |
| `…speedy_find_complex_autocomplete/{site_id}` | `FindComplexAutocompleteController` | Complex autocomplete (`location/complex`). |
| `…speedy_find_street_autocomplete/{site_id}` | `FindStreetAutocompleteController` | Street autocomplete (`location/street`). |
| `…speedy_find_block_autocomplete/{site_id}` | `FindBlockAutocompleteController` | Block autocomplete. |
| `…speedy_find_poi_autocomplete/{site_id}` | `FindPOIAutocompleteController` | Point-of-interest autocomplete (`location/poi`). |
| `commerce_speedy.speedy_address_form` `/commerce-speedy/speedy-address-form` | `SpeedyAddressForm` | Modal address builder (site/street/complex/no/block/entrance/floor/apt/POI/note). |
| `commerce_speedy.pickup_office_form` `/commerce-speedy/pickup-office-form` | `PickupOfficeForm` | Office/box picker (+ Google-Maps map when `gmap_api_key` set). |

Autocomplete controllers `Xss::filter()` the `q` term, POST it to Speedy, and append results into
`$session['speedy'][find_*_name]`. Selected values are matched back to the cached session data in
`SpeedyAddressForm::getSite()/getStreet()/getComplex()` (ids parsed from the option string).

## The `speedy` session bucket

Central state, persisted across anonymous requests by `anonymoussession`. Keys seen in source:
`find_site_request`, `find_complex_name.complexes`, `find_street_name.streets`,
`find_poi_name.pois`, `offices`, `site`, `street`, `complex`, `dropoff_office`, and
`speedy_address_form` (the whole address sub-form: post_code, site_*, street_no, block_no,
entrance/floor/apartment, `pay_on_delivery`, `obpd`, `delivery_to_floor`). `commerce_store` /
`profile` presave hooks merge this bucket into the entity's `speedy_data` map field.

## Checkout form alter (`commerce_speedy.module`)

`hook_form_commerce_checkout_flow_multistep_default_alter` (only when a `speedy` method is
enabled):

- Applies `anonymoussession`; attaches libraries and an `#after_build` on the address widget that
  injects a "Find city/village" modal link to `speedy_address_form`.
- On step `order_information`, adds **Delivery options** (`pay_on_delivery` checkbox → toggles
  `obpd` select and `delivery_to_floor`), each with an AJAX callback that writes into
  `$session['speedy']['speedy_address_form']`.
- Adds `commerce_speedy_validate_shipping_information_profile_phone` — validates the phone against
  Speedy `validation/phone`.
- On step `complete`, attaches `checkout_cookies_delete` to clear pickup cookies.

## Pickup office selection

`PickupOfficeForm` reads `pickup_office_id`, `pickup_office_type` (OFFICE/APT), `site_id`,
`order_id`, `commerce_shipment`, `route_redirect` from the query, lists offices via
`getOfficesOpts($site_id)`, and (if a gmap key is set) renders a `<gmp-map>` element fed office
lat/lng through `drupalSettings.commerce_speedy.offices` + the `gmap_offices_speedy` JS library.
On submit it redirects back to checkout / the shipment edit form with
`pickup_office_id`/`pickup_office_type` in the query, and the plugin's `resolvePickupOffice()`
picks them up via the `pickup-office-id` / `pickup-box-id` cookies (set client-side).

## Store & profile forms

`hook_form_commerce_store_form_alter` adds a **Drop-off Office / Box** select (origin for
outbound shipments) and an address "Find city/village" link; `hook_form_profile_form_alter` adds
the same address link on customer profiles so an address can be validated against Speedy.
`commerce_speedy_page_attachments()` injects the Google-Maps loader script (using `gmap_api_key`)
on the checkout, pickup-office-form and shipment-edit routes.
