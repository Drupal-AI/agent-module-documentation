# Configure — the formatters

Pick a formatter on **Manage display** for a field (or in a Views field's format). Each stores its own
settings in the display config. Source: `src/Plugin/Field/FieldFormatter/*.php`. All ids are prefixed
`formatter_suite_`.

## Number formatters (field types: `integer`, `decimal`, `float`)

| id | Label | What it adds |
|---|---|---|
| `general_number` | General number | Notation styles (basic/general/percentage/scientific), decimals, thousands + decimal separators, zero-pad width, positive/negative styles |
| `general_number_with_bar_indicator` | Number with bar indicator | Renders value as a horizontal bar/gauge between a configured min and max |
| `general_number_with_min_max` | Number with min/max | Shows the value alongside its configured min and max bounds |
| `number_with_bytes` | Bytes with KB/MB/GB suffix | Converts an integer byte count to a human size (KB/MB/GB/TB); see `Utilities::formatBytes` |

## Date / time / timestamp formatters

| id | Label | Field types |
|---|---|---|
| `datetime_list` | Date & time list | `datetime` — multi-value list with a named format |
| `datetime_custom_list` | Custom date & time list | `datetime` — list with a PHP custom format string |
| `datetime_time_ago_list` | Time ago list (datetime) | `datetime` — relative "time ago" per value |
| `timestamp_list` | Timestamp list | `timestamp`, `created`, `changed` |
| `timestamp_time_ago_list` | Time ago list (timestamp) | `timestamp`, `created`, `changed` |

## Link / reference / email / file formatters

| id | Label | Field type(s) | Key settings |
|---|---|---|---|
| `general_link` | General link | `link` | Title style (link title / URL text / manual `titleCustomText`), custom classes, `rel`/`target`, list separator |
| `general_file_link` | General file link | `file` | Download link label, classes, target |
| `general_email` | General Email address | `email` | `mailto:` link with custom link text |
| `general_entity_reference` | General entity reference | `entity_reference` | Render as link / plain text, custom title, list separator |
| `general_user_reference` | General user reference | `entity_reference` (user) | User name/link display, separators |
| `entity_reference_render_list` | Rendered entity list | `entity_reference` | Renders each referenced entity in a view mode, as a list |

## Image / text formatters

| id | Label | Field type(s) | Key settings |
|---|---|---|---|
| `general_image` | General image | `image` | Wrap image in a link to file / entity / custom URL, URL attributes |
| `image_embed_data` | Image with embedded data URL | `image` | Inlines the image as a base64 `data:` URI |
| `text_with_expand_collapse_buttons` | Text with expand/collapse buttons | `text`, `text_long`, `text_with_summary`, `string_long` | Truncates long text with JS show/hide buttons; custom expand/collapse labels |

## Notes

- Custom title text (`titleCustomText`), list separators, and button labels are sanitized with
  `Xss::filterAdmin()` and wrapped in `FormattableMarkup` before output.
- `text_with_expand_collapse_buttons` attaches the
  `formatter_suite/formatter_suite.text_with_expand_collapse_buttons` JS library.
- No global config: to change behavior, edit the field's *Manage display* settings (or export the
  `core.entity_view_display.*` config).
