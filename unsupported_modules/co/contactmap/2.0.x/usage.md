<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Contact Map places a draggable floating contact widget on the site's front-end pages: a Google map, a contact address, and a click-to-call phone number. It is aimed at lead-generation sites that want a persistent, movable contact affordance available on every page.

---

Configuration is a single admin form at `/admin/config/user-interface/contact-map` (`administer site configuration`) storing a Google Map API key, phone number (validated for length and a numeric/`+` pattern), address, and latitude/longitude in `contactmap.settings`. A `hook_preprocess_page` attaches the `contactmap` library and passes those settings to the browser via `drupalSettings` when the active theme matches the configured theme; the JS (`contactmap.js`) renders the map/pin and makes the widget draggable. Icons ship in `images/`.

Setup: enable the module, obtain a Google Maps JS API key, fill in the settings form (phone number is required), and the widget appears on matching-theme pages.

---

- Enter a Google Maps JS API key
- Set the contact phone number (click-to-call)
- Set the contact address
- Set the map latitude and longitude
- Restrict the widget to a specific theme
- Show the widget on all front-end pages
- Let visitors drag the widget around the screen
- Provide a persistent contact affordance for lead generation
- Configure everything from one admin form
- Validate the phone number format on save
- Theme the widget via the shipped CSS/JS library
- Use the calendar/map-pin icons in `images/`
- Place a mobile click-to-open phone link
- Expose settings to JS via `drupalSettings`
- Toggle the widget by switching the active theme
