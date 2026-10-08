<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
UI submodule for ElevateZoom Plus: the admin management pages (list, add, edit, duplicate, delete) for `elevatezoomplus` optionset config entities at `/admin/config/media/elevatezoomplus`.

---

This submodule adds only the entity management UI for the parent's `elevatezoomplus` config entity —
the parent module itself has no config form. It defines routes for the optionset collection/add/edit/
duplicate/delete forms (`elevatezoomplus_ui.routing.yml`), the list builder
(`ElevateZoomPlusListBuilder`), the add/edit form (`ElevateZoomPlusForm`) and delete form
(`ElevateZoomPlusDeleteForm`), plus local tasks/actions and a menu link. All routes require the
`administer elevatezoomplus` permission (`restrict access: true`). Its `configure` route is
`entity.elevatezoomplus.collection`. It stores no config of its own; it edits the parent's optionsets.
Enable with `drush en elevatezoomplus_ui`.

---

- Manage all ElevateZoom Plus optionsets from one admin list.
- Create a new zoom optionset through a form instead of hand-editing YAML.
- Edit an existing optionset's zoom type, window size, lens, and easing.
- Duplicate an optionset as a starting point for a variant.
- Delete an unused optionset.
- Enable/disable an optionset from the UI.
- Give a site builder access to zoom configuration without shell/config access.
- Provide the `/admin/config/media/elevatezoomplus` configuration entry point.
- Add a "responsive" optionset tuned for mobile through the form.
- Switch an optionset between window, lens, and inner zoom types visually.
- Adjust zoom window width/height/offset without editing YAML.
- Configure lens size, shape, border, colour, and opacity in the UI.
- Toggle scroll-zoom, easing, and fade options per optionset.
- Attach a lightbox to an optionset via its misc settings.
- Rename or relabel an existing optionset.
- Review all configured optionsets and their status at a glance.
- Prototype a new zoom configuration quickly by duplicating and tweaking.
- Hand zoom-config ownership to a content team via the `administer elevatezoomplus` permission.
