<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# adva plugin types

Two managers (`adva.services.yml`):
- `plugin.manager.adva.consumer` → `AccessConsumerManager`, dir `Plugin/adva/AccessConsumer`,
  annotation `Drupal\adva\Annotation\AccessConsumer`, alter hook `advanced_access_consummer`.
- `plugin.manager.adva.provider` → `AccessProviderManager`, dir `Plugin/adva/AccessProvider`,
  annotation `Drupal\adva\Annotation\AccessProvider`, alter hook `adva_provider`.

## Access Provider
Declares what grants a user holds and what records an entity carries. Base classes:
`AccessProvider` (default no-op), `EntityTypeAccessProvider` (per-op/default/bundle config UI),
`ReferenceAccessProvider`. Annotation fields: `id`, `label`, `operations` (subset of
`view`/`update`/`delete`).

Implement:
- `getAccessGrants($operation, AccountInterface $account): array` — return
  `['<realm>' => [<gid>, ...]]` the account holds for that op.
- `getAccessRecords(EntityInterface $entity): array` — return rows
  `['realm'=>..., 'gid'=>..., 'grant_view'=>0|1, 'grant_update'=>0|1, 'grant_delete'=>0|1]`
  (optionally `langcode`) describing what grants unlock the entity.
- Optional config: `buildConfigForm`/`validateConfigForm`/`submitConfigForm`,
  `static appliesToType(EntityTypeInterface)` (default TRUE), `static getHelperMessage()`.

**Built-in `anonymous` provider** (`AnonymousAccessProvider extends EntityTypeAccessProvider`,
ops view/update/delete): `getAccessGrants()` always returns `['anonymous' => [1]]` (every user
holds the anonymous realm grant); the entity gets an `anonymous`/gid 1 record with grant bits set
only for the operations the admin ticked (per default and per-bundle). Net effect: content is
exposed to anonymous users only where the admin enabled it.

## Access Consumer
Enables adva for one entity type. Annotation fields `id`, `entityType`. Base classes:
- **`AccessConsumer` (basic):** exposes provider config; `getAccessGrants`/`getAccessRecords`
  aggregate across enabled providers (`array_merge_recursive` / `array_merge`). Does **not**
  touch the entity's access handler. Use when the entity has its own grant integration (e.g.
  nodes via `adva_na`'s `hook_node_grants`/`hook_node_access_records`).
- **`OverridingAccessConsumer` (advanced):** additionally `overrideAccessControlHandler()` sets
  the entity type's access handler to `AdvancedAccessEntityAccessControlHandler` (stashing the
  original as `adva_access_legacy`), and manages `adva_access` records + the rebuild queue.
  Use for entity types with no native grant system (e.g. media via `adva_media`).

Override points: `onChange(config)` (basic = no-op; node consumer flags a node_access rebuild;
overriding = `queue()`), `queue($entity_ids=NULL)` (clear + enqueue rebuild).

See [../api/access-model.md](../api/access-model.md) for how grants/records are stored and
evaluated.
