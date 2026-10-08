# Block: Social wall

`src/Plugin/Block/SocialWallBlock.php` — `@Block(id = "social_wall_block", admin_label = "Social wall
block")`, extends `BlockBase`, `ContainerFactoryPluginInterface`. This is the only render surface: it
combines the enabled `social_network_config` entities into one wall. Place it via Block Layout or
Layout Builder.

Injected services: `entity_type.manager`, `plugin.manager.social_network`.

## Block configuration form (`blockForm()` / `blockSubmit()`)

Renders a draggable table (`#type => table`, tabledrag group `group-order-weight`) with one row per
existing `social_network_config` entity. Per row:

- `display` — checkbox, whether to include this network on the wall.
- `weight` — `#type => weight`, ordering.

`blockSubmit()` stores these into block configuration under
`social_networks[<entity id>][display]` and `social_networks[<entity id>][weight]`, plus
`block_id` (from `$form['id']['#value']`) used for cache tagging. Rows are pre-sorted by the stored
weight.

## build()

- `#theme => 'social_wall__block'` (template `templates/social-wall--block.html.twig`).
- For each configured network with `display` truthy: loads its `social_network_config` entity, reads
  the third-party settings `social_wall.sn_config[<id>]`, instantiates the connector with
  `plugin.manager.social_network->createInstance($entity->getWidget(), $settings)`, and calls the
  plugin's `render()`. The result becomes `#elements[<id>]`, tagged with `#weight` from block config.
- `#elements` are then `usort`ed by `#weight`.
- Cache: `#cache['tags']` = `config:social_wall.social_network_config`, `social_network_config_list`.
  `getCacheTags()` additionally adds `config:context.context.<context_id>` and
  `config:block.block.<block_id>` when those config keys are present, so re-saving the block or its
  context invalidates the wall. Each connector's `render()` also sets its own `#cache['max-age']`
  (Twitter 900 s, Instagram 1200 s) and caches fetched API results in `cache.default`.

## What a connector returns

Each `render()` supplies a themed sub-build (`social_network_twitter_block` /
`social_network_instagram_block`) whose `#elements` are per-post arrays (`body_text`/`caption`,
`creation_timestamp`, `post_url`, and for Instagram an `image_url` data URI). See
[../plugins/social-network.md](../plugins/social-network.md) and
[../theme/templates.md](../theme/templates.md).
