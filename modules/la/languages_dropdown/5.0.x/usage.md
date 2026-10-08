<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Languages Dropdown (Bootstrap) renders Drupal's language switcher as a compact Bootstrap 5 dropdown of country flags and/or language labels instead of a flat list of links.

---

Install the module with Composer (`composer require drupal/languages_dropdown`) and enable it; it depends only on core **Language**, so you also need at least two configured languages and language negotiation set up. The flags come from the external **Bootstrap 5 Languages** library — download `danrod96-new/bootstrap5-languages` and extract it to `/libraries/bootstrap5-languages` (the status report at `admin/reports/status` warns if it is missing). Then go to **Structure → Block layout**, place the **"Language switcher (Bootstrap)"** block in a region (typically the header), and in its *Bootstrap settings* choose **Dropdown display components** (`Icons and text` or `Only icons`) and **Icon Size** (`Small`, `Medium`, or `Large`). The block can be placed multiple times. On a Bootstrap 5 theme the dropdown just works; on a non-Bootstrap theme the module loads Bootstrap 5.3.5 JS/CSS from a CDN so the toggle still functions — this 5.x branch is meant for Bootstrap 5 sites, and the maintainers point everyone else to the older 3.0.x release. There is no global configuration page: every option lives on the block instance, so different regions or language types can show different styles.

---

- Replace the core language switcher with a dropdown.
- Show many languages in one compact control.
- Add a flag-based language switcher to a header.
- Show country flags next to language names.
- Show flags only, without labels, to save space.
- Pick a small, medium, or large flag size per block.
- Place a language switcher on a Bootstrap 5 theme.
- Fit a switcher for fifteen languages into one button.
- Keep site navigation on a single row.
- Improve mobile language switching with a dropdown.
- Style the switcher to match a Bootstrap theme.
- Place multiple switcher blocks in different regions.
- Show a separate switcher per language type.
- Add a switcher to a non-Bootstrap theme via the CDN fallback.
- Display regional language variants compactly.
- Reduce header clutter from many language links.
- Highlight the current language with an active class.
- Configure the switcher entirely per block instance.
- Support an institutional or multi-market multilingual site.
- Give an agency-built Bootstrap site a themed language switcher.
