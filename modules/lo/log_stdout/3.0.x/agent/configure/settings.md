# Configure Log Stdout

Config object: **`log_stdout.settings`**. UI route: **`log_stdout.settings`** →
`/admin/config/development/log_stdout` (permission `administer site configuration`, menu under
*Configuration → Development*).

## Keys

| Key | Type | Default (config/install) | Meaning |
|---|---|---|---|
| `format` | string | `[@severity] [@type] [@date] @message \| uid: @uid \| request-uri: @request_uri \| refer: @referer \| ip:  @ip \| link: @link` | Line template; placeholders below. |
| `use_stderr` | string `'0'`/`'1'` | `'1'` | When `'1'`, events at level `<= WARNING` go to `php://stderr`; otherwise all go to `php://stdout`. |
| `severity_level` | integer 0–7 | `3` | Minimum severity to emit. An event is written only when its RFC level is `<= severity_level`. 0=Emergency, 3=Error, 4=Warning, 6=Info, 7=Debug. |

Note `use_stderr` is stored as a **string** (`'0'`/`'1'`) because the form is a radios element;
`severity_level` is an integer from a select of `RfcLogLevel::getLevels()`.

## Format placeholders

`@base_url`, `@timestamp`, `@severity` (uppercased level name), `@type` (channel),
`@ip`, `@request_uri`, `@referer`, `@uid`, `@link`, `@message`, `@date` (`Y-m-d\TH:i:s` of the
event timestamp). Unknown placeholders are left as-is. If `format` is empty the logger falls back
to the default template above.

## Read / write with drush

```bash
drush cget log_stdout.settings
drush cget log_stdout.settings severity_level

# Log everything down to debug (7) and keep warnings on stderr:
drush cset -y log_stdout.settings severity_level 7
drush cset -y log_stdout.settings use_stderr 1

# Simpler, message-only format:
drush cset -y log_stdout.settings format '[@severity] @type: @message'
```

The `Stdout::log()` method re-reads `log_stdout.settings` on every event, so changes take effect
without a cache rebuild.

## Schema caveat

`config/schema/log_stdout.schema.yml` defines the object under the key **`syslog.settings`**, not
`log_stdout.settings`. That means `log_stdout.settings` is effectively **schema-less**: config
validation/typecasting won't apply, and `drush cset` stores whatever scalar you pass. Set
`severity_level` as an int and `use_stderr` as `'0'`/`'1'` to match what the code expects.
