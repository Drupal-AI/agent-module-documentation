# Configure inline editing (the "Editable field" formatter)

There is **no admin settings page**. You enable inline editing per field by setting its
display formatter to `editablefields_formatter` on the entity's *Manage display*, and tune
it with the formatter settings below.

## Enable it

### Via the UI
1. Go to the bundle's *Manage display* (e.g. `/admin/structure/types/manage/article/display`).
2. On the field's row, choose the **Editable field** formatter.
3. Click the cog, choose the **form mode** whose widget to use, pick a **behaviour**, Update, Save.

### Where it is stored
In `core.entity_view_display.<entity>.<bundle>.<mode>` on the field component:

```yaml
content:
  field_note:
    type: editablefields_formatter
    settings:
      form_mode: default          # form mode whose widget renders the editable field
      behaviour: inline           # 'inline' or 'popup'
      bypass_access: false
      fallback_access: false
      display_mode_access: ''     # view mode to show when user has no update access
      fallback_edit: false
      display_mode_edit: ''       # view mode to show before the user clicks Edit (popup)
      fields_ajax_trigger: ''     # comma-separated field names that autosave on change
      fields_ajax_trigger_event: change   # e.g. 'change' (selects) or 'blur' (text)
    label: hidden
    weight: 0
    region: content
```

### Via drush php:eval (scriptable)
```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_note', [
  'type' => 'editablefields_formatter',
  'label' => 'hidden',
  'settings' => [
    'form_mode' => 'default',
    'behaviour' => 'inline',
  ],
  'weight' => 0,
  'region' => 'content',
])->save();
```

### Read it back
```bash
drush cget core.entity_view_display.node.article.default content.field_note
# type: editablefields_formatter ; settings.behaviour / settings.form_mode ...
```

## Settings reference

| Setting | Values | What it does |
|---|---|---|
| `form_mode` | a form mode machine name (`default`, …) | Which form mode's widget renders the editable field. **Required.** |
| `behaviour` | `inline` \| `popup` | Show the widget inline, or behind an "Edit" link that opens a modal dialog. |
| `bypass_access` | bool | Skip the entity `update` access check (field is editable regardless). |
| `fallback_access` | bool | When user has no access, render a fallback view mode instead of nothing. |
| `display_mode_access` | view mode | The fallback view mode used when `fallback_access` is on and access is denied. |
| `fallback_edit` | bool | (popup) Render a fallback view mode before the user clicks "Edit". |
| `display_mode_edit` | view mode | The view mode shown before the widget/popup is requested. |
| `fields_ajax_trigger` | CSV of field names | **Autosave**: when these fields change, submit via ajax; the Update button is hidden. |
| `fields_ajax_trigger_event` | JS event, e.g. `change`, `blur` | The DOM event that triggers the autosave. |

## Behaviours

- **inline** — the widget (built from `form_mode`) is embedded directly in the display as an
  ajax form (`EditableFieldsForm`); the user edits and clicks Update (or autosaves).
- **popup** — an "Edit" link (`use-ajax`, modal) opens the widget in a dialog via the
  `editablefields.get_from` route (`/editablefields/get-form/{entity_type}/{entity_id}/{form_mode}/{field_name}/{display_mode}/{selector}`).
  `display_mode_edit` controls what shows before the click.

## Access model

The field renders as editable only when the current user has the **`use editablefields`**
permission **and** `update` access to the entity — unless `bypass_access` is TRUE. If access
is denied and `fallback_access` is TRUE, the field is rendered read-only using
`display_mode_access`; otherwise nothing is output. See
[permissions/permissions.md](../permissions/permissions.md).

## Config schema

`field.formatter.settings.editablefields_formatter` (in `config/schema`) validates all the
keys above (`form_mode`, `behaviour`, `bypass_access`, `fallback_access`,
`display_mode_access`, `fallback_edit`, `display_mode_edit`, `fields_ajax_trigger`,
`fields_ajax_trigger_event`).
