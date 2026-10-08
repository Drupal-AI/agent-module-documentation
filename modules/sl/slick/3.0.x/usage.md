Slick turns Drupal fields, media, and Views into responsive, touch-enabled carousels, sliders, and galleries powered by the Slick (or Accessible Slick) JavaScript library, configured through reusable optionsets.

---

Slick wraps the popular Slick / Accessible Slick jQuery carousel in Drupal and integrates it with the Blazy library for lazy-loading and responsive images. The heart of the module is the **optionset** configuration entity (`slick.optionset.*`): a named, exportable bundle of Slick options (slides to show, autoplay, arrows, dots, breakpoints, skin) that you reuse across many displays. It ships **field formatters** — `slick_image`, `slick_media`, `slick_file`, `slick_text` — so any image, media, or entity-reference field can be rendered as a carousel, plus a `slick_filter` text-format filter for inline carousels in body text. Presentation is customized through **skins**, a plugin type (`SlickSkin`) that registers CSS variants for arrows, dots, and slide styling. Developers build carousels programmatically through the `slick.manager` service (`SlickManagerInterface::build()`) and can reshape every render with a set of alter hooks defined in `slick.api.php`. It depends on Blazy and on the external Slick JS library placed under `/libraries`, and the companion **Slick UI** submodule provides the admin screens for managing optionsets. Theming is fully overridable via six Twig templates (slick, slide, grid, thumbnail, vanilla, wrapper). It is a widely used building block for image galleries, hero sliders, logo strips, and thumbnail navigations.

---

- Turn an image field on a content type into a swipeable carousel with the `slick_image` formatter.
- Build a hero slider on the front page from a media reference field.
- Create a logo/partner strip that scrolls multiple small images per view.
- Add a product image gallery with a large stage plus a thumbnail navigation (asNavFor).
- Render a Media field of videos and images as a mixed carousel.
- Show a testimonials slider from a text or entity-reference field.
- Insert an inline carousel inside body text using the `slick_filter` text filter.
- Reuse one autoplay optionset across dozens of displays for consistent behavior.
- Configure responsive breakpoints so a carousel shows 4 slides on desktop and 1 on mobile.
- Enable touch/swipe support for mobile image galleries.
- Add previous/next arrows and pager dots to a slideshow.
- Lazy-load carousel images via Blazy to improve page performance.
- Apply a prebuilt skin (classic, fullscreen, split, grid) without writing CSS.
- Register a custom SlickSkin plugin to ship your theme's own arrow and dot styles.
- Enable center mode to highlight the focused slide in a carousel.
- Create a vertical carousel for a sidebar news ticker.
- Build a grid-of-slides layout (multiple rows per slide) for dense galleries.
- Turn Views results into a carousel (with the Slick Views add-on).
- Provide an accessible, keyboard-navigable slider using the Accessible Slick library.
- Auto-attach a sitewide carousel initializer for hand-written markup.
- Generate a carousel in a custom module via the `slick.manager` service.
- Alter Slick's JS options globally with `hook_slick_options_alter()`.
- Override slide markup by overriding the `slick-slide.html.twig` template.
- Add mousewheel navigation to a carousel using the optional mousewheel library.
- Deploy carousel configuration between environments as exportable optionset config.
- Duplicate an existing optionset as a starting point for a new one.
