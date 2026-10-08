<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CSS Variables Customizer lets an administrator override a theme's CSS custom properties (design tokens like `--color-primary` or `--card-radius`) from the admin interface, so colours, spacing and typography can change without editing stylesheets or running a deployment.

---

A theme opts in by adding a `css_variables_customizer:` section to its `.info.yml` that lists the source stylesheets (files or whole folders) holding its tokens, and by wrapping each overridable variable in `/* @css-variables-customizer-category <name> */` … `/* @css-variables-customizer-category-end */` comment annotations; the module parses those files (and any Single Directory Component that carries the same annotations) and builds a per-theme form at **Appearance → CSS Variables Customizer** (`/admin/appearance/css-variables-customizer`), reachable only by users with the core **`administer themes`** permission. There you set a **value** and a **CSS selector** (default `:root`) for each discovered variable, add extra one-off variables in a free-form **Custom** textarea (`--name: value;` per line), and **preview** unsaved changes before committing — with the optional **SDC Styleguide** module rendering live component previews in an iframe. Saved values are written to a configuration object (`css_variables_customizer.customizations.<theme>`), so they export with your config, deploy between environments, and are overwritten by a config import; on every request a `page_top` hook injects them as `<style>` blocks at the top of the page, scoped to the selector you chose. Only variables the theme actually annotated are adjustable, and if a variable is later removed from the code it simply stops appearing on the form. The module has no dependencies, provides no Drush commands or permissions of its own, and supports Drupal 10 and 11 (documented at **1.0.0-beta3**, a beta — test before production).

---

- Change a theme's primary colour without a deployment.
- Apply a client's brand palette to a base theme.
- Adjust spacing or border-radius site-wide from the admin UI.
- Change a heading or body font variable.
- Create a temporary campaign colour scheme.
- Differentiate a sub-site by accent colour only.
- Avoid maintaining a sub-theme per client or variation.
- Let a non-developer site owner tune design tokens.
- Override tokens on Single Directory Components (SDC).
- Scope an override to a specific CSS selector, not just `:root`.
- Add extra one-off custom properties via the Custom textarea.
- Preview a palette change before saving it.
- Preview SDC component overrides with the SDC Styleguide module.
- Support a white-label or multi-brand installation.
- Adjust contrast or colours for accessibility tweaks.
- Configure several themes independently on one site.
- Tune a theme's look after launch without a code change.
- Export theme-token overrides as configuration for deployment.
- Keep the override list in step with the theme (removed variables disappear).
- Group exposed variables under readable category headings in the UI.
