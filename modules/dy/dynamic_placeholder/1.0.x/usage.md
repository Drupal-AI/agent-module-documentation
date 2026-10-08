<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Dynamic Placeholder cycles a configurable list of placeholder texts through one CSS-targeted text input, adding an animated "Search News / Search Events / ..." affordance without writing any code.

---

Dynamic Placeholder is a small, dependency-free UI module for Drupal 10/11. On every page it reads a single site-wide config object (`dynamic_placeholder.settings`), and — when enabled — attaches a JavaScript library plus a `drupalSettings.dynamicPlaceholder` payload. A Drupal behavior then finds the input(s) matching an admin-supplied CSS selector and rotates their `placeholder` attribute through the configured list at a fixed interval, optionally with a prefix (e.g. "Search "), randomized order, pause-on-focus, and a CSS fade/slide transition. There are no entities, no fields, no permissions of its own, no config schema, and no external services — it is purely a settings form (`/admin/config/user-interface/dynamic-placeholder`, gated by the core `administer site configuration` permission) plus a client-side rotator. Rotation stops automatically while the user is typing and resumes when the field is cleared.

---

- Add rotating example search terms ("Search Curd", "Search Books", "Search News") to a site's main search box to hint at what can be searched.
- Enhance the core Search block input by targeting `#edit-keys` or `input[name="keys"]`.
- Animate a Search API fulltext input via `input[name="search_api_fulltext"]`.
- Animate a Views exposed-filter search field via `.views-exposed-form input[type="search"]`.
- Guide users on an e-commerce storefront by cycling popular product categories through the search placeholder.
- Show seasonal/campaign suggestions ("Search Holiday Deals", "Search Gift Cards") that editors update centrally via config.
- Prefix every rotating item with a common verb ("Find ", "Search ", "Look for ") using the placeholder-prefix field.
- Rotate items in randomized order so repeat visitors see varied suggestions.
- Pause rotation while a visitor is focused on the field so it does not distract while they read/type.
- Choose an instant swap or a fade-in/out (fast/slow) or slide transition between items for a polished feel.
- Slow the cadence (e.g. 4000 ms) for long phrases, or speed it up (e.g. 800 ms) for short single words.
- Target a header search input by class, e.g. `.header-search input[type="search"]`.
- Improve discoverability of underused site sections by advertising them in the search hint.
- Provide a lightweight alternative to custom theme JavaScript for a rotating placeholder effect.
- Turn the effect on or off site-wide with a single "Enable" checkbox, keeping the item list saved for later.
- Localize/adjust suggestions per deployment by exporting `dynamic_placeholder.settings` with configuration management.
- Apply the effect to a single, precisely chosen input by using an ID selector such as `#my-search-input`.
- Demonstrate a "did you mean / try searching for" pattern on a landing page search box.
- Keep the input's original placeholder as a static fallback for browsers with JavaScript disabled (the module only enhances via JS).
