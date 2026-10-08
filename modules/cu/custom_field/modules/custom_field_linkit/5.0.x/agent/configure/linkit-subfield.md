<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Use Linkit on a Custom Field column

`custom_field_linkit` only adds widgets/formatters to Custom Field — there is no field type,
settings form or route of its own. You select a Linkit widget/formatter per column.

## Which plugin for which column type

| Plugin | Kind | Column type | Base plugin |
|---|---|---|---|
| `linkit` | widget | `link` | LinkWidget |
| `linkit_url` | widget | `uri` | UrlWidget |
| `linkit` | formatter | `link` | link formatter |
| `linkit_url` | formatter | `uri` | uri formatter |

## Assign the widget (entity form display)

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$c = $fd->getComponent('field_links');           // custom_stacked | custom_flex
$c['settings']['fields']['cta']['type'] = 'linkit';          // 'cta' is a link column
$c['settings']['fields']['cta']['linkit_profile'] = 'default';
$fd->setComponent('field_links', $c)->save();
```

Read back: `drush cget core.entity_form_display.node.article.default content.field_links` →
`settings.fields.cta.type: linkit`.

## Assign the formatter (entity view display)

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$c = $vd->getComponent('field_links');           // custom_formatter | custom_table | …
$c['settings']['fields']['cta']['format_type'] = 'linkit';
$vd->setComponent('field_links', $c)->save();
```

## Linkit profile

The widget/formatter accept Linkit settings (e.g. `linkit_profile`, auto-link text). These keys are
added to the Custom Field config schema at runtime by `hook_config_schema_info_alter()` in
`src/Hook/ConfigSchemaHooks.php`; point them at an existing `linkit.linkit_profile.*` config entity
(a `default` profile ships with Linkit).
