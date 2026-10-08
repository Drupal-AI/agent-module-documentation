<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Evangelische Termine integrates the German church-events portal evangelische-termine.de into a Drupal site. It provides several blocks: a filtered event list (with a filter form and "more" pagination form), an event teaser/slider, and a resource-booking form block. Content is fetched from the remote events database and rendered via the module's Twig templates; Colorbox is used for lightbox display.
It is aimed at parish/church sites (package "Vernetzte Kirche") that want to embed their events, teasers and room/resource booking from the central evangelische-termine.de service.
---
Install with `drush en evangelische_termine` (requires `colorbox`). Place the provided blocks (filtered list, teaser, resource booking) and configure each block's settings — e.g. the organizer ID (Veranstalter-ID), resource IDs, host, and display options. The blocks call out to the configured evangelische-termine.de host to retrieve data.
The module also registers an autocomplete route `/et-slider-autocomplete/{field_name}/{type}/{typeid}/{host}`.
---
- Install: `composer require drupal/evangelische_termine && drush en evangelische_termine -y` (needs colorbox).
- Place the "Evangelische-Termine Veranstaltungsliste mit Filter" (filtered list) block.
- Place the teaser/slider block for compact event display.
- Place the resource-booking form block for room/resource reservations.
- Configure each block's organizer ID (Veranstalter-ID) and host.
- Restrict the resource-booking block to specific resource IDs.
- Choose grouping (none / by keyword) and whether to show blocked events.
- Colorbox provides lightbox display of event details.
- Events are fetched server-side from evangelische-termine.de.
- The filter form and "more" form drive list filtering/pagination.
- Templates render event data; keep the remote service trusted.
- Intended for parish/church sites using the central events portal.
