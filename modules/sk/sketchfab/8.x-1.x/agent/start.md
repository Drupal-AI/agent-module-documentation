<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sketchfab - agent index

Field type/widget/formatter to embed Sketchfab 3D models. Version **8.x-1.2** (8.x-1.x), core `^8 || ^9 || ^10`.

- Field type `sketchfab_field` (`SketchfabItem`, text column `value`); widget `sketchfab_widget` (HTML5 `url`); formatter `sketchfab_format` renders `<iframe src="{{ url }}/embed" ...>` via inline_template.
- No routes, permissions, services or config.

Security: the iframe URL comes from the field value entered by users with field-edit permission and is rendered through Twig auto-escaping (attribute context), so no attribute breakout. The widget's validate() does not restrict the host to sketchfab.com, so an editor could embed an arbitrary URL in an iframe (clickjacking/embedding vector) - but this requires content-edit access, not anonymous input. No anonymous-facing surface. Low risk.
