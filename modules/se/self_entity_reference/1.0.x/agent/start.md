<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Self Entity Reference — agent index

Adds a **computed base field** that entity-references each entity to itself (`hook_entity_base_field_info` → `EntityTypeInfo` → `SelfEntityReferenceFieldItemList`). Lets the entity be used where an entity-reference is expected (Views, tokens, formatters). PHP 8.0+, core 9.4/10/11, v**1.0.0**.

No routes, no permissions, no config UI — field provided automatically.