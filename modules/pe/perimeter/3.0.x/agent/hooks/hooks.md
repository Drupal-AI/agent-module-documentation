<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks

Perimeter ships **no `perimeter.api.php`** and defines **no hooks of its own** for
other modules to implement. It *implements* two hooks:

## `perimeter_help()`
Standard `hook_help()` for the `help.page.perimeter` route — a description of what
the module does.

## `perimeter_honeypot_reject($form_id, $uid, $type)`
Integration with the contrib **Honeypot** module. When Honeypot rejects a
submission, Perimeter bans the submitter's IP (unless it is user 1, or the reject
`$type` is `honeypot_time` on the `user_login_form`). It honours the same
`flood_threshold` / `flood_window` settings (flood key `perimeter.honeypot`) and
uses `ban.ip_manager->banIp()`, logging to the `Perimeter` channel. This only does
anything when the Honeypot module is installed; Perimeter does not depend on it.

## To extend Perimeter's behaviour
There is no plugin type or alter hook. To change what counts as "suspicious",
edit the `not_found_exception_patterns` in `perimeter.settings`
(see [../configure/settings.md](../configure/settings.md)). To ban on other
conditions, write your own `KernelEvents::EXCEPTION` / response subscriber and call
`ban.ip_manager` yourself (see [../api/ban-logic.md](../api/ban-logic.md)).
