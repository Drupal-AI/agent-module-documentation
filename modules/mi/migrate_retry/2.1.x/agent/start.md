<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate retry — agent index

**Retries migration rows that failed due to unexpected/transient errors** (network/timeout/API hiccups) —
migration resilience. Depends on `migrate`. Config at `migrate_retry.settings`; provides permissions.
Version **2.1.0**. Core `^10||^11`.

Developer/migration tool (Migrate framework, Drush-driven) — re-processes failed rows; no runtime access
role.
