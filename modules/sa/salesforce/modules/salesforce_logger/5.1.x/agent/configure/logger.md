# Logger settings — `salesforce_logger.settings`

Settings form at route `salesforce_logger.settings`.

| Key | Values | Default | Meaning |
|---|---|---|---|
| `log_level` | `salesforce.error` \| `salesforce.warning` \| `salesforce.notice` | `salesforce.error` | Minimum severity logged: errors only / warnings + errors / all Salesforce events. |
| `log_push_success` | boolean | `false` | Also log successful pushes (not just failures). |
| `log_push_params` | boolean | `false` | Log the field params sent to Salesforce on push. |
| `log_push_params_maxlength` | integer \| null | `null` | Truncate logged push params to this length. |
| `log_push_params_sanitized_fields` | list of strings | `[]` | Field names to redact from logged push params. |

The `log_level` values are the `SalesforceEvents` constants: `ERROR = 'salesforce.error'`,
`WARNING = 'salesforce.warning'`, `NOTICE = 'salesforce.notice'`.

```bash
drush cget salesforce_logger.settings
drush cset salesforce_logger.settings log_level salesforce.notice -y   # log everything
drush cset salesforce_logger.settings log_push_success 1 -y
```
Or in PHP:
```php
\Drupal::configFactory()->getEditable('salesforce_logger.settings')
  ->set('log_level', 'salesforce.warning')
  ->save();
```

Raise `log_level` to `salesforce.error` to quiet logs in production; drop it to
`salesforce.notice` while debugging. Enable `log_push_params` only temporarily and add
sensitive field names to `log_push_params_sanitized_fields`.
