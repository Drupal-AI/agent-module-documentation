# Use and configure the "Entity Browser - Table" widget

There is **no configure route** (`configure: null`) and no global settings. You select the
widget per field, per form mode, on the bundle's *Manage form display* page (or in the
`entity_form_display` config).

## Prerequisite

The [Entity Browser](https://www.drupal.org/project/entity_browser) module must be enabled and
you need at least one Entity Browser configured (e.g. via `/admin/config/content/entity_browser`).
The table widget reuses an existing entity browser; it does not create one.

## Via the UI

1. Edit an `entity_reference` or `entity_reference_revisions` field's host bundle and open
   *Manage form display* (e.g. `/admin/structure/types/manage/article/form-display`).
2. In the field's **Widget** select list choose **Entity Browser - Table**.
3. Click the widget cog to open its settings (all inherited from Entity Browser):
   - **Entity browser** — which entity browser to open.
   - **Entity display plugin** (`field_widget_display`) — usually **Entity label**; choose
     **Rendered entity** to get a Thumbnail first column instead of a Title.
   - **Edit / Remove / Replace** button toggles.
   - **Selection mode**, **Open** behaviour.
   - **Additional Fields → "Status or, if enabled, moderation status."** — the only setting this
     module adds; ticking it adds a **Status** column to the table.
4. **Update**, then **Save**.

## Config shape (`entity_form_display`)

Stored on the field's component in `core.entity_form_display.<entity>.<bundle>.<form_mode>`:

```yaml
content:
  field_related:
    type: entity_reference_browser_table_widget
    settings:
      entity_browser: my_browser          # an existing entity_browser id
      field_widget_display: label         # 'label' | 'rendered_entity' | ...
      field_widget_display_settings: {}
      field_widget_edit: true
      field_widget_remove: true
      field_widget_replace: false
      selection_mode: selection_append
      open: false
      additional_fields:
        options:
          status: status                  # 'status' (checked) or 0 (unchecked)
```

`additional_fields.options.status` is the module-specific key. When it is truthy the widget
renders a Status column: the moderation state if `content_moderation` treats the entity as
moderated (`moderation_state` value), otherwise `Published` / `Unpublished` derived from the
entity's `status` field.

## Scriptable (drush php:eval)

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$c = $fd->getComponent('field_related');           // must be an entity reference field
$c['type'] = 'entity_reference_browser_table_widget';
$c['settings']['additional_fields']['options']['status'] = 'status';
$fd->setComponent('field_related', $c)->save();
```

## Read it back

```bash
drush cget core.entity_form_display.node.article.default content.field_related
# type should be entity_reference_browser_table_widget
```

## What the widget renders

Columns (each omitted when not applicable): drag handle, **Title** (or **Thumbnail** when
`field_widget_display` is `rendered_entity`), **Status** (only if enabled), **Weight**
(tabledrag, hidden by default with a "Show row weights" toggle), **Action** (Edit/Replace/Remove
buttons, shown only if any of those toggles are on). Replace is only offered when exactly one
entity is currently referenced.
