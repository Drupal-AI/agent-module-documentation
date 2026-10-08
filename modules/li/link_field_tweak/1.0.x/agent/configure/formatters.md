# Field formatters

Two formatters for the `link` field type, both extending core's `LinkFormatter`. Select them on
*Manage display* for a link field; settings persist in the `entity_view_display` component
`settings`.

## `link_text` — "Link text"

`Drupal\link_field_tweak\Plugin\Field\FieldFormatter\LinkTextFormatter`. Renders the link with a
**fixed** anchor text that **overrides** the field's own link title whenever it is non-empty.

- Setting `link_text` (string, schema `field.formatter.settings.link_text` extends
  `field.formatter.settings.link`). Description: "Static link text, will override field link text
  if any."
- `trim_length` is force-disabled/empty.
- Output safety: the fixed text is passed through `Xss::filter()` before replacing `#title`.

## `link_text_empty` — "Link text replacing empty text"

`EmptyLinkTextFormatter`, same `link_text` setting (schema
`field.formatter.settings.link_text_empty`). Uses the fixed text **only when the link's own title
is empty**, otherwise keeps the stored title.

## Set with drush

```bash
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_my_link", [
    "type" => "link_text", "label" => "hidden", "region" => "content",
    "settings" => ["link_text" => "Read more"],
  ])->save();
'
```
