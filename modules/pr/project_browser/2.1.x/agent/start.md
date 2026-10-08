# project_browser — agent start

In-admin UI to browse, filter, and install contrib modules/recipes from Drupal.org (and
other pluggable sources) without Composer. Browse page: **Admin → Extend → Browse**
(`/admin/modules/browse/{source}`, route `project_browser.browse`, permission
`administer modules`). Settings: `project_browser.settings`
(`/admin/config/development/project_browser`, permission `administer site configuration`).
No module-defined permissions; core `^11.2 || ^12`; no required contrib deps. UI install
requires core **Package Manager**.

- Enable/order sources, default source, UI install, install flow, access → [configure/project_browser.md](configure/project_browser.md)
- Add a custom project source (`ProjectBrowserSource` plugin) + activators → [plugins/project_browser.md](plugins/project_browser.md)
