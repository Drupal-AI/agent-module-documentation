<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mautic Audiences: Audience field (mautic_audiences_field) — agent index

Submodule of **mautic_audiences**. Adds a `mautic_audience` field type recording which Mautic segments or tags an entity is for — an editorial hint by default, an opt-in **per-field view-access gate** when enabled. Version **1.1.x**, core `^10.3 || ^11`.

- **Depends on** `mautic_audiences` (the resolver + the cached segment/tag inventory) and core `field`. Search API is optional (only for the search processor).
- **Provides:** field type `mautic_audience` + widget `mautic_audience_checkboxes`, a per-row Views filter `mautic_audience_row_match`, a Search API processor `mautic_audience_access`, and access/help/views hooks in `AudienceFieldHooks`.
- **No routes or permissions of its own.** Viewing stored aliases requires the parent's `administer mautic audiences`.
- Parent project docs: `../../../../1.1.x/agent/start.md`.

## Solution docs
- [fields/field.md](fields/field.md) — the field type, its storage/field settings, the inventory-backed widget, and how to place it.
- [api/access-gate.md](api/access-gate.md) — the `hook_entity_access` gate, field-access restriction, the Views row filter, the Search API processor, and status-report requirements.
