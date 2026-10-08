# Assign & configure the Colorbox formatters

No admin settings page. You pick a Colorbox formatter on a field's *Manage display* row; the
settings are stored in the `entity_view_display` config
(`core.entity_view_display.<entity>.<bundle>.<view_mode>` →
`content.<field>.type` + `content.<field>.settings`). All three show the label "Colorbox FF".

## The three formatters

| Formatter id | Field types | Notes |
|---|---|---|
| `colorbox_field_formatter` | `string`, `computed` | Base formatter. Value becomes the link text. |
| `colorbox_field_formatter_image` | `image` | Extends base; adds `image_style`; image is the clickable thumbnail. |
| `colorbox_field_formatter_entityreference` | `entity_reference` | Extends base; `link_type`/`link` hidden (always links to referenced content). |

## Settings keys (component `settings`)

| Key | Default | Applies | Meaning |
|---|---|---|---|
| `style` | `default` | all | `default`, or `colorbox-inline` / `colorbox-node` when those Colorbox submodules are enabled. |
| `link_type` | `content` | base/string | `content` = link to entity canonical URL; `manual` = use `link`. |
| `link` | `''` | base/string | Manual URI (only when `link_type=manual`). Run through Token when the Token module is enabled. |
| `width` | `500` | all | Colorbox popup width (added as `?width=`). |
| `height` | `500` | all | Colorbox popup height (added as `?height=`). |
| `iframe` | `0` | all | Load the target in an iframe (`?iframe=true`). |
| `inline_selector` | `''` | all | CSS selector used when `style=colorbox-inline` (sets `data-colorbox-inline`). |
| `anchor` | `''` | all | Fragment appended to the URL (`#anchor`). |
| `class` | `''` | all | Extra CSS classes added to the link (space separated). |
| `rel` | `''` | all | Colorbox group id so the lightbox cycles through matching links (galleries). |
| `image_style` | `original` | image only | Any image style machine name, or `hide` to suppress the image. |

## Set it with drush

Example — make an Article string field `field_more` open its node in a Colorbox at 800×600:

```bash
drush php:eval '
  $d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $d->setComponent("field_more", [
    "type" => "colorbox_field_formatter",
    "settings" => ["style"=>"default","link_type"=>"content","width"=>"800","height"=>"600","iframe"=>0],
    "region" => "content", "weight" => 10,
  ])->save();
'
drush cget core.entity_view_display.node.article.default content.field_more
```

## Behavior notes
- Each item is rendered as `<a class="colorbox <style> [extra classes]" ...>` via the Link API;
  width/height go in the query string, `rel` groups items for gallery cycling.
- `link_type=content` uses `$entity->toUrl()`; `manual` uses `Url::fromUserInput()` after token
  replacement (tokens only expanded when the Token module is enabled).
- The image formatter renders the image (at `image_style`) as the link text; `hide` shows no image.
- Colorbox JS/CSS is attached automatically through the `colorbox.attachment` service when applicable.
- Requires the Colorbox module; `colorbox-inline` / `colorbox-node` styles require those submodules.
