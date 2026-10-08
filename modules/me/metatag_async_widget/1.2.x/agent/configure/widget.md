# Configure — the async metatag widget

No admin settings page (`configure = null`). You "configure" it by choosing it as the widget for
a **Metatag field** on an entity's *Manage form display*.

## The widget plugin

`src/Plugin/Field/FieldWidget/AsyncMetatagFirehose.php`:

```php
@FieldWidget(
  id = "metatag_async_widget_firehose",
  label = @Translation("Advanced meta tags form (async)"),
  field_types = {"metatag"},
)
```

Extends core Metatag's `MetatagFirehose`. Prerequisite: the bundle must have a field of type
`metatag` (metatag fields are added via Metatag; there is no metatag field on a bundle by default).

## Enable it (UI)

Structure → (content type) → **Manage form display** → find the Metatag field → set its **Widget**
to **Advanced meta tags form (async)** → Update → Save.

## Enable it (code / config)

Set the metatag field's component on the entity_form_display:

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$fd->setComponent('field_meta_tags', [
  'type' => 'metatag_async_widget_firehose',
  'weight' => 50,
  'region' => 'content',
  'settings' => ['sidebar' => TRUE],
])->save();
```

Resulting config: in `core.entity_form_display.<entity>.<bundle>.<mode>`, the field's component
has `type: metatag_async_widget_firehose`.

## Settings

- **`sidebar`** (bool, inherited from `MetatagFirehose`) — when TRUE the widget's details element
  joins the node form's **advanced** sidebar group (`#group => 'advanced'`); otherwise it stays in
  the main field area. Config schema `field.widget.settings.metatag_async_widget_firehose` extends
  `field.widget.settings.metatag_firehose`, so it carries the same setting keys as the core
  firehose widget.

## Behaviour notes (relevant to configuration)

- On first render the widget shows only a **"Customize meta tags"** submit button; clicking it
  fires an AJAX submit (`customizeMetaTagsSubmit` → `metatag_async_widget_customize_meta_tags`
  form-state flag → rebuild) that reveals the full Metatag firehose form (basic group open).
- If the editor saves **without** expanding the form, `massageFormValues()`/`extractFormValues()`
  keep the entity's existing meta-tag values (resolved from the stored entity/revision/translation
  via hidden entity-id/revision/language fields), so no data is lost. This is the whole point:
  the expensive form is built only when actually needed.
