<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Widget Type defines widget type entities — reusable templates that widget instances are created from.

---

Widget Type provides a widget type entity — a configurable definition (template) of a widget from which concrete widget instances are created. It's the base of the widget system (used by widget_instance and widget_ingestion), defining a widget's fields/structure and a registry of widget sources.

It exposes permissions for administering widget types (`administer widget_type entities`), an overview (`access widget type overview`), and registry sources (`administer widget registry sources`) — restrict administer permissions to trusted roles. Depends on core `text`, `image`, `user`, and `file`; supports Drupal 9, 10, and 11.

---

- Provide a widget type entity.
- Define reusable widget templates.
- Underpin the widget system.
- Create instances from types.
- Define a widget's fields/structure.
- Manage a registry of widget sources.
- Gate admin with `administer widget_type entities`.
- Gate the overview.
- Gate `administer widget registry sources`.
- Restrict admin to trusted roles.
- Depend on core `text`/`image`/`user`/`file`.
- Support Drupal 9, 10, and 11.
- Underpin widget_instance and widget_ingestion.
- Configure widget types.
- Manage widget definitions
- Support the widget registry
- Provide templates.
- Handle widget config.
