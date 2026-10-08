<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Widget Instance defines a widget-instance entity with CRUD and overview.

---

Widget Instance provides a widget instance entity — a configured instance of a widget type that can be placed/referenced on the site, so editors can create and manage concrete widget instances (from the widget system) as first-class entities.

It exposes CRUD permissions on widget-instance entities (`administer`/`create`/`view`/`edit`/`delete widget instance`) plus an overview permission — grant editing/admin to trusted roles. Depends on `widget_type` and core `serialization`; supports Drupal 9, 10, and 11.

---

- Provide a widget-instance entity.
- Manage configured widget instances.
- Place/reference widget instances.
- Model instances as entities.
- Work with widget types.
- Gate CRUD with widget-instance permissions.
- Gate the overview.
- Grant editing/admin to trusted roles.
- Depend on `widget_type` and core `serialization`.
- Support Drupal 9, 10, and 11.
- Configure instances.
- Support the widget system.
- Manage widgets
- Create instances
- Reference widgets.
- Handle widget entities.
- Support editors.
- Place widgets
