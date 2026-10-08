<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the fixed-text formatters

There is no admin settings page. You configure per field, per view mode, on the entity's
**Manage display** page, or directly in `entity_view_display` config.

## `fixed_text_link` — for `link` fields

Label on the Manage display formatter select: **"Link with fixed text"**. Extends core
`LinkFormatter` but removes the *URL only*, *Show URL as plain text* and *Trim length* options
and forces the visible text. Settings (`field.formatter.settings.fixed_text_link`):

| Key | Type | Meaning |
|---|---|---|
| `link_text` | string (required) | The fixed visible link text, e.g. "View website". Default `View website`. |
| `link_class` | string | Optional class added to the `<a>` (`#options.attributes.class`). |
| `allow_override` | bool | If TRUE, the fixed text is used **only when the link item has no title**; a per-item title wins. If FALSE, the fixed text always replaces the title. |
| `rel` / `target` | string | Inherited from core LinkFormatter (`rel="nofollow"`, open in new window). |

## `fixed_text_file_url` — for `file` fields

Label: **"Link with a fixed text"** (note: applies to file fields, not link fields). Renders each
file as a link to its file URL. Settings:

| Key | Type | Meaning |
|---|---|---|
| `link_text` | string (required) | Fixed link text, default `Download`. |
| `link_class` | string | Optional class on the `<a>`. |
| `open_in_new_window` | bool | Adds `target="_blank"`. |

## Where it is stored

Config entity `core.entity_view_display.<entity_type>.<bundle>.<view_mode>`:

```yaml
content:
  field_website:
    type: fixed_text_link          # or fixed_text_file_url for a file field
    label: hidden
    settings:
      link_text: 'Visit our website'
      link_class: 'btn btn-primary'
      allow_override: false
    third_party_settings: {  }
```

## Via the UI

1. Go to the bundle's *Manage display* (e.g. Article: `/admin/structure/types/manage/article/display`).
2. On the link (or file) field's row, choose **Link with fixed text** (link) / **Link with a
   fixed text** (file) in the Format column.
3. Click the gear, set **Link text** (required), optionally **Link class**, and
   **Allow the title to be overridden** / **Open in a new window**.
4. **Update**, then **Save**.

## Via drush php:eval (scriptable)

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_website', [
  'type' => 'fixed_text_link',
  'label' => 'hidden',
  'settings' => ['link_text' => 'Visit our website', 'link_class' => '', 'allow_override' => FALSE],
])->save();
```

Read it back: `drush cget core.entity_view_display.node.article.default content.field_website`.
