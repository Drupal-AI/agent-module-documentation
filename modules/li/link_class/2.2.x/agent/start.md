<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# link_class — agent start

Adds one field widget, **Link with class** (plugin id `link_class_field_widget`), for core
`link` fields. It subclasses core `LinkWidget` and lets editors attach CSS class(es) to each
link value, stored in `options.attributes.class` where the core link formatter renders them.
Depends on core `link`. No config route, no permissions, no Drush commands — everything is
per-field widget settings on **Manage form display**.

- Enable the widget, pick a mode (manual / select / force), set class options → [configure/widget.md](configure/widget.md)
