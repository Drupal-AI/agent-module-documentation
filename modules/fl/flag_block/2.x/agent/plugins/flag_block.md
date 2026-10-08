<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block plugin `flag_block` (FlagBlock)

The module's entire functionality. Class `Drupal\flag_block\Plugin\Block\FlagBlock`
(`src/Plugin/Block/FlagBlock.php`), extends `Drupal\Core\Block\BlockBase`, implements
`ContainerFactoryPluginInterface`. Annotation: id `flag_block`, admin_label "Flag block",
category "Flag".

## Install / enable

- Requires the Flag contrib module and core Block. Enable: `drush en flag_block -y`
  (or Extend UI). Depends on `drupal:block` and `drupal:flag` per `flag_block.info.yml`.
- You must already have at least one configured flag at `/admin/structure/flags` for the block's
  select to be non-empty.

## Dependency injection (`create()` / `__construct()`)

- `flag` → `Drupal\flag\FlagServiceInterface` (loads flags: `getAllFlags()`, `getFlagById()`).
- `flag.link_builder` → `Drupal\flag\FlagLinkBuilderInterface` (builds the flag/unflag link).
- `current_route_match` → `Drupal\Core\Routing\RouteMatchInterface` (finds the current entity).

## Block settings form (`blockForm()` / `blockSubmit()`)

Two extra elements added to the standard block config form (placed via `/admin/structure/block`,
which itself requires the **`administer blocks`** permission):

| Key | Type | Notes |
| --- | --- | --- |
| `flag_block_settings` | `select`, **required** | Options are every flag from `flag->getAllFlags()` keyed by flag id → label. Description links to `/admin/structure/flags` (route `entity.flag.collection`). |
| `view_mode` | `textfield`, optional | Free-text Flag view mode name; lets you use a different flag template. Default `''`, falls back to `default` at render. |

`blockSubmit()` copies both values into `$this->configuration`. There is **no `defaultConfiguration()`
override and no config schema file** shipped by this module, so these keys rely on the generic block
config schema.

## Render logic (`build()`)

1. Reads `view_mode` from config (default `'default'`).
2. `$flag = flag->getFlagById($config['flag_block_settings'])`.
3. `$entity = getRouteEntity()`. If none → return **NULL** (block renders nothing).
4. If `checkBlockRender($flag, $entity)` is FALSE → return **NULL**.
5. Otherwise return `['flag' => flagLinkBuilder->build($flag->getFlaggableEntityTypeId(),
   $entity->id(), $config['flag_block_settings'], $view_mode)]`.

`flag.link_builder` (Flag core) generates the actual flag/unflag link, including Flag's own access
check and CSRF-token-protected action route — this module adds no link/route of its own.

## `checkBlockRender(Flag, ContentEntity)` — bundle/type guard

- Returns FALSE if `flag->getFlaggableEntityTypeId() !== entity->getEntityTypeId()`.
- Returns FALSE if the flag has bundles and the entity's bundle is not among
  `flag->getBundles()`.
- Otherwise TRUE. This just prevents rendering a link for an entity the flag doesn't apply to.

## `getRouteEntity()` — how the entity is found

- Iterates the current route's `parameters` option; for each parameter whose `type` starts with
  `entity:`, loads `routeMatch->getParameter($name)`.
- Returns it only when it is a `ContentEntityInterface` **and** `hasLinkTemplate('canonical')` is
  true; otherwise returns NULL.
- Consequence: the block only appears on entity canonical (and similarly entity-parameterised)
  routes — e.g. a node page — and stays empty on listings, admin, or non-entity routes.

## Caching

`getCacheMaxAge()` returns **0** — the block is never cached, so the link always reflects the
current user's live flag state. (No custom cache contexts/tags are declared; max-age 0 makes the
block uncacheable rather than relying on them.)

## Operating notes

- To place: `/admin/structure/block` → *Place block* → *Flag block*, choose the flag, optionally set
  a view mode, save. Add core block visibility conditions (path, content type, role) if you want to
  narrow where it shows beyond the automatic entity-route gating.
- If the block shows nothing: confirm you are on the flagged entity's canonical route, and that the
  chosen flag's entity type/bundle matches that entity.
- Access is entirely Flag core's: a user without the relevant flag permission gets no usable link.
