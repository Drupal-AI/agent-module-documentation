<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# views_addons handlers — mechanism detail

Both handlers are registered in `views_addons.views.inc` via `hook_views_data_alter()`, attached
to the global `views` table (so they appear as "Global:" options in the Views UI):

```php
$data['views']['views_addons_custom_advanced']['field']['id'] = 'views_addons_custom_advanced';
$data['views']['views_addons_add_entity']['area']['id']       = 'views_addons_add_entity';
```

## Advanced Custom Text — `CustomAdvanced` (Views field)
File: `src/Plugin/views/field/CustomAdvanced.php`. Extends core
`Drupal\views\Plugin\views\field\Custom`.

- `query()` — overridden empty; this is a presentational global field with no data source.
- `defineOptions()` — adds `additional_tags` (default `'svg g circle text'`) on top of the core
  Custom field options (which include the `alter.text` custom markup and force `alter_text` = TRUE).
- `buildOptionsForm()` — adds an "additional allowed tags" textfield.
- `viewsTokenReplace($text, $tokens)` — the core method it overrides. Behaviour:
  1. `$allowedTags = array_merge(Xss::getAdminTagList(), explode(' ', $this->options['additional_tags']))`.
  2. Builds an allow-list string like `<a><em>...<svg><g><circle><text>`.
  3. With tokens present, renders an `inline_template` (`#template` = the admin text, `#context`
     = the token map) and runs `strip_tags($children, $allowedTagsString)` in a `#post_render`
     callback; with no tokens, returns `strip_tags($text, $allowedTagsString)`.

Difference from core: core `PluginBase::viewsTokenReplace()` finishes with `Xss::filterAdmin()`,
and core `FieldPluginBase::renderText()` marks the result safe *specifically because* of that
filterAdmin pass. This override substitutes `strip_tags()`, which removes only disallowed *tags* —
it does not strip attributes (e.g. `on*` event handlers, `style`) or neutralize `javascript:`
URLs on allowed tags. The value is still flagged as safe markup and printed without further
escaping. See the local security notes for the resulting consideration.

## Add Entity Link — `AddCoreEntity` (Views area)
File: `src/Plugin/views/area/AddCoreEntity.php`. Extends `AreaPluginBase`; injects
`entity_type.manager` and `entity_type.bundle.info`.

- Options: `entity_type` (node/user/taxonomy_term, default node), `bundle`, `vocabulary`,
  `link_text` (default "Add new item"), `css_classes`.
- `buildOptionsForm()` — select for entity type; bundle select (node types) and vocabulary select
  (taxonomy vocabularies) shown conditionally via `#states`; textfields for link text and classes.
- `render($empty)` — maps the entity type to an add-form route:
  - node → `node.add` with `node_type` = bundle (only if a bundle is set);
  - user → `entity.user.add_form`;
  - taxonomy_term → `entity.taxonomy_term.add_form` with `taxonomy_vocabulary` = vocabulary.
  Builds a `Link`, applies `css_classes` (exploded into a class attribute array — Drupal escapes
  attribute values), sets `#access` to the entity `createAccess(..., TRUE)` result, adds
  `user.permissions` cache context plus `config:views.view.<id>` and entity-type cache tags.
  Returns `['#access' => FALSE]` when no route resolves.

Access is handled correctly: the link is only rendered for viewers who pass the create-access
check, and permission-sensitive caching is declared. `link_text` and `css_classes` are
administrator-entered and pass through the render/attribute system, which escapes them.
