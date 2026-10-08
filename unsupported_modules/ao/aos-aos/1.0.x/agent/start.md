<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Animate on Scroll (aos) — agent index

Thin integration for the **AOS (Animate On Scroll)** JavaScript library — elements animate
(fade/slide/zoom) as they scroll into view. Project dir `aos-aos`; **module machine name `aos`**.
Package *Other*. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.2. No modules or
core dependencies beyond core JS.

- **The library, how to attach it, local-vs-CDN, and the `data-aos` markup API** →
  [library/attach.md](library/attach.md)

## What it actually is

- **No** routes, controllers, forms, permissions, services, entities, plugins, config objects,
  config schema, Drush commands or admin UI. The whole module is three files:
  `aos.libraries.yml`, `aos.module`, `js/script.js`.
- One asset library **`aos`** (`aos.libraries.yml`): AOS **3.0.0-beta.6** CSS + JS from
  `//cdnjs.cloudflare.com/ajax/libs/aos/3.0.0-beta.6/` (both `type: external`, protocol-relative),
  plus local `js/script.js`; depends on `core/jquery`, `core/drupal`, `core/drupalSettings`.
- `js/script.js`: `Drupal.behaviors.aos.attach` → `AOS.init()`.
- `aos.module`:
  - `hook_help()` — help text at `admin/help#aos`.
  - `hook_library_info_alter()` — if `library.libraries_directory_file_finder` locates
    `aos/aos.js` / `aos/aos.css` under the site's `libraries/` dir, it **replaces** the CDN
    entries with the local files (marked `minified: TRUE`). See drupal.org/node/3099614.

## How you use it

- The library is **not** attached globally. A theme/module must attach `aos/aos`
  (theme `.info.yml` `libraries:` list, or `#attached['library'][] = 'aos/aos'`).
- Opt elements in with **`data-aos="<animation>"`** attributes plus optional
  `data-aos-offset`, `data-aos-easing`, `data-aos-duration`, `data-aos-delay`, `data-aos-once`
  in your Twig/markup. Full animation/easing list: https://github.com/michalsnik/aos .

## Notes

- Uses AOS **3.0.0-beta.6** (a beta pin) from cdnjs; to self-host, unpack the library to
  `libraries/aos` (path must resolve to `libraries/aos/aos.js` and `.../aos.css`).
- Nothing here reads request input, hits an authenticated API, queries the DB, or renders remote
  data — presentation only.
