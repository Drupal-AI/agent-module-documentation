<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cookie Block (cookie_block) — agent index

Provides one core **Condition plugin** (id **`cookie`**) that shows/hides a block based on whether a
named browser cookie equals a configured value. Package `Other`. Core requirement
`^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 2.0.3.

- **The condition plugin, its settings, and how to use it on a block** →
  [plugins/cookie_condition.md](plugins/cookie_condition.md)

## What it actually is

- One class: `CookieCondition` (`@Condition` id **`cookie`**, label *"Cookie"*) in
  `src/Plugin/Condition/CookieCondition.php`, extending core's `ConditionPluginBase` and
  implementing `ContainerFactoryPluginInterface`.
- **No** routes, controllers, forms of its own, permissions, services, hooks, install file,
  config schema, config/install, submodules, Drush commands, libraries, or JS/CSS. The
  `.info.yml` declares no dependencies. It is purely a plugin the block system discovers.

## Mechanism (from source)

- `create()` injects the current request via `request_stack->getCurrentRequest()` (stored as
  `$this->request`).
- `buildConfigurationForm()` adds two textfields — `cookie_id` (cookie name) and `cookie_value` —
  on top of core's condition form (which supplies the *Negate* checkbox).
- `evaluate()` reads `$this->request->cookies->get(cookie_id)` and returns TRUE only when that
  cookie is non-empty and `== cookie_value` (loose comparison); otherwise FALSE. Core applies the
  *Negate* flag around this result.
- `summary()` builds a human label using placeholder-substituted (`@cookie_id`, `@cookie_value`)
  translation — values are escaped by the translation system, not rendered raw.
- `defaultConfiguration()` seeds `cookie_id` and `cookie_value` to `''`.

## Note

- Cookies are **client-controlled** (a visitor can set/clear/forge them), so this is a
  **visibility/UX** condition, not an access gate — never the sole control on sensitive content.
