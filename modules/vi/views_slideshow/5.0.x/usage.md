Views Slideshow adds a "Slideshow" display style to Views that renders the rows of any View as a jQuery-powered slideshow. It is an API/framework: it defines the style and widgets but needs an engine submodule (Views Slideshow Cycle) or another implementation to actually animate the slides.

---

Views Slideshow registers a `slideshow` Views style plugin (`Drupal\views_slideshow\Plugin\views\style\Slideshow`) that you select as the display format on any View. The style itself only builds the markup and settings form; the actual rotation is delegated to a **slideshow type** plugin — the bundled `views_slideshow_cycle` submodule provides the `views_slideshow_cycle` (jQuery Cycle) type, and you can write your own. Around the slides the module renders configurable **widgets** (previous/next/pause text controls, a pager, and a slide counter) at the top and/or bottom of the slideshow, each defined as `ViewsSlideshowWidget`/`ViewsSlideshowWidgetType` plugins. A **skin** plugin (`ViewsSlideshowSkin`, the module ships a single `default` skin) controls swappable layout/CSS. Everything is configured per View display under Format → Slideshow settings (skin, slideshow type, and which widgets appear where); nothing is a global config form. The module supplies four plugin managers (type, widget, widget type, skin), matching annotations, base classes, a set of Twig templates + theme hooks, a small JS behavior (`views_slideshow.js`) that coordinates the widgets and the engine, and `hook_*_info` alter hooks for each plugin registry. It works with images, rendered entities, or any fields a View can output, so a "slideshow" can be news teasers, product cards, testimonials, or a plain image carousel. It requires only core Views; the Cycle engine additionally needs external jQuery libraries installed under `/libraries`.

---

- Turn a View of the latest news articles (title + image + teaser) into a rotating slideshow.
- Build an image carousel from an image field on content or media.
- Rotate the newest X items of any type (blog posts, forum topics, comments, testimonials).
- Show "hottest new products" as a rotating banner on an e-commerce site.
- Save space by collapsing a long list of items into one cycling region.
- Add previous / next text controls above or below the slides.
- Add a pause / play control so visitors can stop the rotation.
- Add a bullet pager so users can jump to a specific slide.
- Add a field-based pager (thumbnails or labels rendered from a View field).
- Add a "slide X of Y" counter widget to the slideshow.
- Place widgets at the top, the bottom, or both, and order them by weight.
- Hide a widget automatically when the View returns only one slide.
- Choose a skin to swap the slideshow's layout/CSS without touching the engine.
- Select which slideshow engine renders the animation (e.g. Cycle) per display.
- Rotate fully rendered entities, not just images, using the View's row plugin.
- Combine standard Views filters/sorts/arguments with a slideshow (e.g. random order, category).
- Provide a JavaScript API surface so other modules can add a custom slideshow engine.
- Implement a custom `ViewsSlideshowType` plugin to integrate a different JS slider library.
- Implement a custom `ViewsSlideshowWidget` to add a new control (e.g. a custom pager).
- Register a custom skin plugin to ship reusable slideshow themes.
- Override the slideshow Twig templates (main section, pager, controls, counter) in a theme.
- Alter the registered plugin definitions via `hook_views_slideshow_type_info` and friends.
- Export slideshow settings as part of the View's configuration between environments.
- Use `usesFields`/row plugins to mix multiple fields into each slide.
- Coordinate multiple widgets with the engine through the shared `views_slideshow.js` behavior.
