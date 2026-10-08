# features_ui — agent start

The optional admin UI for Features. Adds the screens at **Admin → Configuration → Development →
Features** (`/admin/config/development/features`) to browse packages, export/download feature
modules, edit package contents, diff active-vs-stored config, and configure `features_bundle`
entities. Depends on `features:features`. Defines **no** permissions, config schema, plugin
types, or Drush commands of its own — it is a front end for the base module (see
[../../../../3.16.x/agent/start.md](../../../../3.16.x/agent/start.md), especially the drush and
configure docs). Configure route: `features.assignment`.

- Screens, routes, and permissions of the Features admin UI → [configure/features_ui.md](configure/features_ui.md)
