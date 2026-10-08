Libraries Provider Font Awesome is a tiny module that defines Font Awesome as a Drupal asset library (loaded from the jsDelivr CDN by default), so themes and modules can attach Font Awesome icons without bundling the files themselves.

---

The module ships only a `lp_fontawesome.libraries.yml` (no code, config, routes, permissions or plugins). It declares two asset libraries: `lp_fontawesome/fontawesome`, the CSS/webfont build that pulls `all.min.css` for Font Awesome 6.7.2 from `cdn.jsdelivr.net`, and `lp_fontawesome/fontawesome-svg`, the SVG-with-JS build that loads `all.min.js` instead (and is marked to replace the CSS library when used). Each library carries extra `libraries_provider` metadata (source `cdn.jsdelivr.net`, npm package `@fortawesome/fontawesome-free`) so that, if you also install the optional `libraries_provider` module, you can change the version or serve the assets from the local filesystem instead of the CDN — but `libraries_provider` is not required because the definition works out of the box. You use it like any Drupal library: attach `lp_fontawesome/fontawesome` from a render array (`#attached`), a theme/module `*.libraries.yml` dependency, or a Twig `{{ attach_library('lp_fontawesome/fontawesome') }}`, then use Font Awesome `<i class="fa-solid fa-…">` markup. Note the module version encodes the upstream version with the minor multiplied by ten: module `6.7.20` corresponds to Font Awesome `6.7.2`. It originated as the default icon set for the Drulma theme.

---

- Add Font Awesome icons to a theme without downloading or committing the icon files.
- Attach Font Awesome CSS on a page with `{{ attach_library('lp_fontawesome/fontawesome') }}` in a Twig template.
- Declare `lp_fontawesome/fontawesome` as a dependency in your theme's `*.libraries.yml`.
- Attach the library from a render array via `$build['#attached']['library'][] = 'lp_fontawesome/fontawesome';`.
- Load Font Awesome from the fast jsDelivr CDN with zero setup.
- Switch to the SVG + JS build by attaching `lp_fontawesome/fontawesome-svg` instead of the CSS build.
- Provide the icon set the Drulma theme expects.
- Use Font Awesome `<i class="fa-solid fa-star"></i>` markup anywhere on the site.
- Standardise on one Font Awesome library across multiple custom modules/themes.
- Pair with the `libraries_provider` module to pin a different Font Awesome version.
- Pair with `libraries_provider` to serve Font Awesome assets from the local filesystem instead of a CDN.
- Avoid version drift by relying on the module's declared FA version (6.7.2) rather than ad-hoc CDN links.
- Give block/field templates access to icon fonts by attaching the library where needed.
- Add icons to an admin or front-end custom form by attaching the library in its render array.
- Keep icon delivery out of your theme build pipeline (no npm/webpack needed).
- Let a distribution ship Font Awesome as a reusable, named library dependency.
- Load icons only on the pages that need them by attaching the library selectively.
- Use SVG icons (with JS) when you need per-icon styling/animation via `lp_fontawesome/fontawesome-svg`.
- Reference `@fortawesome/fontawesome-free` metadata for tooling via the libraries_provider keys.
