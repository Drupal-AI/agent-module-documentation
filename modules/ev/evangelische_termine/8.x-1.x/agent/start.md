<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Evangelische Termine (evangelische_termine) — agent index

**Church-events integration for evangelische-termine.de: filtered-list / teaser / resource-booking blocks + autocomplete.**

- **Version:** 8.x-1.x  •  core: `^8 || ^9 || ^10`  •  package: Vernetzte Kirche  •  depends on `colorbox`.
- **Blocks:** `FilteredList`, `Teaser`, `ResBooking` (all fetch from a configured evangelische-termine.de host). Forms: `FilterForm`, `MoreForm`.
- **Route:** `/et-slider-autocomplete/{field_name}/{type}/{typeid}/{host}` (`_access: 'TRUE'`) → `AutocompleteController::handleAutocomplete`.
