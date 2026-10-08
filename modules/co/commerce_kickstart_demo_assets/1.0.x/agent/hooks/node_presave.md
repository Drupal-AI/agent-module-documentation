# hook: node presave — Layout Builder default-content fix-up

`commerce_kickstart_demo_assets_node_presave(EntityInterface $entity)` implements
`hook_ENTITY_TYPE_presave()` for **node** (`.module`). It runs its fix-up only for **new** nodes:
the body begins `if (!$entity->isNew()) { return; }`, so existing-node saves are skipped and only
nodes being created (e.g. by the recipe's default-content import) are rewritten. It then acts only
when the node `hasField('layout_builder__layout')`.

Purpose (from the code comment): work around three gaps — default-content differences between core and
contrib, incomplete Layout Builder support in the Default Content API, and the `bootstrap_styles`
module storing media references without UUID support.

What it rewrites on the node's `layout_builder__layout` value:
- **Per section** (`layout_builder\Section`): if `container_wrapper.bootstrap_styles` is present, its
  `background_media[image|video].media_uuid` is resolved to a local `media_id` and the UUID removed.
- **Per `SectionComponent`:** if `additional.target_uuid` is set, the referenced `block_content` is
  loaded by UUID and the component `configuration.block_id` / `configuration.block_revision_id` are
  set to the local block's id / revision id, then `target_uuid` is removed. Also resolves
  `additional.bootstrap_styles.block_style` background-media UUIDs the same way.

Resolution helper: `_commerce_kickstart_demo_assets_process_bootstrap_styles(mixed &$layout)` — uses
`entity.repository` `loadEntityByUuid('media', …)` to turn a `media_uuid` into `media_id` for both
section and component styles.

Why it matters to integrators: imported Layout Builder content references blocks and background media
by UUID; without this rewrite the placed blocks and Bootstrap background media would not resolve to
the freshly-imported entities on the target site.

Undeclared runtime dependencies exercised here: `layout_builder`, `block_content`, `media`, and data
shaped by `bootstrap_styles` / `bootstrap_layout_builder`.
