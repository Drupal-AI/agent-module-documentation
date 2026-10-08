<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Address Iran — agent orientation

Static data module: adds Iran address format + province/city subdivisions to the Address module.

Key file: `src/EventSubscriber/AddressEventsSubscriber.php`
- `onAddressFormat()` — sets `IR` format, subdivision_depth 2, PROVINCE area type, required area/locality.
- `onSubdivisions()` — returns hardcoded provinces (parents `['IR']`) and their cities.
Service: `address_iran.events_subscriber` (event_subscriber tag). No routes/permissions/config.

Security posture: none — no request input, no I/O, no dynamic queries. Nothing to review.
