# Libraries Provider Font Awesome — agent index

Defines Font Awesome as a Drupal **asset library** (CDN by default). No code, config, routes,
permissions or plugins (`configure: null`) — it is just a `lp_fontawesome.libraries.yml`.

- **The two library definitions, how to attach them, version mapping, and libraries_provider** →
  [theming/library.md](theming/library.md)

Key facts:
- Attach `lp_fontawesome/fontawesome` (CSS/webfont build) or `lp_fontawesome/fontawesome-svg`
  (SVG+JS build). Attach via `#attached['library'][]`, a `*.libraries.yml` dependency, or
  `{{ attach_library('lp_fontawesome/fontawesome') }}`.
- Loads Font Awesome **6.7.2** from `cdn.jsdelivr.net` (npm `@fortawesome/fontawesome-free`).
- Module version maps to FA with the minor ×10: module `6.7.20` = Font Awesome `6.7.2`.
- Optional `drupal/libraries_provider` (not required) lets you change the version or load assets
  from the local filesystem, via the `libraries_provider` keys on each library.
