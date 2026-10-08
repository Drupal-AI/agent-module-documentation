<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ai_social_post entity, routes & access

## Content model
- **`ai_social_post`** — content entity (`src/Entity/AiSocialPost.php`), base table `ai_social_post`,
  entity keys `id`/`uuid`/`type` (bundle). Handlers: view builder
  `Entity\ViewBuilder\AiSocialPostViewBuilder`, list builder `Entity\Controller\AiSocialPostListBuilder`,
  forms `Form\AiSocialPostForm` (default/add/edit) + `Form\AiSocialPostDeleteForm`, access
  `AiSocialPostAccessControlHandler`, `AdminHtmlRouteProvider`. `bundle_entity_type = ai_social_post_type`,
  `field_ui_base_route = entity.ai_social_post_type.edit_form`.
  Base fields (`baseFieldDefinitions`): `node_id` (entity_reference → node, required),
  `user_id` (entity_reference → user, default = current user), `created`, `changed`.
  `hook_entity_type_build` (`.module`) forces the admin route provider and sets
  `admin_permission = administer ai_social_post entity`.
- **`ai_social_post_type`** — config bundle entity (`src/Entity/AiSocialPostType.php`),
  `config_prefix = ai_social_post_type`, `config_export = {id, label, uuid}` only (no schema dir ships).
  Bundles are installed by the platform submodules as `ai_social_posts.ai_social_post_type.<id>` config.

### preCreate node seeding
`AiSocialPost::preCreate()` — when a post is created in a node route context, it reads the node's
absolute URL and, for each content field (`post`, `title`, `subtitle`) that is a `FieldConfig` of type
`text_long`/`string`/`string_long` with a default value, rewrites the default to
`"/For <url> <prompt>. Include the link."`. This seeds the editor with the source URL + platform prompt.
A `\Drupal::logger('ai_social_posts')` error is logged if URL generation fails.

## Routes (`ai_social_posts.routing.yml` + `Routing/AiSocialPostRoutes`)
All are `_admin_route: TRUE`. Static:
- `entity.ai_social_post.collection` `/admin/content/ai-social-posts` — perm `view ai_social_post entity`.
- `entity.ai_social_post.canonical|edit_form|delete_form` — `_entity_access` view/update/delete.
- `ai_social_posts.ai_social_post_add` `/add` and `entity.ai_social_post.add_form/{type}` — `_entity_create_access`.
- `ai_social_posts.ai_social_post_settings` `/admin/structure/ai_social_post_settings` — perm
  `administer ai_social_post entity`. Form `Form\AiSocialPostSettingsForm` is a **stub** (static markup,
  empty submit) — no settings are stored; `configure` is intentionally null.
- `ai_social_posts.node.ai_social_posts` `/node/{node}/ai-social-posts` — perm `view ai_social_post entity`.
- `entity.ai_social_post_type.*` — perm `administer ai_social_post types`.

Dynamic (`AiSocialPostRoutes::routes()`, referenced by `route_callbacks`): the node overview at
`/admin/content/node/{node}/ai-social-posts` plus one `ai_social_posts.node.<type>_posts` route per
bundle, all gated by `view ai_social_post entity`.

## Permissions (`ai_social_posts.permissions.yml`)
`add / view / edit / delete ai_social_post entity`, `administer ai_social_post entity`,
`administer ai_social_post types`.

`AiSocialPostAccessControlHandler`: `administer ai_social_post entity` short-circuits to allowed;
otherwise `view`→`view …`, `update`→`edit …`, `delete`→`delete …`; create→`add …`.

## Node integration (`Controller\AiSocialPostController`)
- `nodeAiSocialPosts($node)` — loads all `ai_social_post_type` bundles; delegates to `nodeBundlePosts`
  for the first (or the single) bundle, or shows an "enable a type" message.
- `nodeBundlePosts($node, $bundle)` — builds the bundle's create form (destination set back to the
  node), then lists existing posts for that node+bundle. Each listed body is rendered with
  `#type => processed_text`, `#format => $post->get('post')->format ?: filter_default_format()` via
  `renderer->renderPlain()` — i.e. through the text format's filters, not raw.
- `addPage()` — single type → its form; multiple → `entity_add_list` theme.

## Hooks & menu (`.module`)
`hook_menu_links_discovered_alter` adds an "Add <type>" link per bundle under the collection.
`hook_theme` registers `ai_social_post`, `ai_social_posts_node_ai_social_posts`,
`ai_social_posts_overview`, `ai_social_posts_bundle_tab`. `hook_preprocess_breadcrumb` builds
breadcrumbs for entity/node tab routes. Local tasks: `ai_social_posts.links.task.yml` (node "Socials"
tab + `Plugin\Derivative\AiSocialPostLocalTasks` deriver for per-bundle tabs).
