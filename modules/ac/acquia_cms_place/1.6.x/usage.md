<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Acquia CMS — Place ships a ready-made **Place content type** (a location/venue type) with its fields, form and view displays, a Place Type taxonomy, a pathauto pattern, metatag/schema.org defaults, address-to-map geocoding, and Search-API listing views — all as installed configuration. It is one component of the Acquia CMS (Acquia Drupal Starter Kit) content model.

---

Acquia CMS is Acquia's Drupal distribution, assembled from small single-purpose feature modules like this one. Instead of a site builder hand-building a place type — the address, image, telephone, geofield and taxonomy fields, the widgets, the view modes, the pathauto pattern, the metatag defaults — this module ships that configuration as a unit, so the Place type exists and is editor-ready the moment it is enabled. It wires the type into the family's editorial workflow, scheduler, and metatag layer through `acquia_cms_common` third-party settings, auto-geocodes each Place's address into a geofield via the Google Maps geocoder, and provides Search-API views, facets and blocks for a Places listing.

The value and the limitation are the same fact: it is **distribution configuration, not a generic feature**. It encodes Acquia's opinions about what a Place is and expects its siblings (`acquia_cms_common`, `acquia_cms_image`, and the search/Site Studio stack) to be present — its install even calls the `acquia_cms_common.utility` service. On an Acquia CMS site it is exactly right; on an unrelated site it is a usable starting point but a strong set of assumptions to adopt, and you inherit the whole model. Because it is config, what it does is fixed by that config; extending it means adding fields and adjusting displays as with any content type, and it travels with a config export like any other content-type configuration.

---
- Add a ready-made Place (location/venue) content type to a site.
- Author a place with address, image, phone and description without building the type by hand.
- Get address-to-coordinates geocoding into a geofield automatically on save.
- Standardise Place content and its editing experience across a site.
- Get card, teaser, horizontal-card and search-result view displays out of the box.
- Get a configured Place form display with scheduler and moderation.
- Reuse Acquia CMS's Place model and content-type opinions.
- Get pathauto aliases like `place/<type>/<title>` for places.
- Get schema.org Place, Open Graph and Twitter-card metatag defaults for SEO.
- Categorise places with a Place Type taxonomy plus shared categories and tags.
- Provide a searchable, facetable Places listing via Search API.
- Enable content translation for place content.
- Grant place create/edit/delete permissions to the distribution's author/editor roles automatically.
- Enable Place as part of an Acquia CMS / Acquia Drupal Starter Kit build.
- Base a custom location type on this one and extend it with extra fields.
- Export the Place configuration with the rest of the site config.
- Match the Acquia CMS content model when adding venues, offices or points of interest.
- Feed place addresses and coordinates to map and directory displays.
- Provide editors a consistent, pre-wired Place authoring form.
- Use Place alongside the rest of the Acquia CMS module family.
