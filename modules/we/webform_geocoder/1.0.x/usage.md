<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Geocoder provides a Geocoder computed field for Webform.

---

Webform Geocoder provides a **Geocoder computed field for Webform** — geocoding an address entered in a
webform to coordinates (lat/long) via the Geocoder module, storing/using the result on submission. It depends on
the Webform and Geocoder modules.

Use it to geocode webform address input. It is a forms/integration feature. Security/data handling: geocoding
sends the **address to the configured Geocoder provider** (external egress — the provider and any **API key**
are configured in Geocoder; store the key as a secret over HTTPS), and address/coordinate data is personal data
in submissions. It has no access-control role. Configure the geocoder field on a webform.

---

- Provide a Geocoder computed field.
- Geocode a webform address.
- Store coordinates on submission.
- Depend on Webform and Geocoder.
- Serve forms/integration.
- Compute lat/long.
- Send the address to the Geocoder provider (egress).
- Store the Geocoder API key as a secret.
- Treat address/coordinates as personal data.
- Have no access-control role.
- Configure the geocoder field.
- Handle geocoding.
- Geocode addresses.
- Configure the field.
- Compute coordinates.
- Handle the integration.
- Geocode input.
- Add the field.
- Secure the key.
- Provide webform geocoding.
