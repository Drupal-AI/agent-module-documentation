<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# IP Limiter (ip_limiter) — agent index

Application-level, per-IP rate limiter that temporarily **bans abusive IPs**. A high-priority kernel
`REQUEST` subscriber (`IpLimiterSubscriber`, priority **512**, before auth/access checks) runs on
every request: it takes the client IP from `Request::getClientIp()`, loads the admin-configured
**rule plugins** from `ip_limiter.settings:rules`, and for each rule that `applies()` (or is set to
restrict globally) it (1) denies immediately if the IP already has an unexpired ban, else (2) logs the
visit to `ip_limiter_log` and, if the rolling-window request count reaches the rule's `max_requests`,
writes/updates a ban row in `ip_limiter_ban`. Denial returns a bare `403`/`404`/`429` Response per the
rule's `response_type`. Repeat bans **double the multiplier** (and effective duration); `hook_cron`
halves multipliers on expired bans and prunes fully-expired `multiplier=1` rows.

Rules are instances of the **`IpLimiterRule` plugin type** (annotation-based, manager
`ip_limiter.rule_manager`). Three built-ins ship: `path` (match request path), `route` (match Symfony
route name), `user_agent` (match User-Agent via bot/scanner presets or custom regex, blacklist or
whitelist). Path/Route rules also support *matcher conditions* (user-agent bot filter, query-string
regex, require-Referer). All configuration is a single admin form; there are no fields, no widgets, no
REST, no Views, no drush.

- **Depends on:** nothing (info.yml has no `dependencies`); core only.
- **Core:** `^10.3 || ^11` (composer `drupal/core: ^10.5.6 || ^11`).
- **Package:** Custom.
- **Settings page / configure route:** yes — `ip_limiter.settings` at `/admin/config/system/ip-limiter`.
- **Permissions:** one — `administer ip limiter configuration` (`restrict access: true`); gates all 3 routes.
- **Plugin types:** one — `IpLimiterRule` (dir `Plugin/IpLimiterRule`, alter hook `ip_limiter_rule_info`).
- **Services:** `ip_limiter.rule_manager`, `ip_limiter.event_subscriber`.
- **Hooks:** `hook_cron`, `hook_schema`, `hook_update_10000/10001`.
- **Drush / Views / fields / REST:** none.

## What you'd do → where
- Configure rules / understand config keys / legacy migration → [configure/rules.md](configure/rules.md)
- Write a custom rule plugin, or understand the 3 built-ins → [plugins/rules.md](plugins/rules.md)
- Understand enforcement, IP handling, ban lifecycle, cron, tables, admin bans list → [events/subscriber.md](events/subscriber.md)

## Key facts (real machine names)
- **Routes:** `ip_limiter.settings` (`/admin/config/system/ip-limiter`, `_form` `IpLimiterSettingsForm`);
  `ip_limiter.bans` (`/admin/config/system/ip-limiter/banned-ips`, `_controller`
  `IpLimiterController::bannedIps`); `ip_limiter.unban`
  (`/admin/config/system/ip-limiter/unban/{ip_address}`, `_form` `IpLimiterUnbanConfirmForm`). All
  require `_permission: 'administer ip limiter configuration'`.
- **Permission:** `administer ip limiter configuration`.
- **Services:** `ip_limiter.rule_manager` (`Drupal\ip_limiter\IpLimiterRuleManager`, DefaultPluginManager);
  `ip_limiter.event_subscriber` (`Drupal\ip_limiter\EventSubscriber\IpLimiterSubscriber`, tag
  `event_subscriber`).
- **Event:** `KernelEvents::REQUEST => ['onRequest', 512]`.
- **Plugin type:** annotation `@IpLimiterRule` (`id`, `label`, `description`); interface
  `Drupal\ip_limiter\IpLimiterRule\IpLimiterRuleInterface`; namespace dir `Plugin/IpLimiterRule`;
  cache id `ip_limiter_rule_plugins`; alter hook `ip_limiter_rule_info`.
- **Built-in plugin ids:** `path` (`PathRule`), `route` (`RouteRule`), `user_agent` (`UserAgentRule`).
- **Config object:** `ip_limiter.settings`; only key is `rules` (sequence of rule mappings). Install
  default: `rules: []`. Schema file: `config/schema/ip_limitter.schema.yml` (note the double-`t`
  filename typo; the schema key inside is correct).
- **DB tables:** `ip_limiter_log` (id, ip_address, timestamp); `ip_limiter_ban` (id, ip_address,
  created, updated, multiplier, ban_end, user_agent, referer).
- **Response constants:** `IpLimiterSubscriber::RESPONSE_TYPE_403|404|429`.
- **Menu/action links:** `ip_limiter.links.menu.yml`, `ip_limiter.links.action.yml`.
- **Helper classes:** `Matcher\RuleMatcherTrait`, `Matcher\UserAgentPresets`.
