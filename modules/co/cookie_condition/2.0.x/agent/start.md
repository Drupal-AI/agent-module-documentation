<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cookie Condition (cookie_condition) — agent index

One condition plugin — `src/Plugin/Condition/Cookie.php`, plugin id **`cookie`**, label "Cookie" —
matching on a cookie name, an operator (`is` / `contains`), and a value. Extends core
`ConditionPluginBase`. Version **2.0.1**. Core `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later.
**No dependencies, no routes, no permissions, no services, no config schema, no hooks, no install file.**

Usable anywhere Drupal collects condition plugins; block visibility is the common case.

- **The plugin: config keys, operators, evaluate/summary logic, cache context, how to place it** →
  [plugins/cookie.md](plugins/cookie.md)

## At a glance (from source)

- Config keys: `cookie_name` (''), `operator` (`is`|`contains`, default `is`), `cookie_value` ('')
  — from `defaultConfiguration()` — plus `negate` inherited from `ConditionPluginBase`.
- `evaluate()` reads `request_stack->getCurrentRequest()->cookies->get($cookie_name)`;
  `is` → strict `===` equality, `contains` → `strpos(...) !== false`.
- `getCacheContexts()` adds `cookies:<cookie_name>` when a name is set, so cookie-varying output
  caches per value.

## Two things to say every time

1. **Not an access control.** Cookies are client-supplied and trivially forged. This decides what
   is *displayed*, never what is *permitted*. Anything sensitive needs a permission or entity
   access check; use the cookie for presentation only.
2. **Configuration is per host.** No global settings page — you configure it inside each block's
   (or other consumer's) visibility settings.
