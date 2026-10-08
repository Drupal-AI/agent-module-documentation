<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dump helpers, HelperManager, Twig, Devel

## Dump helpers

- `d(...$args)` — rich interactive dump (helper `kint.helper.d`, RichRenderer).
- `s(...$args)` — plain dump (helper `kint.helper.s`, PlainRenderer).
- Both are **generated global functions** created by `HelperManager` (`eval`'d proxies into
  `HelperManager::executeHelper()`), and registered as Kint aliases. Any `kint.helper.<name>`
  config makes a same-named global function. Usable in PHP and (via `kint-twig`) in Twig:
  `{{ d(node) }}`.

## HelperManager (service `kint.helper.manager`)

- On construction, registers a global function for every `kint.helper.*` config.
- `registerHelper($name)` — defines the global function (throws if the name is invalid or already
  defined).
- `executeHelper($name, $args)` — runs `Kint::dump()` with that helper's renderer/mode/CLI
  settings; `mode === 'messenger'` adds the output as a Drupal message; `mode === 'exit'` dumps
  then `exit`s.

## Bootstrapping (`kint.module` / `init.php`)

Loaded via composer `autoload.files` (`init.php`). Blacklists heavy classes
(`ModuleHandlerInterface`, `Connection`, `ConfigFactory`, plugin managers, `EntityAdapter`,
field item lists) for readable output, adds `DrupalFieldableEntityPlugin` to Kint, sets path
aliases (`<drupal>`, `<vendor>`), and applies `kint.settings`. CSP nonces are set when the
`csp.nonce` service exists.

## Twig extension

Service `kint.twig_extension` = `Kint\Twig\TwigExtension` (via `TwigExtensionFactory::create`).
Twig dumps only render when Twig **development mode** is on
(`Configuration → Development settings`).

## Devel integration

Plugin `Plugin\Devel\Dumper\DevelDumper` (id `kint`) registers Kint as a Devel dumper; when
selected, Devel's permissions apply. `use_kint_trace_in_devel` swaps Kint's trace into
`ddebug_backtrace`.

## Event subscriber

`kint.event_subscriber` (`KintEventSubscriber`, args `@current_user`, `@?config.factory`,
`@?csp.policy_helper`) enforces the `access kint dumps` permission after authentication.
