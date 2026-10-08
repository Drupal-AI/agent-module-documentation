# Block content template — theming reference

All behavior is in `block_content_template.module` + `templates/block-content.html.twig`. There is no
config; you theme by adding suggestion-named Twig files to your theme.

## Theme hook

`hook_theme()` registers:

```php
'block_content' => ['render element' => 'elements']
```

`hook_ENTITY_TYPE_view_alter()` for `block_content` (`block_content_template_block_content_view_alter()`)
sets `$build['#theme'] = 'block_content';` so **every** rendered custom block uses this template.

## Template file & default markup

`templates/block-content.html.twig` renders:

```
<div{{ attributes.addClass(classes) }}>
  {{ title_prefix }}{{ title_suffix }}
  <div class="block-content__content">{{ content }}</div>
</div>
```

`classes` = `block-content`, `block-content--type-<bundle|clean_class>`, `block-content--<id>`,
`block-content--view-mode-<view_mode|clean_class>`.

## Preprocess variables (`template_preprocess_block_content`)

| Variable | Value |
|---|---|
| `id` | `$block_content->id()` |
| `bundle` | `$block_content->bundle()` |
| `view_mode` | the render `#view_mode` |
| `label` | `$block_content->label()` |
| `content` | child render elements; if `_layout_builder` is present, its output is passed through instead |

It also unsets `attributes['data-quickedit-entity-id']`.

## Theme suggestions (override targets)

`hook_theme_suggestions_HOOK()` (`..._theme_suggestions_block_content`) returns, in order:

| Suggestion | Template file to create |
|---|---|
| `block_content__<view_mode>` | `block-content--<view-mode>.html.twig` |
| `block_content__<bundle>` | `block-content--<bundle>.html.twig` |
| `block_content__<bundle>__<view_mode>` | `block-content--<bundle>--<view-mode>.html.twig` |
| `block_content__<id>` | `block-content--<id>.html.twig` |
| `block_content__<id>__<view_mode>` | `block-content--<id>--<view-mode>.html.twig` |

(view-mode `.` is sanitized to `_`). Later entries win, so id+view-mode is the most specific override.

## Using it

Enable the module (`drush en block_content_template`), then add the desired
`block-content--*.html.twig` file to your active theme and clear caches. To confirm the hook is
registered on a running site: `\Drupal::service('theme.registry')->get()['block_content']`.
