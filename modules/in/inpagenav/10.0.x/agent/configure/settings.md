<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — Inpage navigation

## Settings form
`/admin/structure/inpagenav/settings/config_settings` (needs `administer site configuration`), config object `inpage.settings`:
- **parent_wrappper** — CSS class of the container div that holds the headings to scan.
- **tag_wrapper** — wrapper class(es) whose headings should be EXCLUDED from the nav.
- **card_tag_wrapper** — wrapper class(es) for headings inside card components to exclude.
- **tags_to_include** — comma-separated heading levels to include, e.g. `h1, h2, h3`.

## Placement
Place the **Inpage Navigation Block** (`inpage`) in a region via Block Layout. On render, `InPageNav::build()` reads `inpage.settings` and attaches them to `drupalSettings` (`inpage_parent_wrappper`, `tag_wrapper`, `tag`, `card_tag_wrapper`) plus the `inpagenav/inpagenav` library; the JS builds the jump-link list from the matching headings in the live DOM, themed by the `inpagenav` template.
