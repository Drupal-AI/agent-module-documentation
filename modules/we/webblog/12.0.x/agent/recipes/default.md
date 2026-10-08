<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Web Blog recipe & provisioned config

Web Blog has essentially no runtime PHP. `webblog.install` implements one hook:

```php
function webblog_install($is_syncing) {
  if (\Drupal::isConfigSyncing()) return;         // config import brings its own config
  if (!$is_syncing) {
    RecipeRunner::processRecipe(Recipe::createFromDirectory(__DIR__ . '/recipes/default'));
  }
}
```

So enabling the module (on its own, not via a config import) applies `recipes/default/recipe.yml`.
That recipe is `type: install`: it first applies the sibling `webdev` and `webassets` default recipes,
installs the dependency modules (`path text node user menu_ui content_moderation media_library
manage_display entityqueue webdev webassets display_builder display_builder_entity_view
display_builder_ui`) and finally `webblog`, imports `display_builder.profile.default`, then imports
the config below (`config.strict: false`).

## Install / enable

```bash
ddev composer require drupal/webblog
ddev drush en webblog -y      # runs webblog_install() → applies recipes/default
ddev drush cr
```

Applying the recipe a second time is a no-op for already-present config. Uninstalling the module does
not automatically remove the created content type / view / queue (recipe config is not reverted on
uninstall).

## Content type — `node.type.webblog.yml`
- Machine name `webblog`, label **Web Blog**. `new_revision: true`, `preview_mode: 1`,
  `display_submitted: true`.
- menu_ui third-party settings: available menu `main`, default parent `main:`.

## Fields
- **body** — `field.field.node.webblog.body`, type `text_with_summary` (storage `node.body`, shared core
  Body field), not required, translatable, `display_summary: true`.
- **field_media** — `field.field.node.webblog.field_media`, `entity_reference` to **media**, cardinality
  1, handler `default:media`, `target_bundles: {image}` (image media only), `auto_create: false`.
  Storage `field.storage.node.field_media` (`target_type: media`).

## Form display — `core.entity_form_display.node.webblog.default.yml`
Visible widgets: `title` (textfield), `uid` (author autocomplete), `created` (datetime), `promote`,
`sticky`, `status`, `moderation_state` (moderation_state_default), `path`, `body`
(text_textarea_with_summary, 9 rows), `field_media` (media_library_widget). Nothing hidden.

## View modes & Display Builder
- View modes `node.teaser` (status true) and `node.full` (status false in config but referenced).
- `core.entity_view_display.node.webblog.default|full|teaser` each carry
  `third_party_settings.display_builder` with `profile: default` and per-field source formatters
  (`manage_display` + `display_builder` modules). Highlights:
  - **default**: title `h2` linked, body `text_default`, media rendered `square`.
  - **teaser**: title `h3` linked, body `smart_trim` 200 chars with a "Read more…" link, media `standard`;
    `created`/`field_media`/`uid` hidden in the classic fallback.
  - **full**: title `h1`, media `ultrawide`, formatted date `M d, Y`.

## View — `views.view.webblogs.yml`
- Base table `node_field_data`; id `webblogs`, label **Web Blogs**.
- Filters: `status = 1` (published) and `type = webblog`. Sort: `created` DESC. Access: `perm =
  access content`. Cache: tag-based, with `user.node_grants:view` + `user.permissions` contexts.
- **default** display: 3-column `grid_responsive` style, row = `entity:node` in **teaser** view mode,
  full pager 9/page, single `title` field (link to entity).
- **block_webblogs_list** display: reusable block for a general blog index.
- **block_featured_webblogs** display: `some` pager (3 items), an `entity_queue`/`entity_queue_position`
  relationship + sort limited to the `featured_webblogs` queue — a hand-curated highlight block.
- There is **no `page` display**, so the module adds no listing route/URL; place the block displays
  (or add a page display) to expose the blog to visitors.

## Entityqueue — `entityqueue.entity_queue.featured_webblogs.yml`
- `id: featured_webblogs`, label **Featured Web Blogs**, `handler: simple`, targets `node` bundle
  `webblog`, `min_size: 0`, `max_size: 0`, `act_as_queue: false`. Manage members at
  `/admin/structure/entityqueue` → *Featured Web Blogs*.

## Editor workflow
1. **Create a post**: `/node/add/webblog` — enter Title and Body, optionally add an image through the
   Media Library, set the moderation state, and (optionally) a menu link / URL alias.

   ![Web Blog create form](../../../../../../../screenshots/webblog/12.0.x/node-add-webblog.png)

2. **Publish** it (moderation state → published) so it appears in the `webblogs` view (published-only).
3. **Feature** a post: add it to the *Featured Web Blogs* entityqueue and place the
   `block_featured_webblogs` block.
4. **Adjust structure/fields** at `/admin/structure/types/manage/webblog` — everything is plain config.

   ![Web Blog Manage fields](../../../../../../../screenshots/webblog/12.0.x/manage-fields.png)

## Access
No custom permissions or routes. Creating/editing posts requires the standard
`create/edit webblog content` node permissions; the listing view is gated by `access content` and only
shows published nodes, with core node grants applied via the `user.node_grants:view` cache context.
