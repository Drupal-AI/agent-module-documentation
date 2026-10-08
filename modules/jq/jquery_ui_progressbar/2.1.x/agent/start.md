<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# jQuery UI Progressbar — agent index

Enabler shim that exposes the jQuery UI Progressbar widget (1.13.2) as the Drupal asset
library `jquery_ui_progressbar/progressbar`. No config page (`configure` null), no
permissions, no routes, no PHP/JS of its own — just an `info.yml` depending on `jquery_ui`.

- **Attach and use the library (asset id, dependencies, JS API, upgrade note)** →
  [theming/library.md](theming/library.md)

Key facts:
- Library id: `jquery_ui_progressbar/progressbar`. Assets live in the `jquery_ui` module and
  are registered by `jquery_ui`'s `hook_library_info_alter()` only while this module is enabled.
- Depends on `jquery_ui:jquery_ui` (info.yml) / `drupal/jquery_ui:^1.7` (composer).
- Auto-pulls `core/jquery`, `jquery_ui/widget`, `jquery_ui/internal.version`,
  `jquery_ui/internal.widget-css`.
- jQuery UI is upstream-unmaintained; prefer native `<progress>` for new code.
