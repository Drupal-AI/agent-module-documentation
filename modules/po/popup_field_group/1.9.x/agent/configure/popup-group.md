<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Adding a Popup field group

No admin settings page (`configure: null`). You create a Popup group like any Field Group.

## UI

1. Go to *Manage form display* or *Manage display* for a bundle
   (e.g. `admin/structure/types/manage/article/form-display`).
2. Click **+ Add group**, choose **Popup** in the group-type dropdown, give it a label,
   *Save and continue*.
3. Set the popup options (below), *Create group*.
4. Drag fields into the group and Save.

## Where it is stored

In the display config entity's `third_party_settings.field_group.<group_name>`:

```yaml
# core.entity_form_display.node.article.default -> third_party_settings.field_group
group_extra:
  label: 'Extra details'
  children: [field_a, field_b]
  parent_name: ''
  region: content
  weight: 5
  format_type: popup          # <-- this module
  format_settings:
    popup_link:
      show: 1                  # show the "Open popup" trigger link
      text: 'Show popup'
      classes: ''              # extra CSS classes on the link
    popup_labels:
      title: ''                # dialog title
      close_text: ''           # close-button caption
    popup_settings:
      modal: 1                 # 1 = modal, 0 = non-modal
      dialog_class: ''
      close_on_escape: 1
      height: auto
      min_height: ''
      max_height: ''
      width: auto
      min_width: ''
      max_width: ''
      position_horizontal: center   # left | center | right (required)
      position_vertical: center     # top | center | bottom (required)
      append_to: ''            # CSS selector to append the dialog markup to
    extra_css: ''              # only usable if system_stream_wrapper is installed
```

## Setting it programmatically

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')
  ->load('node.article.default');
$fd->setThirdPartySetting('field_group', 'group_extra', [
  'label' => 'Extra details',
  'children' => ['field_a', 'field_b'],
  'parent_name' => '', 'region' => 'content', 'weight' => 5,
  'format_type' => 'popup',
  'format_settings' => [
    'popup_link' => ['show' => 1, 'text' => 'Show popup', 'classes' => ''],
    'popup_labels' => ['title' => 'Extra', 'close_text' => 'Close'],
    'popup_settings' => ['modal' => 1, 'close_on_escape' => 1,
      'position_horizontal' => 'center', 'position_vertical' => 'center'],
  ],
]);
$fd->save();
```

`position_horizontal` and `position_vertical` are required by the settings form.
`popup_settings.modal` toggles a blocking modal vs a floating dialog. Use the same
`format_type: popup` on an `entity_view_display` to pop up content on the rendered entity
(the formatter supports both `form` and `view` contexts).
