<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tome Base — agent index

Shared-code sub-module for Tome. No config, no routes, no permissions, no plugins, no admin
UI. Dependency of both `tome_static` and `tome_sync`. Keep it enabled; there is nothing to
configure.

- **Shared services, traits, and the `CommandBase` all `tome:*` commands extend** →
  [api/services.md](api/services.md)

Key fact: it registers one Drush service, `cli.workaround` (`CliWorkaroundCommands`), whose
`pre-command php:cli` hook re-registers Tome's console commands so `drush php` keeps working.
