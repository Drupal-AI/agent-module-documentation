# The three formatters & how to configure them

All three are configured on an entity's **Manage display** page (`/admin/structure/…/display`)
or directly in `core.entity_view_display.<entity>.<bundle>.<view_mode>` under
`content.<field>.type` + `content.<field>.settings`. There is no module settings form.

## 1. field_formatter_with_inline_settings

- **Label**: "Field formatter with inline settings"
- **Field types**: `entity_reference`, `entity_reference_revisions`
- Pick one field of the referenced entity and configure that inner field's formatter inline
  (AJAX-driven select of Field name → Formatter → the formatter's own settings).

Settings (schema `field.formatter.settings.field_formatter_with_inline_settings`):

```yaml
type: field_formatter_with_inline_settings
settings:
  field_name: body           # machine name of the referenced entity's field to show
  type: text_default         # inner formatter plugin id applied to that field
  settings: {}               # that inner formatter's own settings
  label: above               # above | inline | hidden | visually_hidden (target field label)
  link_to_entity: false      # link output to the parent (host) entity
```

## 2. field_formatter_from_view_display

- **Label**: "Field formatter from view display"
- **Field types**: `entity_reference`, `entity_reference_revisions`
- Render one referenced field using the formatter already defined in a chosen **view mode**
  of the referenced entity. Internally it loads that view display and removes every
  component except `field_name`.

Settings (schema `field.formatter.settings.field_formatter_from_view_display`):

```yaml
type: field_formatter_from_view_display
settings:
  view_mode: teaser          # view mode of the referenced entity to borrow formatting from
  field_name: field_image    # the single field to keep/render
  link_to_entity: false
```

## 3. field_link ("Field linker")

- **Label**: "Field linker"
- **Field types**: **all** (attached at runtime by `hook_field_formatter_info_alter()`)
- Renders the field with any other applicable formatter, then wraps **each** rendered item in
  a link to the host entity's canonical URL (`$items->getEntity()->toUrl('canonical')`).

Settings (schema `field.formatter.settings.field_link`):

```yaml
type: field_link
settings:
  type: image        # the inner formatter id used to render the field before linking
  settings: {}       # that inner formatter's settings
```

Note: `field_link` excludes itself from the inner-formatter options, so you can't nest it in
itself.

## Set one via drush (scriptable)

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_author', [
  'type' => 'field_formatter_from_view_display',
  'label' => 'hidden',
  'settings' => ['view_mode' => 'teaser', 'field_name' => 'field_photo', 'link_to_entity' => FALSE],
  'region' => 'content', 'weight' => 5,
])->save();
```

Read back with `drush cget core.entity_view_display.node.article.default content.field_author`.

## The `link_to_entity` option (formatters 1 & 2 only)

Added by `FieldFormatterBase::settingsForm()`. When checked, `viewElements()` sets each
rendered inner field's `#url` to the **parent** entity's canonical URL (language-aware),
overriding the referenced entity's own link settings — no extra wrapper markup. It only works
for field render arrays that honour `#url`.
