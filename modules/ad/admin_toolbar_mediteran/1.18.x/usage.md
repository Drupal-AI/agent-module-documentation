<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Admin Toolbar Mediteran restyles the Admin Toolbar in the Mediteran visual style — it is a CSS layer over the existing toolbar, not a replacement for it.

---

The module is almost entirely stylesheets. `css/` holds separate directories for `toolbar`, `admin_toolbar`, `shortcut`, `user` and `coffee`, an `images/icons` directory supplies the iconography, `admin_toolbar_mediteran.libraries.yml` declares the assets and `admin_toolbar_mediteran.module` attaches them. There is no PHP class, no route, no permission, no configuration and no entity. Its one dependency is `admin_toolbar`, and the styling reaches beyond it: the `user`, `shortcut` and `coffee` directories mean the module also restyles related admin surfaces, including the Coffee module's quick-search dialog if that is installed. The `core_version_requirement` of `^8 || ^9 || ^10 || ^11` is very wide, which is plausible for a pure-CSS module — but wide CSS compatibility is not the same as visual compatibility: Drupal's admin markup has changed substantially across those versions, and on Drupal 11's Navigation-based admin UI the styling targets a toolbar that may not be the one in use.

---

- Restyle the admin toolbar in the Mediteran look.
- Give administrators a distinct visual identity.
- Match the toolbar to a bespoke admin theme.
- Restyle the shortcut bar consistently.
- Apply matching styling to the Coffee dialog.
- Differentiate environments by toolbar appearance.
- Improve the toolbar's icon set.
- Keep Admin Toolbar's behaviour with different styling.
- Adopt a maintained toolbar skin rather than local CSS.
- Style the user menu to match.
- Provide a familiar look for a migrating team.
- Reduce bespoke admin CSS in a theme.
- Apply one toolbar style across several sites.
- Restyle without touching Admin Toolbar itself.
- Give a client a branded admin experience.
- Support a long-lived site across core versions.
- Improve contrast in the admin toolbar.
- Distinguish admin UI from front-end theme.
