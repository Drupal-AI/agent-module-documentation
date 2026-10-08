# Configure autologout

![Automated logout settings form](../../../../../../../screenshots/autologout/2.0.x/settings.png)

One settings form at `/admin/config/people/autologout` (route `autologout.set_admin`,
permission `administer autologout`). Stored in the `autologout.settings` config object;
per-role overrides in `autologout.role.<role_id>`.

## Key `autologout.settings` keys
- `enabled` (bool) — master switch.
- `timeout` (int, seconds) — global inactivity timeout; `max_timeout` caps user-set values.
- `padding` (int) — extra seconds after the warning dialog to respond before logout.
- `role_logout` (bool) + `role_logout_max` (bool) — enable per-role timeouts; use highest
  (vs lowest) matching role value.
- `no_individual_logout_threshold` (bool) — disable per-user thresholds.
- `logout_regardless_of_activity` (bool) — force logout on a fixed schedule.
- `redirect_url` (string) + `include_destination` (bool) — where to send the user; append
  current path as `?destination=`.
- `enforce_admin` (bool) — also apply on admin pages.
- `message` / `inactivity_message` / `inactivity_message_type` — warning + post-logout text.
- `no_dialog` (bool), `dialog_title`, `modal_width`, `disable_buttons`, `yes_button`,
  `no_button` — the warning modal.
- `whitelisted_ip_addresses` (string) — IPs exempt from autologout.
- `use_alt_logout_method` (bool) — non-AJAX logout fallback.
- `use_watchdog` (bool) — log autologout events.
- `cookie_secure`, `cookie_httponly` (bool) — flags for the timer cookie.
- `jstimer_format`, `jstimer_js_load_option` — JS countdown display.

## Per-role config (`autologout.role.<role_id>`)
```yaml
enabled: true
timeout: 900        # seconds for this role
url: '/user/login'  # optional per-role redirect
```

## Deploy as config
Export `autologout.settings.yml` and any `autologout.role.*.yml` via `drush config:export`;
import with `drush config:import`.
