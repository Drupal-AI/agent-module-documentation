<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the Address geocoder widget

## Fields required
- An **address** field (from the `address` module).
- A **geofield** field on the same entity (or on the same referenced entity) with geocoder providers assigned.

## Form display
1. Go to the entity's *Manage form display*.
2. For the address field, select the **Address geocoder** widget.
3. In the widget settings, set **Geofield target** to the machine name of the geofield to fill.

## Geofield side
- On the geofield, configure the geocoder providers (Manage fields → geocoder settings). The widget reads the geofield's `geocoder_field` third-party settings (`providers`) and geocodes through them.

## Runtime behaviour
- The **Get resolved addresses** button (`requestGeocodeCallback`) builds the string `line1 line2 postal_code locality country`, calls `geocoder->geocode()` server-side, and populates the **Resolved addresses options** select.
- Selecting an option (`geocodedSelectedCallback`) dispatches `GeocodeAddressCommand` which writes `latitude|longitude` into the geofield widget.
- **Automatically position on map** (checked by default) applies the first candidate.
- Misconfiguration (missing target, no geocoding plugin for the field type) surfaces as a modal error dialog, not a silent failure.
