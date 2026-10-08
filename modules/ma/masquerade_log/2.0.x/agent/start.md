<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Masquerade Log — agent index

Makes log entries created **while masquerading** also record the **original** user. Depends on
`masquerade`. **No configuration** — no settings form (`configure: null`), no permissions, no
config object, no plugins, no Drush. Enabling the module is the entire setup.

- **How it works: logger decoration, the message suffix, the context variables** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- A `ServiceModifierInterface` (`MasqueradeLogServiceProvider`) wraps every `logger`-tagged
  service in a `MasqueradeLogLogger` decorator. Verify live with
  `get_class(\Drupal::service('logger.dblog'))` → `Drupal\masquerade_log\MasqueradeLogLogger`.
- While masquerading, log messages gain the suffix `[masquerading <username>, uid <uid>]` and
  the context vars `@original_uid` / `@original_username`.
- When not masquerading, the decorator is a transparent pass-through.
