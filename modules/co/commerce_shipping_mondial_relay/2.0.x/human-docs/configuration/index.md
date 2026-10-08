# Configuration

Setup has two parts: add a Mondial Relay shipping method with your rate and
widget settings, and add the Mondial Relay pane to your checkout flow.

## 1. Add the Mondial Relay shipping method

1. Go to **Commerce → Configuration → Shipping methods**
   (`/admin/commerce/shipping-methods`) and click **Add shipping method**.
2. Choose the **Mondial Relay** plugin.
3. Set the **rate**:
   - **Rate label** (required) — shown to customers when they pick the rate.
   - **Rate amount** (required) — a flat shipping price. This module charges this
     fixed amount; it does not fetch live prices from the carrier.
   - **Rate description** (optional) — extra detail shown with the rate.
4. Fill in the **Widget settings** fieldset, which map to Mondial Relay's own
   parcel-shop-picker widget:
   - **Brand** (required) — your Mondial Relay **"Enseigne"** code. This is a
     public identifier the in-browser widget needs; it is not a private key.
   - **Default country**, **Number of results** (default 7), **Package shipping
     mode** (`24R` Relay Point L / `24L` XL / `24X` XXL / `APM` lockers),
     **Search delay**, **Theme** (`mondialrelay` or `inpost`), and the map
     options (geolocated search, scroll-wheel zoom, Street View, responsive, show
     results on map, display map info).

Refer to Mondial Relay's own documentation for what each widget parameter does —
the module passes them straight through to the widget.

## 2. Add the checkout pane

Add the **Mondial Relay Widget** pane to your checkout flow at **Commerce →
Configuration → Checkout flows**. It runs on the **shipping information** step and
must sit alongside the **Shipping information** pane (from `commerce_shipping`),
which it relies on. At checkout — once the customer selects the Mondial Relay
shipping method — the widget appears; the customer searches the map, picks a
parcel shop, and that choice is carried into their shipment.

## Save and test

Save and run a test checkout. Confirm the Mondial Relay rate appears, the widget
loads, and a pick-up point can be selected before the order is placed.

> **Known issue:** with multiple shipping methods, the widget may not refresh or
> show/hide correctly via AJAX. Check the project's issue queue for the current
> workaround if you offer several methods.

## Notes

- Serve checkout over **HTTPS**. The pickup-point search is performed by Mondial
  Relay's hosted widget script loaded in the customer's browser; the module makes
  no server-side call to the carrier and stores no API secret of its own.
- The customer's chosen pick-up point and its address are stored on a
  `mondial_relay` profile and attached to the shipment — handle them with the same
  care as other order data.
