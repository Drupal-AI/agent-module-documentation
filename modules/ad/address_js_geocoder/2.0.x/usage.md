<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A field widget that extends the Address default widget so an editor can geocode a typed address over AJAX and populate a companion geofield.

---

The module registers the `address_geocoder` field widget (a subclass of `address`'s `AddressDefaultWidget`). On the entity form it adds a "Get resolved addresses" button, a select of resolved candidates, and an auto-position checkbox. Pressing the button assembles the address parts into a single string and calls Drupal's `geocoder` service server-side with the geocoder providers configured on the target geofield; the resulting candidate coordinates are returned to the browser through a custom `GeocodeAddressCommand` AJAX command that writes latitude/longitude into the geofield widget.

Geocoding runs entirely server-side through the geocoder module, so the provider API key stays in the geocoder provider config and is never exposed to the client. The widget only works on entity edit forms (authenticated content editing), and the geofield target field must have geocoder providers assigned. Setup is done on the entity's form display: choose the "Address geocoder" widget for the address field and set the target geofield machine name in the widget settings; on the geofield, enable geocoding from the address field.
---
- Enable geocoding of an address field into a geofield without leaving the edit form
- Choose the "Address geocoder" widget on a Manage form display
- Set the target geofield machine name in the widget settings
- Populate map coordinates from a typed postal address
- Let editors pick among multiple resolved address candidates
- Auto-position the first resolved candidate on the map
- Geocode street, postal code, locality and country together
- Use any geocoder provider configured on the target geofield
- Keep geocoding API keys server-side rather than in the browser
- Geocode addresses inside referenced (entity_reference) sub-entities
- Add lat/long to profiles, nodes or media that carry an address
- Trigger geocoding on demand with the "Get resolved addresses" button
- Show geocode errors in a modal dialog when the target field is misconfigured
- Validate that the configured geofield target actually exists
- Format the resolved address label with the default geocoder formatter
- Fill the geofield widget via the custom GeocodeAddressCommand AJAX command
- Support single-value address geocoding on complex nested forms
- Provide a fallback manual selection when auto-position is disabled
- Pair Address + Geofield fields on a content type for location data
- Reuse the site's existing geocoder provider chain for consistency