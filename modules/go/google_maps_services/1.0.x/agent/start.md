<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Google Maps Services — agent index

Provides access to **Google Maps API web services** (geocoding/directions/places) from Drupal. Config at
`google_maps_services.settings`; provides permissions. Version **1.0.2**. Core `^10.2||^11`.

**Security:** store the Google Maps **API key** securely and **restrict it** (HTTP referrer/IP + only needed
APIs) to prevent abuse/quota theft; HTTPS. No access role beyond permission.
