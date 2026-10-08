<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Google Maps Services provides access to Google Maps API Web Services.

---

Google Maps Services provides Drupal access to Google Maps API web services — a base integration for
calling Google Maps APIs (geocoding, directions, places, etc.) from Drupal code/features. It is configured at
`google_maps_services.settings`, provides its own permissions, in the Google Maps Services package.

Use it as the base for Google Maps API integrations. Security note: it authenticates to Google Maps with an
**API key** — **store the key securely** and, critically, **restrict the API key** (by HTTP referrer/IP and
to only the needed APIs) in the Google Cloud console to prevent abuse/quota theft if it leaks (especially for
any key exposed client-side); operate over HTTPS. It has no access-control role beyond its permission.
Configure the Google Maps API key.

---

- Access Google Maps web services.
- Call geocoding/directions/places APIs.
- Integrate Google Maps from Drupal.
- Configure at google_maps_services.settings.
- Provide its own permissions.
- Store the Google Maps API key securely.
- Restrict the API key (referrer/IP + APIs).
- Prevent key abuse/quota theft.
- Operate over HTTPS.
- Have no access-control role beyond permission.
- Configure the API key.
- Handle Maps integration.
- Use Maps APIs.
- Configure credentials.
- Handle the API key securely.
- Access Maps services.
- Configure Google Maps.
- Call Maps APIs.
- Restrict the key.
- Integrate Maps.
