<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `hook_ip_anon_alter()` — register a table to scrub

IP Anonymize scrubs `sessions` out of the box. Any other table is added by implementing
`hook_ip_anon_alter(&$tables)`, which lets a module tell ip_anon which columns hold the
hostname and the timestamp for its data.

## Signature & structure

`$tables` is an associative array keyed by **database table name**; each value is:

```php
$tables['my_table'] = [
  'hostname'  => 'ip_column',        // column holding the client IP / hostname
  'timestamp' => 'created_column',   // column holding the record's unix timestamp
  'callback'  => function () { … },  // optional: run once if any rows were scrubbed (e.g. cache clear)
];
```

After you add a table, ip_anon also reads a `period_<table>` key from `ip_anon.settings`; add a
matching default (and schema) if you want it configurable via the settings form.

## Modern (attribute) implementation

The module itself uses the OOP hook style in `src/Hook/IpAnonAlter.php`, e.g.:

```php
use Drupal\Core\Hook\Attribute\Hook;

class IpAnonAlter {
  #[Hook('ip_anon_alter', 'dblog', 'dblog')]      // only when dblog is installed
  public function dblog(array &$tables): void {
    $tables['watchdog'] = $this->ipAnonymize->getDefaultColumns();  // hostname/timestamp
  }
}
```

A procedural `function mymodule_ip_anon_alter(array &$tables)` works too.

## Tables the module registers itself

| Module gate | Table | hostname col | timestamp col |
|---|---|---|---|
| (core) | `sessions` | `hostname` | `timestamp` |
| comment | `comment_field_data` | `hostname` | `changed` |
| dblog | `watchdog` | `hostname` | `timestamp` |
| commerce_order | `commerce_order` | `ip_address` | `changed` (+ cache reset) |
| login_history | `login_history` | `hostname` | `login` |
| simple_access_log | `simple_access_log` | `remote_host` | `timestamp` |
| tether_stats | `tether_stats_activity_log` | `ip_address` | `created` |
| visitors | `visitors` | `visitors_ip` | `visitors_date_time` |
| votingapi | `votingapi_vote` | `vote_source` | `timestamp` |
| webform | `webform_submission` | `remote_addr` | `changed` (+ cache reset) |

Use the same shape to add your own log/analytics table.
