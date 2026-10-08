# Responsive Favicons — agent index

Adds a full cross-device favicon set (from realfavicongenerator.net) to the HTML head and
serves the well-known icon paths through Drupal. Config route: `responsive_favicons.admin`
at `/admin/config/user-interface/responsive_favicons`. Depends on core `file`. No Drush
commands, no plugin types, no custom entities — just one settings form and a service.

- [Configure the favicons (settings form, config keys, drush)](configure/settings.md)
- [Permissions](permissions/permissions.md)
- [Alter hooks (`*.api.php`)](hooks/hooks.md)
