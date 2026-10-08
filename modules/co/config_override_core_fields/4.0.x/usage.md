<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Override Core Fields annotates Drupal's core configuration forms so each form element declares which config object and key it edits, via a `#config['key']` hint of the form `config.object:key`. It provides no user-facing feature on its own; it is a data provider consumed by modules like COI (Config Override Inspector).

---

The entire module is one `hook_form_alter()` in `config_override_core_fields.module`. For a
fixed list of core system settings forms — identified by form id — it sets
`$form[...]['#config']['key'] = '<config_name>:<key>'` on the relevant elements, mapping the
widget to the config it writes. Covered forms include `system_site_information_settings`
(→ `system.site:name`, `:slogan`, `:mail`, `page.front`, `page.403/404`),
`system_performance_settings` (→ `system.performance:cache.page.max_age`, `css.preprocess`,
`js.preprocess`), `system_cron_settings`, `system_file_system_settings`,
`system_logging_settings`, `system_site_maintenance_mode`, `system_themes_admin_form`,
`update_settings`, `user_admin_settings`, `search_admin_settings`,
`views_ui_admin_settings_basic/advanced`, plus a few contrib-aware keys guarded by `isset()`
(automated_cron interval, dblog row limit, node `use_admin_theme`, views display extenders).
Because it only adds render-array metadata and no visible behavior, nothing changes for a
site admin until a consumer module reads those `#config` hints — most notably
[COI](https://www.drupal.org/project/coi), which uses them to flag and disable fields whose
config value is overridden (e.g. in `settings.php`). It has no config, no schema, no
permissions, no services, and no plugins.

---

- Provide the `#config['key']` metadata that COI needs to detect overridden core settings.
- Map the Site name / slogan / email fields to `system.site` keys for override tooling.
- Map the performance form's cache max-age and CSS/JS aggregation to `system.performance` keys.
- Map the cron logging and automated-cron interval fields to their config keys.
- Map the file system paths and temporary-file age to `system.file` keys.
- Map the logging form's error level and dblog row limit to their config keys.
- Map the maintenance-mode message to `system.maintenance:message`.
- Map the admin theme selector to `system.theme:admin`.
- Map the update-manager frequency/notification fields to `update.settings` keys.
- Map the many account/email fields on the user settings form to `user.settings` / `user.mail` keys.
- Map the search indexing throttle and word-size fields to `search.settings` keys.
- Map the Views UI basic/advanced toggles to `views.settings` keys.
- Let an override-indicator UI show which core fields are pinned by `settings.php` overrides.
- Enable a consumer to disable overridden fields so admins don't edit a value that won't apply.
- Give developers a canonical form-element → config-key reference for core system forms.
- Support environment-specific config workflows by surfacing which fields are overridden per env.
- Act as a dependency other modules require to gain core-form config awareness.
- Provide the hint layer for a work-in-progress core `#config_data_store` convention.
- Reduce confusion where an admin changes a setting that a config override silently ignores.
- Serve as a lightweight, no-config building block installed on request by another module.
- Extend coverage by adding more `case` branches for additional core forms in a patch/fork.
- Pair with COI to display the active override value alongside the field.
- Help config-management tooling reason about which UI edits map to which config objects.
- Underpin audits of which core settings are controlled by code vs the database.
