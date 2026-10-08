<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tome Sync Autoclean — agent index

Experimental. Auto-runs Tome's unused-file cleanup (like `drush tome:clean-files`) on every
Tome Sync export. Depends on `tome_sync`. No config, no permissions, no routes, no Drush
command — enabling the module IS the setup. **Can cause data loss; use with caution.**

- **The event subscriber, what it deletes, and the data-loss caveat** →
  [api/behavior.md](api/behavior.md)

Key fact: it subscribes to `tome_sync.export_content` (`ExportEventSubscriber`) and deletes
exported files not referenced by content/config. To disable, uninstall the sub-module.
