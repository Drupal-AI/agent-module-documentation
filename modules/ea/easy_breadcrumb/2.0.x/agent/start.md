# easy_breadcrumb — agent start

Replaces the core system breadcrumb with a path-based trail that appends the current page
title. No dependencies beyond core. Works out of the box; everything is tuned from one
settings form. Config UI: **Admin → Config → User interface → Easy Breadcrumb**
(`/admin/config/user-interface/easy-breadcrumb`, route `easy_breadcrumb.general_settings_form`).

Implementation: a high-priority (`priority: 1003`) `breadcrumb_builder` service
(`Drupal\easy_breadcrumb\EasyBreadcrumbBuilder`); optional JSON-LD via
`easy_breadcrumb.structured_data_json_ld`. No plugin types, hooks API, or Drush commands.

- All settings keys (`easy_breadcrumb.settings`) + JSON-LD → [configure/settings.md](configure/settings.md)
- Permission that gates the settings form → [permissions/permissions.md](permissions/permissions.md)
