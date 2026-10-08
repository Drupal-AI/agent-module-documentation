<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Responsive Wrappers — agent index

One text-format filter that rewrites rendered HTML to add Bootstrap responsive wrappers/classes
to tables, images and video iframes. Depends only on core `filter`. No Drush, no custom
permissions, no new plugin types. Two config surfaces: the per-format filter settings and a
global settings object.

- **Enable & tune the filter on a text format** (plugin id, per-format settings, what markup each toggle emits, filter ordering) → [plugins/filter.md](plugins/filter.md)
- **Global settings & custom classes** (route `responsivewrappers.settings`, Bootstrap version, attach-CSS, custom class overrides, config keys) → [configure/settings.md](configure/settings.md)

Quick facts:
- Filter plugin id: `filter_bootstrap_responsive_wrapper` ("Responsive wrappers filter"), type TRANSFORM_IRREVERSIBLE.
- Enable per text format at `/admin/config/content/formats`; order it after other markup filters (e.g. Video Embed WYSIWYG).
- Global config form: `/admin/config/content/responsivewrappers` (route `responsivewrappers.settings`, permission `administer filters`).
- Global config object: `responsivewrappers.settings` (keys: `add_css`, `version`, `image_class`, `iframe_wrapper_class`, `iframe_class`, `table_wrapper_class`, `table_class`).
- Per-format filter settings: `responsive_iframe`, `responsive_iframe_pattern`, `responsive_table`, `responsive_image`.
- CSS libraries (attached only when `add_css` = 1): `responsivewrappers/responsivewrappers_v3`, `responsivewrappers/responsivewrappers_v4`.
