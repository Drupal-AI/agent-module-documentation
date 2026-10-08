<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Import Map manages the browser import map for ES modules.

---

Import Map manages the browser **import map** for ES modules — the `<script type="importmap">` that maps
bare JavaScript module specifiers (e.g. `import x from 'lodash'`) to real URLs — so front-end/library code can
use bare-specifier ES module imports on a Drupal site. It is a front-end/developer feature.

Use it to configure ES-module import maps for the front end. It is a theming/JS integration utility that emits
the import-map JSON; the mapped URLs are admin/developer-configured (point them at trusted, same-origin or
trusted-CDN scripts, since anything mapped can be imported and executed). It has no content or access role.
Configure the import map entries.

---

- Manage the browser import map.
- Map bare ES-module specifiers to URLs.
- Enable bare-specifier imports.
- Emit a <script type=importmap>.
- Serve front-end/library code.
- Configure module URLs.
- Point maps at trusted scripts.
- Have no content/access role.
- Configure the import-map entries.
- Handle import maps.
- Map modules.
- Configure ES modules.
- Emit the import map.
- Handle the map.
- Configure JS imports.
- Map specifiers.
- Handle the integration.
- Configure modules.
- Provide import maps.
- Manage module resolution.
