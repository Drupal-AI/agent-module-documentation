<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
## What it does

- Bundles Bootstrap 5 CSS and JS and attaches the library so Bootstrap classes work across the site.
- Gives non-Bootstrap themes an easy way to opt into the Bootstrap 5 grid, components and utilities.
- No configuration UI — enabling the module is the whole setup.

---

## Install & configure

- Enable the module (note the actual machine name from the info file is `DrupalBootstrap5`).
- The library defined in `DrupalBootstrap5.libraries.yml` is attached globally from the `.module` file.
- Ensure your theme markup uses Bootstrap 5 class names to benefit.

---

## Usage & behaviour

- Ships Bootstrap 5 assets under `css/` and `js/` and registers them as a Drupal library.
- The `.module` attaches the library to pages so the framework is available site-wide.
- There are no routes, permissions, services, or config forms — it is a pure asset loader.
- Useful when a custom or contrib theme wants Bootstrap without a full Bootstrap base theme.
- Because it loads globally, it may conflict with themes that already bundle Bootstrap; enable only one source.
- The bundled Bootstrap version is fixed at the version shipped with this release; audit it for known CSS/JS CVEs and update if stale.
- No external CDN is used; assets are served locally, which is good for privacy and CSP.
- Aggregation/minification is handled by Drupal's normal CSS/JS aggregation.
- Disabling the module removes the library from all pages.
- It does not theme any specific region or block; markup responsibility stays with your theme/templates.
- Safe on multilingual sites; assets are language-agnostic.
- No data is stored and no cron work is performed.
- Consider a maintained Bootstrap base theme (e.g. Bootstrap Barrio) for production instead of a raw asset loader.
- Verify JS load order if you also use jQuery-dependent Bootstrap components.
- Keep an eye on the project's update status, as bundled front-end libraries can lag upstream security releases.
- Good for quick prototypes and admin tools that just need Bootstrap utility classes.
