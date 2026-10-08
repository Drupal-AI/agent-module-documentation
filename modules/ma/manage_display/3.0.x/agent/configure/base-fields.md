<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Which base fields become configurable, and how to set them

There is **no settings form and no configure route**. Enabling the module is the configuration:
`hook_entity_base_field_info_alter()` calls `setDisplayConfigurable('view', TRUE)` plus
`setDisplayOptions('view', …)` on a hard-coded list (see `manage_display_base_field_info()`).

## The list (exactly what the module alters)

| Entity type | Field | Default display options |
|---|---|---|
| `node` | `title` | `{type: title, label: hidden, weight: -49}` |
| `node` | `created` | `{region: hidden}` |
| `node` | `uid` | `{region: hidden}` |
| `user` | `name` | `{region: hidden}` |
| `taxonomy_term` | `name` | `{type: title, label: hidden, weight: -49}` |
| `comment` | `subject` | `{type: title, label: hidden, weight: -49, settings: {tag: h3}}` |
| `comment` | `uid` | `{type: submitted, label: hidden, weight: -51}` |
| `comment` | `created` | `{type: timestamp, label: hidden}` |
| `comment` | `pid` | `{type: in_reply_to, label: hidden}` |
| `aggregator_feed` | `title` | `{type: title, label: hidden, weight: -49}` |
| `aggregator_feed` | `image` | `{type: uri_link, label: hidden, weight: 2}` |
| `aggregator_feed` | `description` | `{type: aggregator_xss, label: hidden, weight: 3}` |
| `aggregator_item` | `title` | `{type: title, label: hidden, weight: -49, settings: {tag: h3}}` |
| `aggregator_item` | `description` | `{type: aggregator_xss, label: hidden, weight: 2}` |

`uid`/`created` default to hidden on nodes because that is right for most teasers — you opt in.

## Entity-type flags set by `hook_entity_type_build()`

- `enable_base_field_custom_preprocess_skipping = TRUE` on `node`, `taxonomy_term`,
  `aggregator_feed`, `aggregator_item`, `comment` — stops core preprocess printing the value twice.
- `enable_page_title_template = TRUE` on `node`, `taxonomy_term`, `aggregator_feed`, `media`.
- `user` gets `entity_keys.label = name` (otherwise the username prints twice on the user page).

## Where the config lives

Components land in the normal display config entity:

```
core.entity_view_display.<entity_type>.<bundle>.<view_mode>
  content:
    title:
      type: title
      label: hidden
      settings: {link_to_entity: true, tag: h2}
      weight: -49
      region: content
```

## Read it back

```bash
drush cget core.entity_view_display.node.article.default content.title
drush cget core.entity_view_display.node.article.default content.uid
```

## Set it with drush php:eval

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('title', [
  'type' => 'title', 'label' => 'hidden', 'weight' => -49, 'region' => 'content',
  'settings' => ['tag' => 'h1', 'link_to_entity' => FALSE],
])->save();

// Show the byline: put the 'submitted' formatter on the owner field.
$vd->setComponent('uid', ['type' => 'submitted', 'label' => 'hidden', 'weight' => -50,
  'region' => 'content', 'settings' => ['user_picture' => 'compact']])->save();
```

To hide a base field again use `$vd->removeComponent('title')->save();` (it moves to `hidden`).

## Admin forms the module prunes

- `hook_form_node_type_form_alter()` sets `$form['display']['#access'] = FALSE` — the content
  type's *Display settings* ("Display author and date information") fieldset disappears, because
  the `submitted` component replaces it.
- `hook_form_system_theme_settings_alter()` hides `toggle_node_user_picture` and
  `toggle_comment_user_picture` — the `submitted` formatter has its own user-picture setting.

## Update hooks worth knowing

- `manage_display_update_9201()` uninstalls the obsolete `manage_display_fix_title` submodule.
- `manage_display_update_9301()` renames the old `settings.linked` key to `settings.link_to_entity`
  on every `title` component.
- `manage_display_update_9302()` adds a `created` component (`type: timestamp`) wherever the owner
  field already uses the `submitted` formatter, so the date has something to render.
