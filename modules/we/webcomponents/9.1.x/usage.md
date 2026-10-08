<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Web components integrates the LRN/HAX web-components build with Drupal so custom elements (`<x-foo>`) and their polyfills load site-wide.

---

Via `hook_page_attachments_alter()` it injects preconnect/preload/modulepreload link tags for the build assets (build.js, wc-registry.json, the wc-autoload and dynamic-import-registry ES6 modules) from a configurable project location, and `hook_page_bottom()` appends a small inline `<script>` that sets `window.__appCDN` and loads `build.js`. The asset location is set on the admin form at `/admin/config/content/webcomponents` (permission `administer site configuration`); it can point at a local library path or a CDN, and can optionally serve the build file locally while pulling assets from a CDN.

Operationally the only privileged surface is the admin settings form.
---
- Load HAX/LRN web components across the site
- Configure the web-components asset location at /admin/config/content/webcomponents
- Point the build at a CDN
- Serve the build file locally but assets via CDN
- Preconnect to font/CDN origins for performance
- Preload build.js and wc-registry.json
- Modulepreload the wc-autoload and dynamic-import-registry modules
- Enable custom elements without theme changes
- Defer to the HAX module's location if it set one
- Set window.__appCDN for the web-components runtime
- Provide autoloading of registered components
- Use ES6 module preloading for faster boot
- Integrate authoring components (HAX) with Drupal
- Restrict configuration to site administrators
- Host the web-components library locally
- Switch the asset location between environments
- Reduce render-blocking with preconnect hints
- Load autoloaded components on demand via the registry
