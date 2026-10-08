<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Trash Manager — agent index

**Provides a trash manager (recycle bin) for restoring deleted entities** (records on `hook_entity_predelete`;
permanent-delete form). Depends on core `system`. Provides permissions. Version **1.0.1**. Core `^10.3||^11`.

Content-admin/data-protection — gate **restore** (re-creates an entity) and **permanent delete** (irreversible) to
trusted users; verify access so users only restore/purge what they could delete/create. Trash **retains deleted
content** (sensitive data — mind retention/GDPR, purge when required).
