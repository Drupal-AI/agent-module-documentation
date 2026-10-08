<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Shipping Mondial Relay (commerce_shipping_mondial_relay) — agent index

Adds a **Mondial Relay pick-up-point ("Point Relais") shipping option** to Drupal Commerce.
Customers pick a parcel shop at checkout using **Mondial Relay's own hosted browser widget**, and
the chosen relay point is carried into the order's shipment. Package `Commerce (contrib)`. Core
`^10.1 || ^11 || ^12`. License GPL-2.0-or-later. Installed **2.0.0** (version dir `2.0.x`).

It is a **thin, client-side integration**: the module makes **no server-side call to the Mondial
Relay API** and defines **no custom route/controller**. The pickup-point map/search is Mondial
Relay's third-party jQuery widget, loaded as an external script; the shipping rate is a flat amount
set in config.

## Dependencies

- Drupal module (`.info.yml`): **`commerce_shipping:commerce_shipping`** (required). The checkout
  pane also assumes the **Shipping information** pane (from `commerce_shipping`) is present in the
  checkout flow.
- No Composer library or PHP requirements beyond the above. Pulls in `commerce`, `profile`,
  `address`, `state_machine` transitively via Commerce Shipping.

## What it provides (from source)

### Shipping method plugin — `Plugin/Commerce/ShippingMethod/MondialRelay.php`
- `@CommerceShippingMethod(id = "commerce_shipping_mondial_relay")`, extends `ShippingMethodBase`.
  Single service `default`, labelled from config `rate_label`.
- **`calculateRates()`** returns one `ShippingRate` built entirely from config:
  `Price::fromArray($this->configuration['rate_amount'])` + `rate_description`. The rate is a **flat,
  admin-set amount** — never taken from the request or the carrier.
- **`buildConfigurationForm()`** exposes: `rate_label` (required), `rate_amount`
  (`commerce_price`, required), `rate_description`, and a **Widget settings** fieldset that maps to
  Mondial Relay's `MR_ParcelShopPicker` options — `brand` (required; the Mondial Relay "Enseigne"
  code), `default_country`, `enable_geolocalisated_search`, `col_liv_mod` (24R / 24L / 24X / APM
  locker filter), `nb_results` (default 7), `search_delay`, `map_scroll_wheel`, `map_street_view`,
  `responsive`, `show_results_on_map`, `display_map_info`, `theme` (`mondialrelay` | `inpost`).
- `submitConfigurationForm()` persists these into plugin configuration; `validateConfigurationForm()`
  is empty. Injects `address.country_repository` for the country `<select>`.

### Checkout pane plugin — `Plugin/Commerce/CheckoutPane/MondialRelay.php`
- `@CommerceCheckoutPane(id = "commerce_shipping_mondial_relay", default_step = "shipping_information")`,
  label "Mondial Relay Widget". Extends `CheckoutPaneBase`.
- **`buildPaneForm()`** renders only when the selected shipping method's plugin id is
  `commerce_shipping_mondial_relay` (else returns `[]`). Builds a `#container` (`#id
  commerce_shipping_mondial_relay_widget`) that the JS mounts the widget into, attaches the
  `commerce_shipping_mondial_relay/mondialrelay` library, and passes widget options via
  `drupalSettings.commerce_shipping_mondial_relay.widget`. Adds a `pickup` subtree of **hidden**
  fields: `pickup_id`, and a `pickup_address` group (id, nom, adresse1, adresse2, cp, ville, pays),
  plus a `pickup_info` render element themed `commerce_shipping_mondial_relay__widget__info`.
- **`getWidgetSettings()`** assembles the `drupalSettings` payload: seeds Country/PostCode/City from
  the existing shipping profile's address (or the method's `default_country`), sets `AutoSelect` from a
  previously saved `field_pickup_id`, copies the method's widget config, and sets `AllowedCountries`
  from the store's `shipping_countries`.
- **`validatePaneForm()`** sets a form error ("You have to select a pick up") if `pickup_id` is empty
  when the value is present.
- **`submitPaneForm()`** (only for this shipping method): loads an existing `mondial_relay` profile by
  `field_pickup_id` or creates one (owner uid 0) with `field_pickup_id` + `field_pickup_address`
  (mapped from the submitted hidden address fields), then sets it as the shipping profile on every
  shipment of the order.
- **`isVisible()`** requires the order to have `shipments` and at least one purchasable entity with a
  `weight` field.

### Frontend assets
- **`js/mondialrelay.js`** — a Drupal behavior that calls
  `$("#commerce_shipping_mondial_relay_widget").MR_ParcelShopPicker({...})` with the `drupalSettings`
  options, wires the widget's `Target`/`TargetDisplay` to the hidden inputs, and in
  `OnParcelShopSelected` copies the selected relay point's fields (ID, Nom, Adresse1/2, CP, Ville,
  Pays, opening-hours HTML) into the hidden inputs / display divs.
- **`js/jquery-shim.js`** — re-adds `jQuery.trim` / `jQuery.isFunction` so the vendor widget works
  under jQuery 4.x.
- **Libraries** (`.libraries.yml`): `mondialrelay` (local JS+CSS) depends on `remote`; `remote`
  loads the **external** `MR_ParcelShopPicker` script from the fixed host
  `https://widget.mondialrelay.com/parcelshop-picker/…` (marked `gpl-compatible: false`) and depends
  on `core/jquery` + the jQuery shim.
- **Template** `templates/commerce-shipping-mondial-relay--widget--info.html.twig` — static wrapper
  (`__pickup__info` + `__pickup__hours` divs) filled client-side by the widget. Styled by
  `css/mondialrelay.css`.

### Config & hooks
- `config/install/**` ships the **`mondial_relay` profile type** (multiple, no registration) with two
  fields: **`field_pickup_id`** (`string`) and **`field_pickup_address`** (`address`), plus its
  default form/view displays. This is the entity the pane writes the chosen relay point into.
- `hook_theme()` is declared via the OOP hook class `Hook/CommerceShippingMondialRelayHooks` (with a
  `#[LegacyHook]` shim in the `.module`), registering the widget-info theme hook. Service
  `commerce_shipping_mondial_relay.services.yml` autowires the hook class.

## Notes for agents

- **No API credentials / private key** exist in this module: it performs no authenticated server-side
  API call. `brand` (the Mondial Relay Enseigne code) is a public widget identifier that is sent to
  the browser by design.
- **No custom route, controller, or permission** — the module adds no `*.routing.yml` /
  `*.permissions.yml` / `*.install`. Access to the shipping-method config is Commerce's standard admin
  access; the checkout pane runs inside the normal Commerce checkout form pipeline.
- The **rate is flat** and comes from config server-side. Pickup-point search runs entirely in the
  browser against Mondial Relay's servers via the hosted widget.
- Known issue (project): with multiple shipping methods the widget may not show/hide/refresh correctly
  via AJAX — see the issue queue.
- Single-surface integration; no `agent/` subdocs are warranted. See [../usage.md](../usage.md) and
  the human guide at [../human-docs/index.md](../human-docs/index.md).
