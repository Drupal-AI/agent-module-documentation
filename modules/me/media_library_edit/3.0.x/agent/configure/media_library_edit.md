# Configure the Media Library edit button

The module has **no admin page, route, or `configure` link**. It attaches to the core
`media_library_widget` via **third-party widget settings** and field-widget alter hooks in
`media_library_edit.module`. You configure it per widget on a form display.

## Where to enable it

1. Go to the entity's **Manage form display** (e.g. `/admin/structure/types/manage/article/form-display`).
2. On a field that uses the **Media library** widget (`media_library_widget`), open the
   widget's settings (gear icon).
3. Two settings appear (only for `media_library_widget`):

| Setting (form key) | Type | Meaning |
|---|---|---|
| `show_edit` | checkbox | "Show edit button" — turns the per-item edit link on |
| `edit_form_mode` | select | "Form mode" — which media form mode the edit modal renders (options from `entity_display.repository::getFormModeOptions('media')`); only visible/required when `show_edit` is checked |

The settings summary on the widget shows `Show edit button` and `Edit form mode: <label>`
when enabled.

## Config storage / schema

Stored as third-party settings on the form-display's widget, schema type
`field.widget.third_party.media_library_edit` (`config/schema/media_library_edit.schema.yml`):

```yaml
field.widget.third_party.media_library_edit:
  type: mapping
  mapping:
    show_edit:      { type: boolean, label: 'Show edit button' }
    edit_form_mode: { type: string,  label: 'Edit form mode' }
```

Because it lives on the `core.entity_form_display.*` config, it **exports and deploys with
`drush config:export` / `config:import`** — no separate settings object.

## Runtime behavior (what enabling it does)

- `hook_field_widget_single_element_form_alter` adds a `#type => link` edit button per
  selected media item, **only when** `$media->access('update')` is TRUE and the media type
  defines an `edit-form` link template.
- The edit URL carries query params `media_library_edit=ajax` and (if a form mode was
  chosen) `media_library_form_mode=<mode>`; the link opens a **modal** dialog
  (`data-dialog-type=modal`, library `media_library_edit/admin` + `core/drupal.dialog.ajax`).
- `hook_form_alter` (when `media_library_edit=ajax`): hides the media form's **delete**
  action and rewires **save** to the AJAX callback `_media_library_edit_media_edit_update`,
  which closes the dialog and `ReplaceCommand`s the item's rendered `media_library` view;
  on validation error it prepends status messages.
- `hook_entity_form_display_alter`: when `media_library_form_mode` is present and valid for
  the media bundle, swaps the form display to that form mode.

## Notes

- Applies to `media_library_widget` only; no effect on other widgets.
- No permissions defined — visibility is gated by core media `update` access per item.
- Attached asset library: `media_library_edit/admin` (admin CSS/JS, depends on
  `media_library/ui`).
