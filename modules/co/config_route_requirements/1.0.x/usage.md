<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Route Requirements lets module authors gate a route's existence on a configuration
value using a `_config` route requirement.

---

A `RouteSubscriberBase` (`ConfigRouteSubscriber`) inspects every route in the collection; for
any route declaring a `_config` requirement it evaluates the referenced config value(s) and
*removes* the route from the routing table when they evaluate to false. This is a build-time
route alter (runs on route rebuild), not a per-request access check — a disabled route simply
does not exist, returning 404. The syntax is modelled on core's module route subscriber.

The requirement value is a dot-delimited config path — `config_object_name.key`, e.g.
`my_module.settings.feature_enabled` (nested keys like `my_module.settings.group.subkey`
also work). Combine several with `,` for OR and `+` for AND; `+` binds looser, so
`a,b+c` means `(a OR b) AND c`. A missing config value counts as false, so the route is
removed.

There is no UI, permission, or service to configure; the module is a developer primitive. Add
a `requirements: { _config: 'my_module.settings.feature_enabled' }` line to a `*.routing.yml`
route and rebuild routes (`drush cr`). Use it to ship optional endpoints that admins can turn
on/off through configuration without custom access code.

---

- Toggle a route's existence from a configuration value.
- Ship an optional endpoint disabled until an admin enables it.
- Gate a route on `my_module.settings.enabled` in routing.yml.
- Return 404 for routes whose backing config is false.
- Feature-flag routes without writing an access checker.
- Combine several config keys with `,` (OR) and `+` (AND) as a route requirement.
- Rebuild routes (`drush cr`) after changing the config value.
- Keep demo/debug routes off in production via config.
- Provide config-driven route availability in a distribution.
- Avoid custom `_custom_access` callbacks for simple on/off cases.
- Disable an API route in production but keep it in dev.
- Expose an endpoint only when an integration is configured.
- Turn maintenance/debug routes off via a config flag.
- Let site builders toggle a feature route without code.
- Document the `_config: 'config_name.key'` requirement syntax for a team.
- Pair `_config` with normal `_permission` on the same route.
