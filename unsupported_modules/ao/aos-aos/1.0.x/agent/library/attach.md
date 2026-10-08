<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# aos — attaching the library & the data-aos markup API

Source: `aos.libraries.yml`, `aos.module`, `js/script.js`. Machine name **`aos`**.

## Install / enable

Standard contrib install: `drush en aos`. No config step, no permissions, no settings form.
By default assets load from the cdnjs CDN, so the module works immediately once the `aos` library
is attached somewhere.

## The `aos` asset library

Defined in `aos.libraries.yml` as library id **`aos`** (referenced as `aos/aos`):

- CSS (theme group): `//cdnjs.cloudflare.com/ajax/libs/aos/3.0.0-beta.6/aos.css`
  (`type: external, minified: true`).
- JS: `//cdnjs.cloudflare.com/ajax/libs/aos/3.0.0-beta.6/aos.js` (`type: external, minified: true`)
  and local `js/script.js`.
- Dependencies: `core/jquery`, `core/drupal`, `core/drupalSettings`.
- `remote:` / `version: 3.0.0-beta.6`, MIT-licensed upstream (gpl-compatible).

`js/script.js` registers `Drupal.behaviors.aos` whose `attach()` calls `AOS.init()` — so the
animations are wired up on page load and after AJAX inserts.

### Attaching it (required — nothing is global)

The module never attaches `aos/aos` for you. Do one of:

- Theme-wide, in `THEME.info.yml`:
  ```yaml
  libraries:
    - aos/aos
  ```
- Per render array / preprocess:
  ```php
  $variables['#attached']['library'][] = 'aos/aos';
  ```
- Per Twig template: `{{ attach_library('aos/aos') }}`.

## Local (self-hosted) assets — `hook_library_info_alter()`

`aos_library_info_alter()` (in `aos.module`) uses the core
`library.libraries_directory_file_finder` service to look for `aos/aos.js` and `aos/aos.css`
under the site `libraries/` directory. If found, it **overrides** the CDN `js`/`css` entries with
those local paths (`minified: TRUE`). To self-host, download AOS and unpack so the paths resolve
to `libraries/aos/aos.js` and `libraries/aos/aos.css` (see drupal.org/node/3099614). If you fetch
the library via Composer/asset-packagist (unminified), the README notes you may need to disable
the `minified` flag.

## The `data-aos` markup API

Add attributes to any element you want animated (nothing is animated automatically):

```html
<div data-aos="fade-zoom-in"
     data-aos-offset="200"
     data-aos-easing="ease-in-sine"
     data-aos-duration="600"
     data-aos-delay="100"
     data-aos-once="true">
</div>
```

- `data-aos` — animation name (e.g. `fade-up`, `fade-left`, `zoom-in`, `flip-left`).
- `data-aos-offset` — trigger offset in px.
- `data-aos-duration` / `data-aos-easing` / `data-aos-delay` — timing & easing.
- `data-aos-once` — animate only once vs. re-animate on re-scroll.

Full list of animations and easings: https://github.com/michalsnik/aos . These attributes go in
your own templates, block bodies or field markup; the module contributes only the library and the
`AOS.init()` call.

## hook_help

`aos_help()` returns a short description at `admin/help#aos` (Administration › Help › Animate on
Scroll). No other admin surface exists.
