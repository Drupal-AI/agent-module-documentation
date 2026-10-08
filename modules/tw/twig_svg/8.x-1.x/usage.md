<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Twig SVG adds an `icon()` Twig function that drops an inline SVG icon into a template by referencing a symbol from an SVG sprite.

---

The function is small on purpose: `{{ icon('arrow') }}` renders `<span class="icon__wrapper"><svg ...><use xlink:href="#arrow"></use></svg></span>`, i.e. a `<use>` reference to the symbol whose `id` is `arrow`. You can pass more: `{{ icon('arrow', 'Next', ['big'], {}, ['nav']) }}` sets an accessible title (`role="img"`, `title`, `aria-label`; without a title the SVG is `aria-hidden`), adds CSS classes (defaults are `icon icon--arrow`), and wrapper classes. For the reference to resolve, the sprite that defines `<symbol id="arrow">` must be inlined into the page, which the module handles in `hook_preprocess_html`: it automatically inlines `images/icons.svg` from your **active theme and its base themes**, and it also inlines every path listed in the **Icon locations** setting at `/admin/config/twig_svg/config` (one path per line, relative to the site root, e.g. `modules/example/example.svg`) — the settings form is behind the `administer twig svg configuration` permission. The recommended build workflow (the module credits Lullabot's SVG-sprite technique) is to combine your individual icons into one `your_theme/images/icons.svg` sprite (for example with `gulp-svgstore`/`gulp-cheerio`) so all icons live in one place and cost no extra HTTP request. Requires Drupal core `^10 || ^11` and has no other module dependencies.

---

- Inline an SVG icon in a Twig template with `{{ icon('name') }}`.
- Reference a sprite symbol by its `id` from a template.
- Add an accessible title to an icon (`role="img"`, `aria-label`).
- Render a decorative icon that is `aria-hidden="true"`.
- Add extra CSS classes to an icon: `icon('name', '', ['big'])`.
- Add wrapper classes around an icon.
- Colour an SVG icon from CSS using `currentColor`.
- Let an icon inherit the surrounding font size.
- Animate an inline SVG icon with CSS.
- Serve a whole icon set as one sprite, with no per-icon request.
- Auto-inline your theme's `images/icons.svg` sprite on every page.
- Inherit icons from a base theme's `images/icons.svg`.
- Register extra sprite files via the Icon locations settings form.
- Point the module at a module-provided sprite (e.g. `modules/example/example.svg`).
- Build a combined sprite with gulp-svgstore and reference it here.
- Add a themed arrow or chevron icon to navigation.
- Add social-media icons to a footer.
- Provide a design system's icon library to templates.
- Restrict who can change icon locations via a dedicated permission.
- Reduce HTTP requests by inlining icons instead of `<img>` tags.
- Give icons a consistent `icon` / `icon--name` class hook for styling.
- Reuse the same icon markup across many templates from one function.
