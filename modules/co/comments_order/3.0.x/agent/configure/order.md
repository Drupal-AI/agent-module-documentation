<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure comment ordering

There is **no configure route** (`configure: null`) and no global settings form. Ordering is set
**per comment field**, on the field edit form of a bundle's *Manage fields* page, and stored as
third-party settings on that field's `field.field.*` config entity.

## The three settings

| Setting | Key | Values | Default | Meaning |
|---|---|---|---|---|
| Comments order | `order` | `ASC` / `DESC` | `ASC` | Oldest-first (ascending) or newest-first (descending). |
| Natural order for children | `children_natural_order` | `1` / `0` | `1` | Only used with `DESC` + threaded display. `1` = reverse parents but keep each reply chain chronological; `0` = reverse children too. |
| Order by "Authored On" field | `created_order` | `1` / `0` | `0` | For flat lists: sort by the comment `created` timestamp instead of `cid`. |

The `children_natural_order` checkbox only shows (JS `#states`) when order is `DESC` **and** the
field's default display mode is threaded; `created_order` only shows when the display is **not**
threaded.

## Where it is stored

```yaml
# field.field.<entity_type>.<bundle>.<comment_field>  (e.g. field.field.node.article.comment)
third_party_settings:
  comments_order:
    order: DESC
    children_natural_order: 1
    created_order: 0
```

The extra form fields are added by `comments_order_form_alter()` only when
`$field->getType() === 'comment'`, and saved by the entity builder
`_comments_order_field_config_edit_form_builder()`.

## Via the UI

1. Go to the bundle's *Manage fields* (e.g. `/admin/structure/types/manage/article/fields`).
2. Edit the **comment** field (default machine name `comment`).
3. Set **Comments order** to *Newest first (descending order)*.
4. Optionally untick **Natural order for children** (threaded) to also reverse replies, or tick
   **Order by "Authored On" field"** (flat) to sort by authored date.
5. **Save settings**.

## Via drush php:eval (scriptable)

```php
use Drupal\field\Entity\FieldConfig;
$field = FieldConfig::loadByName('node', 'article', 'comment');   // a comment-type field
$field->setThirdPartySetting('comments_order', 'order', 'DESC');
$field->setThirdPartySetting('comments_order', 'children_natural_order', 0); // reverse children too
$field->setThirdPartySetting('comments_order', 'created_order', 0);
$field->save();
```

To restore defaults set `order` back to `ASC` (and/or unset the third-party settings).

## Read it back

```bash
drush cget field.field.node.article.comment third_party_settings.comments_order
```

Or in PHP: `FieldConfig::loadByName('node','article','comment')->getThirdPartySetting('comments_order','order','ASC')`.

## Config schema

`config/schema/comments_order.schema.yml` defines
`field.field.*.*.*.third_party.comments_order` with `order` (label), `children_natural_order`
(integer), `created_order` (integer).
