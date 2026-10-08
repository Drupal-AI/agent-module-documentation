<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Shortcode Example — agent index

A teaching module for the `shortcode` plugin type: ships exactly one plugin, `[col]`
("Bootstrap column", id `col`, class `BootstrapColumnShortcode`), as a minimal working
reference. No settings form, no configure route, no permissions, no theme hooks, no config
schema. The `col` shortcode still must be enabled per text format like any other shortcode
(see the parent module's `shortcode/2.0.x/agent/configure/enable-filter.md`) before `[col]`
markup is parsed instead of shown as literal text.

- **Walk the `col` plugin as a template for writing your own Shortcode plugin** →
  [plugins/col-example.md](plugins/col-example.md)

For the general "how do I write a Shortcode plugin" reference (annotation fields, base class,
required methods), see the parent module's
[../../../../2.0.x/agent/plugins/shortcode-plugin.md](../../../../2.0.x/agent/plugins/shortcode-plugin.md)
— this module is the worked example that doc points to.
