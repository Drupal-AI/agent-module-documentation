<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Create / inspect a "Link" field group

No configure route and no settings form. Everything is per-group config on an
**entity view display**.

## Where it is stored

```yaml
# core.entity_view_display.<entity_type>.<bundle>.<view_mode>
third_party_settings:
  field_group:
    group_teaser_link:            # your group machine name (field_group convention: group_*)
      children:                   # fields moved inside the <a>
        - field_image
        - body
      label: 'Teaser link'
      parent_name: ''
      region: content
      weight: 5
      format_type: link           # <- this module
      format_settings:
        # field_group base keys
        label: 'Teaser link'
        classes: ''
        id: ''
        show_empty_fields: false
        label_as_html: false
        # field_group_link keys (schema: field_group.field_group_formatter_plugin.link)
        target: entity            # see "target values" below
        custom_uri: ''
        target_attribute: default # 'default' | '_blank'
```

Children must also exist as real components of the same display, otherwise the group renders
nothing.

## The three settings

| Key | Values | Meaning |
|---|---|---|
| `target` | `_none` (default), `entity`, `custom_uri`, or a **field name** | where the anchor points |
| `custom_uri` | any URI string, Tokens supported | used only when `target: custom_uri` |
| `target_attribute` | `default` \| `_blank` | `_blank` emits `target="_blank"` on the `<a>` |

### `target` values

- `entity` — the rendered entity's canonical URL (`$entity->toUrl()`). Nothing is emitted for an
  unsaved entity. Label in the UI is *"Full &lt;entity type&gt; page"*.
- `custom_uri` — `custom_uri` is run through `token.replace()` with the entity as context
  (`clear` + `sanitize` on) and then `Url::fromUri()`. Must be a full URI —
  `https://…`, `internal:/…`, `entity:node/1`. An unparseable URI silently renders no link.
- A **field machine name** — offered in the select only for fields on that bundle whose type is
  `link`, `entity_reference`, `file` or `image`, **and** which are not base fields
  (`isBaseField() === FALSE`). So core base fields like `uid` are never offered.
- `_none` — the default; produces no link.

## Via the UI

1. *Manage display* for the bundle/view mode, e.g.
   `/admin/structure/types/manage/article/display` (or `…/display/teaser`).
2. **Add group** → *Link* → give it a label → **Save and continue**.
3. Set **Link target** (and **Custom URL** if you chose *Custom URL* — a token browser appears
   when the `token` module is enabled) and **Target attribute**, then **Update** / **Save**.
4. Drag the fields you want wrapped underneath the group row.

## Via drush php:eval (scriptable)

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')
  ->load('node.article.teaser');
$vd->setThirdPartySetting('field_group', 'group_teaser_link', [
  'children' => ['field_image', 'body'],
  'label' => 'Teaser link',
  'parent_name' => '',
  'region' => 'content',
  'weight' => 5,
  'format_type' => 'link',
  'format_settings' => [
    'label' => 'Teaser link',
    'classes' => 'card-link',
    'id' => '',
    'show_empty_fields' => FALSE,
    'label_as_html' => FALSE,
    'target' => 'entity',          // or 'custom_uri', or 'field_external_url'
    'custom_uri' => '',
    'target_attribute' => '_blank',
  ],
])->save();
```

Remove it with `$vd->unsetThirdPartySetting('field_group', 'group_teaser_link')->save();`.

## Read it back

```bash
drush cget core.entity_view_display.node.article.teaser third_party_settings.field_group
# find the group whose format_type is 'link' and read format_settings.target
```

PHP: `$vd->getThirdPartySetting('field_group', 'group_teaser_link')['format_settings']['target']`.

## Config schema

`field_group.field_group_formatter_plugin.link` extends
`field_group.field_group_formatter_plugin.base` and adds exactly `target`, `custom_uri` and
`target_attribute` (all strings). The base type supplies `label`, `classes`,
`show_empty_fields`, `id`, `label_as_html`.
