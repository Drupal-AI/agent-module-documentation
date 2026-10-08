Parallax Background applies a vertical jQuery parallax scroll effect to the background of any DOM element, configured through "Parallax element" config entities that each map a jQuery selector to a position and scroll speed.

---

The module defines a `parallax_element` config entity (managed at *Structure → Parallax elements*, route `entity.parallax_element.collection`, permission `administer parallax elements`). Each entity stores a **label that is a jQuery selector** (e.g. `#top-content`, `body.front #banner`), a background **position** (Left/Center/Right → `0`/`50%`/`100%`), a **speed** (0–3 in 0.1 steps), an optional description, and a published flag. On every page, `parallax_bg_page_attachments()` loads all enabled parallax elements, builds a settings array (`selector`, `description`, `position`, `speed`), runs it through `hook_parallax_bg_settings_alter()`, and attaches the `parallax_bg/parallax_bg` library plus the settings as `drupalSettings.parallax_bg`. The front-end JS (`js/parallax_bg.js`) reads those settings and initializes the bundled jQuery parallax plugin (`jquery.parallax-1.1.3.js`, plus localScroll/scrollTo) against each selector. Output is cached with the `config:parallax_element_list` cache tag so changes invalidate correctly. There is no global settings form beyond the entity collection; configuration is entirely the list of parallax elements. The module ships its own jQuery plugin copies and depends only on core (jQuery, once, drupal, drupalSettings).

---

- Add a parallax scrolling effect to a hero/banner element's background image.
- Apply parallax to the site `body` background for a full-page effect.
- Target a specific region or block by CSS id/class and give it a parallax background.
- Configure different scroll speeds per element for layered depth.
- Set background horizontal position (left/center/right) per parallax element.
- Enable/disable a parallax effect without deleting its configuration (published flag).
- Manage multiple parallax elements from one admin list.
- Use any valid jQuery selector to pick the element that holds the background.
- Create a subtle slow-scroll background on a landing page section.
- Give a one-page/scrolling site distinct parallax speeds for each section.
- Apply parallax only on the front page by scoping the selector (e.g. `body.front #banner`).
- Alter parallax settings programmatically via `hook_parallax_bg_settings_alter()` (e.g. change speed per selector).
- Adjust an element's parallax speed for a specific theme or condition through the alter hook.
- Add decorative motion to marketing pages without writing custom JS.
- Reuse the same parallax configuration across all pages where the selector exists.
- Restrict who can manage parallax effects via the `administer parallax elements` permission.
- Export/deploy parallax effects as config (config entities in `parallax_bg.parallax_element.*`).
- Keep parallax markup theme-agnostic by targeting existing elements rather than adding wrappers.
- Layer parallax on top of an existing background-image CSS rule.
- Provide a lightweight, dependency-free (core jQuery only) parallax option.
