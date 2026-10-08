<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Running the countries / regions import

## Prerequisites
- Modules `file`, `migrate`, `svg_image`, `content_translation`, `token` enabled.
- A taxonomy vocabulary to receive the terms, with fields for ISO-2, ISO-3 and a flag image (SVG).

## Configure
1. Go to `admin/config/content/countries-import` (requires **administer site configuration**).
2. Select the target vocabulary and map:
   - ISO-2 (alpha-2) → a text field,
   - ISO-3 (alpha-3) → a text field,
   - flag → an image field (SVG handled by svg_image).
3. Save; run the country import (form submit triggers `CountriesService::import()`).
4. Switch to the **Geographic Regions** tab (`geographic_regions.settings`, `.../geographic-regions`) to import regions via `RegionsService::import()`.

## What happens
- `CountriesService::import()` creates/updates one taxonomy term per country, setting the mapped ISO and flag fields; `FileUtils` writes the flag image files (using `@file_system`, `@token`, `@extension.path.resolver`).
- `content_translation` support means the resulting terms can be translated.

## Notes
- Import is idempotent-style reference-data seeding; re-run to refresh.
- No Drush command is provided; import runs from the settings form.
- `config` route: `countries_import.settings` (declared as the module's `configure` link).