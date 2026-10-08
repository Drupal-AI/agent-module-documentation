<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Imports the full list of world countries (with ISO-2, ISO-3 codes and flag SVGs) and geographic regions into a taxonomy vocabulary from an admin form.

---
The module ships country and region data and turns it into taxonomy terms so a site instantly has a reusable, translatable country list. An admin settings form at `admin/config/content/countries-import` (permission `administer site configuration`) lets you choose the target vocabulary and map the ISO-2, ISO-3 and flag values onto fields on that vocabulary's terms; a second tab imports geographic regions. `CountriesService::import()` and `RegionsService::import()` do the work, using `FileUtils` to place the flag image files (SVG, via the svg_image module) and the token + content_translation modules for naming and multilingual terms.

Because the country/region catalogue is static reference data, the import is a one-off (or occasional refresh) administrative task rather than a runtime integration. Everything runs behind the site-configuration permission; there are no public endpoints.

Typical setup: pick or create a taxonomy vocabulary with fields for ISO-2, ISO-3 and a flag image, configure those mappings on the settings form, then run the import; optionally import regions on the second tab and translate the resulting terms.
---
- Populate a taxonomy vocabulary with every country.
- Store ISO-2 (alpha-2) codes on country terms.
- Store ISO-3 (alpha-3) codes on country terms.
- Attach each country's flag as an SVG image field.
- Import geographic regions as taxonomy terms.
- Map imported values onto chosen term fields via the settings form.
- Provide a reusable country reference list for forms/fields.
- Create translatable country terms (content_translation).
- Refresh the country list when data changes.
- Use token integration when naming imported terms.
- Choose the target vocabulary for the import.
- Seed an address or shipping country list.
- Give editors a ready-made country entity-reference source.
- Import flags for display in country listings.
- Restrict import to site-configuration admins.
- Build region-based grouping of countries.
- Bootstrap a new site's geographic data quickly.
- Standardise country naming across the site.
- Back country autocomplete/select fields with taxonomy terms.
- Manage countries and regions from a single settings page.