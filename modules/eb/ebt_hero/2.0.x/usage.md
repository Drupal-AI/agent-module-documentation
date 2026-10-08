EBT Hero adds a reusable "Hero" custom block type — title, subtitle, body, a media image and two buttons — with two-column or one-column layouts, an optional background overlay and a configurable mobile breakpoint, for placement in Layout Builder.

---

Enabling `ebt_hero` creates a `block_content` bundle called `ebt_hero` with a fixed set of fields: a two-tab edit form (Content / Settings) built with `field_group`. The Content tab holds `field_ebt_hero_title` (text_long), `field_ebt_hero_title_prefix` (text_long, used as a kicker/subtitle), `body`, `field_ebt_hero_column_image` (an entity reference to a Media `image`, edited with the Media Library widget), and two link fields `field_ebt_hero_link` and `field_ebt_hero_second_link`. The Settings tab holds `field_ebt_settings`, edited by the module's `ebt_settings_hero` widget which extends EBT Basic Button's settings widget and adds hero-specific controls: layout style (`two_columns` / `one_column`), image position (left/right), mobile image order (image first / last / hidden), a mobile breakpoint in pixels, and an optional overlay (color + opacity) drawn between the background and the text. On render, `ebt_hero_preprocess_block()` (in `EbtHeroHooks`) calls two services — `ebt_basic_button.generate_custom_css` and `ebt_hero.generate_hero_css` — to emit per-block inline `<style>` for the buttons and the hero columns/overlay, scoped to a block-revision-specific CSS class. Two Twig templates (`block--block-content--ebt-hero` and `block--inline-block--ebt-hero`) lay out the columns and buttons. The module requires EBT Core (shared design options), EBT Basic Button, Paragraphs, core Link and Media, and expects a Media `image` type to exist before install (a `hook_requirements` check blocks install otherwise). It defines no routes, permissions, Drush commands or config-settings form of its own; global colors and breakpoints come from EBT Core's settings.

---

- Build a landing-page hero banner with a headline, supporting text and a primary/secondary call-to-action button.
- Add a two-column hero: a media image on one side and title + body + buttons on the other.
- Flip the image to the right side in the two-column layout via the image-position setting.
- Use the one-column style for a centered, full-width hero with text over a background.
- Place a hero block inside Layout Builder sections in "few clicks" alongside other EBT block types.
- Reuse the same hero across pages by creating it as a reusable custom block and placing it in multiple layouts.
- Create inline (one-off) hero blocks per page using Layout Builder's inline block flow.
- Add a subtitle/kicker above the main title using the dedicated title-prefix field.
- Attach two distinct buttons (e.g. "Get started" and "Learn more") with independent styling via the second-link options.
- Open a hero button in a new tab or mark it `rel="nofollow"` through the link options.
- Darken a busy background photo behind hero text with the colored overlay (color + adjustable opacity) for contrast.
- Control how the image and text stack on phones: show the image first, last, or hide it entirely below the breakpoint.
- Set a custom mobile breakpoint per hero to decide when two columns collapse to one.
- Style hero buttons (shape, size, alignment, custom hover colors, stretched, custom class) using the inherited EBT Basic Button settings.
- Apply EBT Core design options (margins/paddings/borders, background color/image/video, edge-to-edge vs container width) to the hero block.
- Lazy-load the hero image (the default view display sets the media thumbnail loading attribute to `lazy`).
- Add a custom CSS class name to a hero block or button to hook site-specific theme styles.
- Use the module's default CSS libraries (`common`, `one_column`, `two_columns`) attached automatically per selected style.
- Combine with `layout_builder_modal` for a nicer add-block UI when building pages with hero blocks.
- Ship a consistent hero component across a site so editors don't hand-build banners in the body field.
- Translate hero fields (title, body, links, settings are translatable) for multilingual landing pages.
