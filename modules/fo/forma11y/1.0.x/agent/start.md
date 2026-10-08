<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Forma11y (forma11y) — agent index

**Adds `novalidate` to every form (via `hook_form_alter`) and a helper JS library so Drupal's accessible inline form errors handle validation instead of native HTML5 bubbles.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11 || ^12
- **Dependency:** core `inline_form_errors` (renders ARIA-linked inline errors).
- **Library:** `forma11y/forma11y` (js/forma11y.js, core/drupal).
- **Config:** none — zero-configuration, no routes or permissions.

**Security:** a single `hook_form_alter` adding an attribute plus a JS asset; no routes, permissions, input handling, or data storage — no findings.