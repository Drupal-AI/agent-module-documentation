<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group Context: Domain (group_context_domain) — agent index

Bridges **Group** and **Domain**: ties one `group` entity to one `domain` record (stored as a
third-party setting on the domain), then exposes that group as a Drupal core **context** and a
**cache context** so blocks, the Group Sites module, and any context-aware plugin can consume the
active tenant's group without a group ID in the route. Package `Group`. Core
`^9.5 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.0.

Hard dependencies (both required, module won't enable without them): **`group`** (`^2 || ^3`) and
**`domain`** (`^2`). No settings form, no routes of its own, no Drush, no external calls.

- **The context provider, the cache context, and the reusable trait** →
  [api/context-provider.md](api/context-provider.md)
- **Assigning a group to a domain: permission, form alter, third-party setting, uniqueness
  validator, config schema** → [config/domain-group.md](config/domain-group.md)

## What it actually provides (from source)

- **Context provider** `group_context_domain.group_from_domain_context` →
  `Context\GroupFromDomainContext` (tag `context_provider`, args `@domain.negotiator`,
  `@entity.repository`, `@string_translation`). Returns an **optional** `group` entity context
  labelled *"Group from domain"*, cached on `['url.site.group']`.
- **Cache context** `cache_context.url.site.group` → `Cache\Context\DomainGroupCacheContext`
  (tag `cache.context`, ID `url.site.group`). Returns the detected group's ID, or the literal
  `group.none` when no group is found; adds the active domain as a cacheable dependency.
- **Trait** `GroupFromDomainContextTrait::getGroupFromDomain()` — the shared lookup used by both
  services: active domain → its `group_context_domain.group_uuid` third-party setting →
  `entity.repository->loadEntityByUuid('group', $uuid)`, or `NULL`.
- **Permission** `set domain group` (in `group_context_domain.permissions.yml`).
- **Validation constraint** `DomainGroupUnique` (+ `DomainGroupUniqueValidator`), added to the
  `domain` entity type via `hook_entity_type_alter`, enforcing one-group-per-domain /
  one-domain-per-group.
- **Config schema** `domain.record.*.third_party.group_context_domain` with a single `group_uuid`
  (type `uuid`). No `config/install`, no default config object of its own.

## Mechanism (short)

1. `hook_form_domain_form_alter` (in the `.module`) adds a **Group** select to the domain edit
   form only if the current user has `set domain group`; options are groups the user has **update**
   access to (`getQuery()->addMetaData('op','update')->accessCheck()`), keyed by group **UUID**.
2. On submit, entity builder `_group_context_domain_save_group_uuid` sets/unsets the domain's
   `group_context_domain.group_uuid` third-party setting; validate handler
   `_group_context_domain_validate_group_uuid` surfaces a `DomainGroupUnique` violation on the
   `group_uuid` field.
3. At runtime the two context services resolve the active domain (`domain.negotiator`) → the
   stored UUID → the group entity, honoring the group's own entity access when the context is used.

## Notes

- A missing/unassigned domain yields **no group** (context is optional; cache context returns
  `group.none`). The relationship is deliberately **one-to-one** (see README "Limitations").
- This is context/integration plumbing, **not** an access-control module — it tells consumers
  which group is active; enforcing tenant isolation is Group's permissions plus your domain-access
  setup. Do not treat the returned context as an authorization boundary.
