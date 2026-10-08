<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
City Timezones improves the account form's timezone picker: instead of scanning a long list of IANA zones, a user searches for a nearby city (from a bundled GeoNames `cities500` dataset) and the module sets the corresponding IANA timezone automatically.

A `hook_form_alter` in `city_timezones.module` adds a city-selector `<select>` (`timezone_city`) to the user `AccountForm` — optionally enhanced with the Chosen library for a searchable dropdown — and attaches `js/city-timezones.js`. On page load the JS fetches the full city list; when a city is selected it looks up that city's IANA timezone and fills the standard core timezone field, then disables the helper select on submit so it does not cause a form error. Two JSON endpoints back the JS: `/system/city-timezones/all` returns the (country- and population-filtered) city list, and `/system/city-timezones/lookup` returns the IANA timezone for a POSTed city id. Both parse the bundled TSV file (`inc/cities500.txt`) on each request.

Settings at `/admin/config/regional/city-timezones` (`administer site configuration`) let an administrator choose which countries to include, a minimum-population threshold to shrink the list, and whether to use Chosen. The endpoints serve only public geographic reference data (city names and timezones), not user data. Note that reducing the city list via a higher minimum population or a country filter is the intended lever for keeping the widget responsive on the client.
---
Enable the module so the account form's timezone field gains a city-search selector that auto-sets the IANA zone.
---
- Let users pick their timezone by searching for a nearby city instead of an IANA zone name
- Auto-fill the standard core timezone field from a selected city
- Restrict the city list to specific countries via the settings form
- Set a minimum city population threshold to trim the dropdown
- Apply a custom minimum-population value when the presets do not fit
- Toggle the Chosen searchable-dropdown enhancement on or off
- Simplify timezone selection on user registration and profile-edit forms
- Serve the full filtered city list as JSON to the widget (`/system/city-timezones/all`)
- Look up a single city's IANA timezone via JSON (`/system/city-timezones/lookup`)
- Reduce user error compared with picking from a raw IANA zone list
- Localize timezone selection by a recognizable nearby city
- Enhance the account form without a custom field or entity type
- Filter the bundled GeoNames data by ISO country code
- Cut the widget down to only large cities for better client performance
- Offer a "cities over 1,000,000 / 100,000 / 15,000 / 5,000 / 1,000 / 500" preset list size
- Configure all behavior from `/admin/config/regional/city-timezones`
- Keep timezone data local (bundled `cities500.txt`), with no external API call at runtime
- Attach the selector automatically wherever core renders the account timezone element
- Use as a drop-in UX improvement for multi-region sites with a global user base
