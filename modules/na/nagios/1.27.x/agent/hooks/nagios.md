<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extend Nagios with your own check

Documented in `nagios.api.php`. Two hooks; implement `hook_nagios()` to do a check, and
optionally `hook_nagios_info()` to give it an on/off toggle on the settings page.

## Status code constants

Defined at runtime from `nagios.settings` (`StatuspageController`):

```
NAGIOS_STATUS_OK       // 0
NAGIOS_STATUS_WARNING  // 1
NAGIOS_STATUS_CRITICAL // 2
NAGIOS_STATUS_UNKNOWN  // 3
```

## `hook_nagios($id)` — do the check

Return an associative array keyed by an IDENTIFIER (shown on Nagios pages). Each entry:

```php
function mymodule_nagios(string $id): array {
  $data = [
    'status' => NAGIOS_STATUS_OK,     // OK | WARNING | CRITICAL | UNKNOWN
    'type'   => 'state',              // 'state' (alertable) or 'perf' (perf data)
    'text'   => '',                   // short problem description when not OK
  ];
  return ['MYCHECK' => $data];
}
```

`$id` is the optional 2nd URL argument: `/nagios/mymodule/myId` calls
`mymodule_nagios('myId')` and runs **only** that module's check. All implementations are
gathered by `nagios_invoke_all('nagios')` for the plain `/nagios` page.

## `hook_nagios_info()` — add a settings toggle

```php
function mymodule_nagios_info() {
  return [
    'name' => 'My module name',   // label on the settings form
    'id'   => 'MYCHECK',          // identifier appearing in Nagios output
  ];
}
```

This adds a checkbox on `/admin/config/system/nagios` so admins can enable/disable inclusion
of your module's check.

## Notes

- `type => 'perf'` still causes an alert but can be post-processed by custom programs (perf
  data), versus `state` for OK/Warning/Critical/Unknown.
- Use the **same** IDENTIFIER in `hook_nagios()` and `hook_nagios_info()`.
- Built-in checks (cron, watchdog, maintenance, requirements) are toggled by
  `nagios.settings` → `nagios.function.*`, not by these hooks.
