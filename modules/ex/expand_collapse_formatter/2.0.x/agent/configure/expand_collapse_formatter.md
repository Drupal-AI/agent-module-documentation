<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Expand collapse formatter

No admin page (`configure` is null). Enable it per field on the entity's **Manage display**
UI: **Structure → (entity type) → Manage display** → set a long-text field's Format to
**Expand collapse formatter**, click the gear, adjust settings, **Update**, then **Save**.

Applies only to field types `text_long`, `string_long`, `text_with_summary`,
`text_long_with_summary`. Settings live in the display config entity
(`core.entity_view_display.<entity>.<bundle>.<mode>`) under the field's component:
`settings` keyed by `field.formatter.settings.expand_collapse_formatter` (schema in
`config/schema/expand_collapse_formatter.schema.yml`). Export with `drush config:export`.

## Settings

| Key | Type | Default | Meaning |
|---|---|---|---|
| `trim_length` | integer | `300` | Character count the field is trimmed to when collapsed. Required, min 1. The toggle link only appears when the field's plain-text length exceeds this. |
| `default_state` | string | `collapsed` | Initial state: `collapsed` or `expanded`. |
| `link_text_open` | string | `Show more` | Toggle label shown while collapsed (click to expand). Optional; passed through `Drupal.t()`. |
| `link_text_close` | string | `Show less` | Toggle label shown while expanded (click to collapse). Optional. |
| `link_class_open` | string | `ecf-open` | CSS class added to the toggle link while collapsed (link also always carries `ec-toggle-link`). |
| `link_class_close` | string | `ecf-close` | CSS class added to the toggle link while expanded. |

## Set it via drush (no UI)

```bash
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("body", [
    "type" => "expand_collapse_formatter",
    "label" => "hidden",
    "region" => "content",
    "settings" => [
      "trim_length" => 200,
      "default_state" => "collapsed",
      "link_text_open" => "Read more",
      "link_text_close" => "Read less",
      "link_class_open" => "ecf-open",
      "link_class_close" => "ecf-close",
    ],
  ])->save();
'
```

## Notes

- Only the keys you pass into `settings` override defaults; omitted keys fall back to
  `defaultSettings()` above.
- Trimming happens **client-side** at a word boundary with a trailing ` ...`; the full HTML
  is still delivered to the page, so collapsed content stays crawlable.
- The settings summary on Manage display lists all six values (trim length, default state,
  and the four link text/class strings).
