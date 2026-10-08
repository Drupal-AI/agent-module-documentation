# Configure web server logging (errorlog)

Settings form `Drupal\errorlog\Form\ErrorlogConfigForm` (form id `errorlog_admin_settings`) at
**`/admin/config/development/errorlog`** (route `errorlog.configuration`, permission
`administer site configuration`). Edits the `errorlog.settings` config object (schema
`config/schema/errorlog.schema.yml`). No module dependencies.

## Severity toggles

One checkbox per core severity; check a level to have those log entries written to the web server error
log. Where the line actually lands is decided by PHP's `error_log` ini setting (e.g. syslog,
`/var/log/apache2/error.log`, or the Windows event log) — the module does not choose the destination.

| Config key | Severity | Default |
|---|---|---|
| `errorlog_0` | Emergency | false |
| `errorlog_1` | Alert | false |
| `errorlog_2` | Critical | false |
| `errorlog_3` | Error | false |
| `errorlog_4` | Warning | false |
| `errorlog_5` | Notice | false |
| `errorlog_6` | Info | false |
| `errorlog_7` | Debug | false |

All default to `false` (install config `config/install/errorlog.settings.yml`) — nothing is written until
you enable a level.

## Set it with Drush / PHP

```php
$config = \Drupal::configFactory()->getEditable('errorlog.settings');
$config->set('errorlog_0', TRUE);   // Emergency
$config->set('errorlog_2', TRUE);   // Critical
$config->save();
```
```bash
ddev drush cset errorlog.settings errorlog_3 true -y
```

## What happens at runtime

`ErrorLogMessageFormatter::log()` (service `logger.errorlog`) runs per log message: if `errorlog_<level>`
is TRUE it renders the `errorlog_format` theme (`errorlog-format.html.twig`) into a single pipe-delimited
line and passes it to PHP `error_log($message, 0)`. `template_preprocess_errorlog_format()` builds the
line:

```
<site name>|<base_root>|severity=<level>|type=<channel>|ip=<ip>|uri=<request_uri>|referer=<referer>|uid=<uid>|link=<link>|message=<message>
```

`hook_uninstall` (`errorlog_uninstall()`) deletes the `errorlog.settings` object when the module is
uninstalled.
