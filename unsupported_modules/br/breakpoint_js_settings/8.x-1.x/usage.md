<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Breakpoint Javascript Settings exposes your theme's registered breakpoints (their min-width values and device mappings) to client-side JavaScript by writing them into `drupalSettings`. Front-end scripts can then branch on the same breakpoint definitions the theme uses, instead of duplicating media-query values in JS.

Use it when JavaScript needs to know the current responsive breakpoint (e.g. to load different behaviors on mobile vs desktop) and you want a single source of truth driven by the theme's `*.breakpoints.yml`.
---
Enable with `drush en breakpoint_js_settings`; it depends on core `breakpoint`. Configure at `/admin/config/system/breakpoint_js` (route `breakpoint_js_settings.admin_settings`, gated by `administer site configuration`), where you define the min-width and device mappings that get serialized to `drupalSettings`.

The settings form lives in `src/Form/SettingsForm.php`; the module attaches the values so they appear under `drupalSettings` on the page for your scripts to read.
---
- Read the active breakpoint from JavaScript via drupalSettings.
- Share theme breakpoint values with front-end scripts.
- Avoid hard-coding media-query widths in JS.
- Load device-specific behaviors on mobile vs desktop.
- Drive a responsive carousel's config from breakpoints.
- Toggle lazy-loading based on viewport size in JS.
- Keep JS and CSS breakpoints in sync from one source.
- Map named breakpoints to min-width pixels for scripts.
- Expose device categories (mobile/tablet/desktop) to JS.
- Configure the mappings through an admin form.
- Support responsive image or ad logic in JavaScript.
- Reduce duplicated breakpoint constants across a codebase.
- Let a decoupled widget respect theme breakpoints.
- Adjust behaviors on window resize using shared values.
- Prototype responsive JS quickly without new config.
- Standardize breakpoint access for multiple custom scripts.