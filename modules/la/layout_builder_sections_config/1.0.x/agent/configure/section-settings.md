<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Per-section settings (the Configure-section fields)

## The added fields

`hook_form_layout_builder_configure_section_alter()` adds these to the core
`layout_builder_configure_section` form (shown when you add/configure a section in Layout
Builder):

| Field | `#type` | Notes |
|---|---|---|
| `show_admin_title` | checkbox | "Show section title to end users" — gates the three title fields via `#states` |
| `title_wrapper` | select | options from `title_wrappers` global config |
| `title_position` | select | options from `title_positions` |
| `title_color` | select | options from `title_colors` |
| `section_id` | textfield | becomes the section wrapper's HTML `id` |
| `section_classes` | textarea | one CSS class per line, added to the section wrapper |

## Where the values are stored

**Not** in a global config object — in the **section's own layout configuration**. A custom
submit handler `_layout_builder_sections_config_submit_form()` is `array_unshift`-ed onto the
form's `#submit` (so it runs before core saves the section to tempstore) and writes:

```php
$config['layout_builder_sections_config'] = [
  'show_admin_title' => …, 'title_position' => …, 'title_color' => …,
  'title_wrapper' => …, 'section_id' => …, 'section_classes' => …,
];
$formObject->getCurrentLayout()->setConfiguration($config);
```

So the data ends up inside the layout section's configuration array (persisted with the
entity's / view display's Layout Builder sections, e.g. in the `layout_builder__layout` field
or the `third_party_settings.layout_builder.sections` of an entity view display), under the
`layout_builder_sections_config` key of that section's settings.

## How it renders

`hook_preprocess_layout(&$variables)` reads
`$variables['settings']['layout_builder_sections_config']` and:

- if `show_admin_title` is truthy: builds `$variables['content']['title']` = `{label:
  <section label>, wrapper: <title_wrapper>, attributes.class: [<title_position>,
  <title_color>]}`;
- sets `$variables['attributes']['id'] = section_id`;
- explodes `section_classes` on newlines (trim + drop empties) and merges them into
  `$variables['attributes']['class']`.

The shipped layout templates then print `content.title` inside a `<div>` with those classes and
the chosen wrapper tag around the label.

## Agent notes

- To programmatically set these, you must edit the **section object's** configuration in the
  entity/display's Layout Builder data — there is no single config key. The UI path is the
  supported route.
- `show_admin_title` off ⇒ no title is rendered regardless of wrapper/position/colour.
- Uninstalling the module does **not** purge the `layout_builder_sections_config` metadata
  already written into saved sections (documented known issue).
