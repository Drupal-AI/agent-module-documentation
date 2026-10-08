<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sinoptik.ua Weather Informer provides a configurable block that embeds the sinoptik.ua weather widget for one or more selected cities.
---
Site builders place the "Sinoptik.ua Weather Informer" block, choose a widget language (ua/ru/en/pl), a color scheme and width, and pick cities via an autocomplete field. City selection is backed by a controller route (`/sinoptik_weather/autocomplete/{field_name}/{lang}`) that proxies an autocomplete query to a fixed sinoptik.ua endpoint and returns JSON; the block also calls sinoptik.ua server-side to resolve city spellings/paths. The rendered block attaches `js/sinoptik.js` and passes the chosen city IDs and language through `drupalSettings`, and the actual weather informer is drawn by sinoptik.ua's remote assets.

The autocomplete route is gated by `_permission: 'access content'`, so it is effectively available to anonymous visitors. It is read-only: it only issues a GET to the hard-coded host `https://sinoptik.ua/search.php` with a user-supplied `q`/`lang` as query parameters — the destination host is a constant, so there is no SSRF (a user cannot redirect the request to an internal address); the worst case is triggering outbound requests to sinoptik.ua with an arbitrary search term. Setup: enable the module, place the block, select language and cities, and configure width/color.
---
- Place a weather informer block for selected cities.
- Show weather for Ukrainian cities via sinoptik.ua.
- Select cities through an autocomplete field.
- Choose the informer language (Ukrainian, Russian, English, Polish).
- Set the informer width to fit or a fixed pixel value.
- Pick the informer's major color scheme.
- Add multiple cities to a single informer (where supported).
- Translate the selected cities when switching language.
- Embed the sinoptik.ua widget assets on the page.
- Pass chosen city IDs to the front-end via drupalSettings.
- Link to the 10-day forecast on sinoptik.ua.
- Use the autocomplete endpoint to search sinoptik city names.
- Configure the block per region like any Drupal block.
- Display the informer for a single city with a direct city link.
- Restrict the block to specific pages via block visibility settings.
