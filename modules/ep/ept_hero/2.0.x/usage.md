<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EPT Hero adds a ready-made Hero paragraph — media image, title prefix, title, body text and two call-to-action buttons in a two- or one-column layout — from the Extra Paragraph Types family, built on `ept_core` and `ept_basic_button`.

---

The hero is the first component every page builder needs and the one every project rebuilds: a heading, a supporting sentence, one or two calls to action, usually beside or over an image. Building it from scratch means a paragraph type, half a dozen fields, a template and a set of style options before anything site-specific is done. EPT Hero supplies all of that pre-built. The paragraph type ships seven fields — a media reference (`field_ept_hero_column_image`, restricted to the `image` media type), a `field_ept_hero_title_prefix` (text), `field_ept_title`, `field_ept_text`, a primary link (`field_ept_hero_link`) and a second link (`field_ept_hero_second_link`), plus the shared `field_ept_settings` — and a `paragraph--ept-hero--default.html.twig` template lays them out as `hero-col-1` (image) and `hero-col-2` (text + buttons). A custom field widget (`ept_settings_hero`, extending `ept_basic_button`'s widget) adds hero-only controls: **Styles** (2 Columns / One column, each attaching its own CSS library), image position (left/right on desktop, first/last/hide on mobile), a mobile breakpoint, an optional colour overlay with opacity, a second set of link options, and per-element additional-classes fields. Both buttons are rendered through **`ept_basic_button`**, so hero CTAs are a shared component rather than a link field styled by hope — the detail that keeps buttons consistent between the hero and everything else. Per-paragraph style becomes markup in two ways: the widget writes CSS classes onto the wrapper, and three services (`ept_core`'s `GenerateCSS`, `ept_basic_button`'s `GenerateCustomCSS`, and this module's `GenerateHeroCSS`) build a small per-paragraph `<style>` block — scoped by a `paragraph-id-N` class — that the template prints for column ordering, the mobile media query and the overlay. Version **2.0.1**, core `^10.1 || ^11 || ^12`. Two things to weigh, the same trade as the rest of the family: **pre-built is quick to adopt and awkward to diverge from** — the markup and field structure are the module's, so a design the settings do not cover means overriding the template, and at that point a locally defined type is often cheaper; and **it becomes a dependency of the content** — pages are built from it, so removing the module later leaves paragraph entities with no type. Beyond that, a hero is worth one check nothing in the module can do for you: **the heading level** — the title renders as whatever the `field_ept_title` text field emits, and a hero placed mid-page is usually not the page's `h1`.

---

- Add a hero banner to the top of a landing page.
- Build a page header with a heading, subheading and two buttons.
- Place an image beside marketing copy in a two-column hero.
- Switch a hero to a single centred column for a full-width banner.
- Put the image on the right and the text on the left.
- Add a colour overlay over a background so text stays readable.
- Set where the image goes on mobile — first, last, or hidden.
- Choose the breakpoint at which two columns collapse to one.
- Give a campaign page a strong opening section.
- Add a primary CTA plus a secondary "learn more" link.
- Open a service page with a consistent, reusable header.
- Add a small title prefix (eyebrow) above the main heading.
- Keep hero button styling consistent with other EPT buttons.
- Build a homepage opening section without custom code.
- Add per-element CSS classes for theme-specific styling.
- Set a button to open in a new tab or carry rel="nofollow".
- Add configurable spacing, border and background via EPT Settings.
- Reuse the same hero pattern across many editors on one site.
- Give editors a ready-made banner they can fill in via tabs.
- Build a microsite header quickly from the paragraphs UI.
- Create an event page's opening block with date and CTA.
- Add a hero over a media-library background image.
