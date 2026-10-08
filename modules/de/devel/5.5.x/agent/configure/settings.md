# Configure Devel

Main settings form `devel.admin_settings` at `/admin/config/development/devel`
(permission: `administer site configuration`). Config object: `devel.settings`.

Keys (`config/install/devel.settings.yml`):
- `devel_dumper` — active dumper backend id (`default`/`var_dumper`, or `kint` when installed). See [../plugins/dumper.md](../plugins/dumper.md).
- `page_alter` — dump `hook_page_alter` data on every page.
- `raw_names` — show machine names instead of labels in dumps.
- `error_handlers` — which PHP error handler(s) Devel installs (backtrace/standard).
- `rebuild_theme` — rebuild the theme registry on every request.
- `debug_mail_file_format` / `debug_mail_directory` — filename pattern + dir for the
  DevelMailLog backend that writes emails to disk instead of sending.
- `debug_logfile` — file used by `dd()` output (default `temporary://drupal_debug.txt`).
- `debug_pre` — wrap dump output in `<pre>`.

Toolbar settings: separate form `devel.toolbar.settings_form` at
`/admin/config/development/devel/toolbar` (config `devel.toolbar.settings`), only when the
`toolbar` or `navigation` module is enabled — chooses which Devel menu links appear.

Other admin routes: `/devel/reinstall` (reinstall modules), `/devel/menu/reset` (rebuild
router), `/devel/config` (config editor list + edit/delete), plus introspection pages for
routes, services, events, entity types, elements, layouts and the container.
