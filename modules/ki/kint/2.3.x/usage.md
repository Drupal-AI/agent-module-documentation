<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Kint integrates the Kint PHP dumper into Drupal, enabling the `d()` and `s()` dump helpers (in PHP and Twig) with Drupal-tuned settings, selectable themes, permission-gated output, and optional Devel-dumper integration.

---

The module wires the `kint-php/kint` and `kint-php/kint-twig` libraries into Drupal. On load it blacklists heavy Drupal internals (module handler, DB connection, config factory, entity adapters) for readable dumps, registers a Drupal fieldable-entity parser plugin, and applies configured settings. It ships two dump helper functions — `d()` (rich) and `s()` (plain) — defined as configurable "helpers"; each helper is a `kint.helper.<name>` config object choosing a renderer (Rich/Plain/Cli/Text), CLI detection, and a mode (normal dump / dump-and-die / dump-to-messenger). Output is gated: before authentication the `early_enable` setting decides visibility, and after authentication the `access kint dumps` permission (via a `KintEventSubscriber`) does. Twig dumps require Twig debug/development mode. A settings form at `/admin/config/development/kint` configures the rich-renderer theme (Default, Aante light/dark, Solarized, Solarized dark, or a custom CSS path), the footer date format, whether to override Devel's `ddebug_backtrace` trace, and lets you add/remove custom helper functions. When Devel is installed, Kint registers as a Devel dumper plugin (using Devel's permissions), and it also plays nicely with the CSP module (nonce support). Configuration is stored in `kint.settings` plus one `kint.helper.*` object per helper.

---

- Dump a variable in PHP with `d($var)` using Kint's interactive rich renderer.
- Emit a plain-text dump with `s($var)` where the rich UI is not wanted.
- Dump a variable inside a Twig template with `{{ d(variable) }}`.
- Inspect a Drupal entity without drowning in internal service objects (blacklisted).
- Gate debug output to trusted roles via the `access kint dumps` permission.
- Enable dumping before authentication for early-bootstrap debugging (`early_enable`).
- Choose a Kint theme (Solarized dark, Aante light, etc.) for readable dumps.
- Point Kint at a custom CSS theme file for the rich renderer.
- Set the timestamp/date format shown in the dump footer.
- Add a custom dump helper function (e.g. `dd`) with its own renderer and mode.
- Create a "dump and die" helper that stops execution after dumping.
- Create a "dump to messenger" helper that shows output as a Drupal message.
- Use Kint as the Devel dumper so `devel_dump()`/`dpm()` render with Kint.
- Override Devel's `ddebug_backtrace` with Kint's nicer trace.
- Debug a render array or form array interactively with search and access paths.
- Inspect a config object or plugin definition during development.
- Keep dumps CSP-compliant on hardened sites via nonce support.
- Provide developers a consistent, Drupal-aware var_dump replacement.
- Toggle CLI vs rich rendering per helper via CLI detection.
- Preview current Kint settings live on the settings page (a demo dump of its own config).
