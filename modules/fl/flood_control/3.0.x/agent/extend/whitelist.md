# IP allow-list decorator

Service `flood_control.flood_white_list` (`Drupal\flood_control\FloodWhiteList`) **decorates**
core's `flood` service (`decorates: flood`, `decoration_priority: 9`), registered via
`FloodControlServiceProvider`.

Behavior: `isAllowed()` returns TRUE immediately (bypassing flood) when the current request IP
matches an entry in `flood_control.settings:ip_white_list`; otherwise it delegates to the inner
flood service. `register()` and other methods pass straight through. The allow-list string is
parsed into IPs/ranges by the helper `flood_control_get_whitelist_ips()` in
`flood_control.module`.

Because it is a standard service decorator, any code calling the core `flood` service
automatically respects the allow-list — no API changes needed. To extend, decorate the same
`flood` service at a different priority, or replace the manager service
`flood_control.flood_unblock_manager` (interface `FloodUnblockManagerInterface`).
