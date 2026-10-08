<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain — agent index

One Drupal install, many hostnames. Each hostname is a **`domain` config entity**
(config `domain.record.<id>`); the `DomainNegotiator` picks the **active domain** per
request by matching the HTTP host. Core `domain` only creates + negotiates records —
access control, canonical URLs and per-domain config live in its submodules.

- Create/edit/delete domain records, global settings, Drush → [configure/domain.md](configure/domain.md)
- Services & entity API (negotiator, storage, `DomainInterface`, tokens) → [api/domain.md](api/domain.md)
- Blocks, condition, Views, entity-reference, language plugins it ships → [plugins/domain.md](plugins/domain.md)
- Hooks it invites (`domain.api.php`) → [hooks/domain.md](hooks/domain.md)

Submodules (documented separately): [domain_access](../../modules/domain_access/3.0.x/agent/start.md),
[domain_source](../../modules/domain_source/3.0.x/agent/start.md); also `domain_alias`,
`domain_config`, `domain_config_ui`, `domain_content`.

Key facts: entity type id `domain`, config prefix `domain.record.*`, config UI route
`domain.admin` at `/admin/config/domain`, permission `administer domains`. The **first**
domain created is auto-set as default.
