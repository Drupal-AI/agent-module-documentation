<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `link_description` field type, widget, and formatters

These are core Link plugins subclassed to add a `description`. You do **not** implement a plugin
type — you consume these by creating a field.

## Field type — `link_description`

`Drupal\link_description\Plugin\Field\FieldType\LinkDescriptionItem extends LinkItem`.

- `@FieldType(id="link_description", default_widget="link_description", default_formatter="link_description")`
- Adds a `description` **string** property and a DB column `description` (`type: text`,
  `size: big`) on top of everything core `LinkItem` stores (`uri`, `title`, `options`).
- Inherits core field settings: `title` (0 disabled / 1 optional / 2 required link text) and
  `link_type` (`LinkItemInterface::LINK_INTERNAL` 0x01, `LINK_EXTERNAL` 0x10, `LINK_GENERIC` 0x11).

## Widget — `link_description`

`LinkDescriptionWidget extends LinkWidget`. Same URL + link-text inputs as core, plus a
`description` **textarea** (`#rows => 3`, title "Long description"). Widget settings schema
`field.widget.settings.link_description`: `placeholder_url`, `placeholder_title`.

## Formatters (both `field_types = {link_description}`)

| Formatter id | Label | Extends | Renders |
|---|---|---|---|
| `link_description` | Link with description | core `LinkFormatter` | `#theme => link_with_description` (the core link + a description paragraph). |
| `link_separate_description` | Title and link URL with description | core `LinkSeparateFormatter` | `#theme => link_with_description_separate_text_url` (separate title / URL / description). |

Formatter settings schema `field.formatter.settings.link_description` (shared by both, via
`link_separate_description` inheriting it): `trim_length` (int), `url_only` (bool),
`url_plain` (bool), `rel` (string, e.g. `nofollow`), `target` (string, e.g. `_blank`) — the
standard core Link formatter options. The description has no text format; it is output with
`nl2br` so newlines survive.

## Add the field (drush php:eval)

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;
FieldStorageConfig::create([
  'field_name' => 'field_ld_links', 'entity_type' => 'node',
  'type' => 'link_description', 'cardinality' => -1,
])->save();
FieldConfig::create([
  'field_name' => 'field_ld_links', 'entity_type' => 'node',
  'bundle' => 'article', 'label' => 'Related links',
  'settings' => ['title' => 1, 'link_type' => 0x11],
])->save();
// Optionally set the widget/formatter on the form/view displays; the field type's
// default_widget/default_formatter (both link_description) are used otherwise.
```

## Set a value

```php
$node->set('field_ld_links', [
  ['uri' => 'https://example.com', 'title' => 'Example', 'description' => "Line 1\nLine 2"],
]);
```
