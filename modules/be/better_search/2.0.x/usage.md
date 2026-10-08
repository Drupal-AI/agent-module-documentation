<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Better Search Block restyles Drupal's core search block (and optionally the search results page form) with a placeholder, a search icon, and one of four CSS hover/focus animations.

---

The module is a lightweight theming layer over core's search forms — no new block, field, or entity. A single settings form (`/admin/config/search/better-search`, route `better_search_settings`) writes the `better_search.settings` config: `placeholder_text`, `theme` (0–3), `size`, `searchpage_enable`, `searchpage_submit_not_visible`, `input_name`, and `block_form_id`. At render time `better_search_form_alter()` matches the configured `block_form_id` (default `search_block_form`) and core's `search_form`, attaches the CSS library for the chosen `theme` (`background_fade`, `expand_on_hover`, `increase_icon_size`, or `on_hover_button`), injects an icon `<div class="icon"><i class="better_search"></i></div>` before or after the input, sets the placeholder text and input `#size`, and visually hides the submit button. The four animations are pure CSS libraries in `better_search.libraries.yml`; the `theme` radio maps 0→background fade, 1→expand on hover, 2→expand icon on hover, 3→slide icon on hover. Advanced settings let you point the alter at a different form id or input name so it works with custom or contrib search blocks. There are no dependencies beyond core, no schema, no plugins, and one permission, `administer Better Search settings`, guarding the config form.

---

- Add a styled placeholder (e.g. "Search this site…") to the core search block.
- Give the search block a magnifying-glass icon without editing a theme template.
- Apply a background-fade animation to the search field on focus.
- Make the search field expand on hover to save space until used.
- Enlarge the search icon on hover for a more prominent search affordance.
- Use a slide-in icon/button hover effect on the search box.
- Hide the search block's submit button so only the icon/field shows.
- Restyle the search results page form (`search_form`), not just the block.
- Toggle whether the search-results page form is altered (`searchpage_enable`).
- Hide the submit button specifically on search pages while keeping it elsewhere.
- Set the width of the search input via the size selector (10–30).
- Change the placeholder text site-wide from one settings form.
- Point the theming at a custom search block by changing the `block_form_id`.
- Adapt the alter to a non-standard field by changing the `input_name`.
- Make a contrib/custom search form pick up the same icon + animation styling.
- Provide a nicer search UX with a couple of clicks instead of custom CSS/JS.
- Keep search styling as exportable configuration (`better_search.settings`) across environments.
- Match the search box look to a Bootstrap-based theme (submit-hiding handles Bootstrap).
- Give editors a consistent search box across block placements and the search page.
- Switch animation styles quickly by changing one radio setting.
- Deliver an accessible visually-hidden submit button while keeping the field usable.
- Add a `clearfix` class to search-type form elements for cleaner layout.
- Restrict who can change the search styling with the `administer Better Search settings` permission.
- Prototype different search-box styles rapidly during theme development.
- Improve the default, unstyled core search block appearance on a fresh site.
