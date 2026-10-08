<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The accordion field formatter

Formatter id: **`paragraphs_jquery_ui_accordion_formatter`**. It only appears for a field that
is a **multi-value** `entity_reference_revisions` field targeting the **`paragraph`** entity
type (`isApplicable()` checks `isMultiple()` and `target_type === 'paragraph'`). Configure it on
the entity's **Manage display** (`entity_view_display` config).

## Settings (`field.formatter.settings.paragraphs_jquery_ui_accordion_formatter`)

| Setting | Type | Meaning |
|---|---|---|
| `bundle` | string | which paragraph bundle the formatter reads |
| `title` | string | field on that bundle used as each accordion **header** |
| `content` | string | field on that bundle used as the collapsible **body** |
| `view_mode` | string | view mode used to render the body field (default `default`) |
| `active` | int (0/1) | open the first panel by default (1) or start all closed (0) |
| `simple_id` | bool | use sequential numeric ids (`1,2,3`) instead of transliterated title ids |
| `autoscroll` | bool | scroll the opened item into view |
| `autoscroll_offset` | string | extra pixel offset when auto-scrolling (e.g. `80`) |
| `autoscroll_offset_toolbar` | bool | apply the offset only for users who see the admin toolbar |

Prerequisite: the paragraph bundle picked in `bundle` should have the `title` and `content`
fields you select. `title` is read as a plain value; `content` is rendered with `view_mode`.

## Apply with drush

```php
$vd = \Drupal::service('entity_display.repository')->getViewDisplay('node','page','default');
$vd->setComponent('field_sections', [
  'type' => 'paragraphs_jquery_ui_accordion_formatter',
  'region' => 'content',
  'settings' => [
    'bundle' => 'accordion_item',
    'title' => 'field_heading',
    'content' => 'field_body',
    'view_mode' => 'default',
    'active' => 1,
    'simple_id' => FALSE,
    'autoscroll' => FALSE,
  ],
])->save();
```

Read it back:
`drush cget core.entity_view_display.node.page.default content.field_sections`.

## Rendering

Output uses the `paragraphs_jquery_ui_accordion_formatter` theme hook (template
`paragraphs-jquery-ui-accordion-formatter.html.twig`) and attaches the
`paragraphs_jquery_ui_accordion/accordion` library, which pulls in Drupal core's jQuery UI
Accordion through the `jquery_ui_accordion` module. No extra JS libraries are required. The
accordion container id is `accordion-<entity id>` (or numeric ids when `simple_id` is on).
