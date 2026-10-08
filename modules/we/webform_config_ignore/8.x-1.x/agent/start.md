Webform Config Ignore: a Config Filter (via config_filter) that skips `webform.webform.*` and `webform.webform_options.*` config on import/export. No admin UI, no config object, no permissions, no Drush.
Behavior is automatic once enabled; the only control is a settings.php flag.

- configure/settings.md — how the filter works, matched config names, per-collection scope, and the `webform_config_ignore_disabled` settings.php kill-switch.
