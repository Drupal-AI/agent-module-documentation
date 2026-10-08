Layout BG adds Layout Builder section layouts with a dedicated **background region**. You drop any block (typically an image or media field block) into that region and Layout BG renders it as a real `<img>`/`<video>` behind the content using CSS `object-fit`, so it behaves like a background image while staying compatible with image styles, responsive images, and lazy loading.

---

The module defines two `*.layouts.yml` layout plugins — `layout_bg_onecol` (one content region) and `layout_bg_twocol` (first/second regions) — each adding a `background` region on top of a core base layout. `LayoutBgOneCol` extends core `LayoutDefault`; `LayoutBgTwoCol` extends core `TwoColumnLayout`; both mix in `\Drupal\layout_bg\LayoutBgTrait`, which does the real work. At build time the trait keeps only the first non-empty block in the background region (`processed_background`, remaining blocks kept solely for cache metadata), suppresses that block's label, and layers on inline-style attributes for a fallback background color, an optional colored overlay with opacity, an optional text color (with link-underline toggle), and a `static-image` vs `absolute-image` positioning class. A shared template `layout--layout-bg.html.twig` renders an edit-mode preview and the front-end markup, then `{% include %}`s the base layout template (`layout--onecol.html.twig` / `layout--twocol-section.html.twig`) for the content regions. Per-section settings are stored on the Layout Builder section config and validated by `config/schema/layout_bg.schema.yml` (`layout_plugin.settings.layout_bg_onecol` / `..._twocol`). There is no global configuration and no permissions of its own — it relies entirely on Layout Builder access. The `examples/` folder ships several non-enabled sample sub-modules (article teaser, bricks, paragraph, thumb-over-thumb) demonstrating usage patterns.

---

- Give a Layout Builder section a full-bleed background image without a special background field formatter.
- Use a media reference or image field block as a section background.
- Keep responsive images working on a background (real `<img>` + `object-fit`).
- Combine with Blazy or core lazy loading for a lazily loaded background image.
- Use an autoplaying `<video>` block as a section background.
- Add a semi-transparent colored overlay over the background to improve text contrast.
- Tune overlay color and opacity per section.
- Set a fallback background color shown before/if the image fails to load.
- Set the content text color (and link color) inline for a section over a dark image.
- Toggle underlining of links within a background section.
- Choose a one-column background layout for hero banners.
- Choose a two-column background layout with a shared background behind both columns.
- Center content vertically and horizontally over a static background image.
- Switch between static (takes DOM space) and absolute (out of flow) background positioning.
- Build a card/brick grid where each item has its own background (see the bricks example).
- Give paragraphs a background region via the paragraph example pattern.
- Reuse the same background block across multiple viewport sizes with responsive image styles.
- Provide an accessible background where the image is real content rather than a CSS background.
- Extend the trait to add a background region to your own custom layout plugin.
- Override `layout--layout-bg.html.twig` in a theme to customize the wrapper markup.
- Suppress noisy block labels automatically in the background region.
- Present a WYSIWYG-embedded image as a section background.
