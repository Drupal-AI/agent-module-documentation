# Logger channels & integration API (emaillog + errorlog)

Both submodules register a Drupal **logger channel** — a service tagged `logger` implementing
`Psr\Log\LoggerInterface` with core `Drupal\Core\Logger\RfcLoggerTrait`. Core's `logger.factory` calls
every such service's `log($level, $message, array $context)` for each message passed to the logging system
(`\Drupal::logger('channel')->…()`, i.e. watchdog). No event subscriber is involved — the `logger` tag is
the entire wiring.

| Module | Service id | Class | Constructor args |
|---|---|---|---|
| emaillog | `logger.mylog` | `Drupal\emaillog\Logger\EmailLogger` | `@config.factory`, `@logger.log_message_parser` |
| errorlog | `logger.errorlog` | `Drupal\errorlog\Logger\ErrorLogMessageFormatter` | `@config.factory`, `@renderer` |

Each `log()` reads its own config object to decide, per severity, whether to act — emaillog needs a
non-empty `emaillog_<level>` address, errorlog needs `errorlog_<level>` = TRUE. See the configure docs for
the keys. Messages that do not match are simply ignored by that channel (they still go to any other logger,
e.g. dblog).

## emaillog delivery

emaillog sends through **core mail, not an external HTTP API**:
`\Drupal::service('plugin.manager.mail')->mail('emaillog', 'alert', $to, $langcode, $params, $from)`.
`hook_mail()` (`emaillog_mail()`, key `alert`) sets the subject and renders the `#theme => 'emaillog'`
element as the body. The from address is `system.site.mail_notification` (falling back to `mail`, then
`sendmail_from`). TLS/transport is whatever the site's configured mail system uses.

## errorlog delivery

`error_log($message, 0)` — PHP's default message type; destination is controlled by the server's
`error_log` ini directive.

## Theme hooks

| Hook | Template | Preprocess |
|---|---|---|
| `emaillog` | `emaillog.html.twig` | `template_preprocess_emaillog()` — adds severity description, datetime, user display name, filtered message; sets theme suggestions `emaillog__<severity>[__<channel>]`. |
| `errorlog_format` | `errorlog-format.html.twig` | `template_preprocess_errorlog_format()` — builds the pipe-delimited line. |

## Invoked hook: `hook_emaillog_debug_info_alter()`

Before sending, emaillog runs `\Drupal::moduleHandler()->alter('emaillog_debug_info', $debug_info)`, so any
module can rewrite the extra debug data attached to alert emails. emaillog implements its own
`emaillog_emaillog_debug_info_alter()` to replace `debug_backtrace()` argument values with a `type(size)`
summary when `emaillog_backtrace_replace_args` is enabled.

```php
/**
 * Implements hook_emaillog_debug_info_alter().
 */
function mymodule_emaillog_debug_info_alter(array &$debug_info) {
  // $debug_info is keyed by callback label, e.g. '$_SERVER', 'debug_backtrace()'.
  unset($debug_info['$_COOKIE']);
}
```
