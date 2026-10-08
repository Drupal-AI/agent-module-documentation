# Configure the Advanced Text formatter

There is **no global settings form** — the module's `configure` route is null and it
defines no permissions, services, or Drush commands. You configure it per field on the
entity's **Manage display** page (`/admin/structure/types/manage/<bundle>/display` for
nodes), or in a View's field settings. Set the field's **Format** to **Advanced Text**,
then click the gear to edit its settings. All settings persist in the
`entity_view_display` config entity, under `content.<field>.settings`.

## Settings (keys, defaults, meaning)

From `AdvancedTextFormatter::defaultSettings()`:

| Key | Default | Meaning |
|---|---|---|
| `trim_length` | `600` | Max characters; `0` disables trimming. Uses `advanced_text_formatter_trim_text()`. |
| `ellipsis` | `1` | Append `...` when the text was trimmed (only applies if `trim_length > 0`). |
| `word_boundary` | `1` | Trim only on a word boundary (only if `trim_length > 0`). |
| `use_summary` | `0` | If the item has a non-empty `summary`, render it instead of `value`. |
| `token_replace` | `0` | Run `\Drupal::token()->replace()` over the value before filtering. |
| `link_to_entity` | `false` | Wrap the rendered value in a link to the host entity (revision → canonical). |
| `filter` | `'input'` | Markup handling — one of `none`, `input`, `limit_html`, `drupal`, `php`. |
| `format` | `'plain_text'` | Named text format id used **only** when `filter` = `drupal`. |
| `allowed_html` | `<a> <b> <br> <dd> <dl> <dt> <em> <i> <li> <ol> <p> <strong> <u> <ul>` | Allowed tags used **only** when `filter` = `limit_html` (also `php`). |
| `autop` | `0` | Convert line breaks to `<br>`/`<p>` — used **only** when `filter` = `limit_html`. |

### `filter` values (constants on the plugin class)

- `none` (`FORMAT_NONE`) — output the raw value, no filtering.
- `input` (`FORMAT_INPUT`) — run the item through **its own** selected text format via `check_markup($output, $item->format, …)`.
- `limit_html` (`FORMAT_LIMIT_HTML`) — `Xss::filter()` to the `allowed_html` tag list; empty list removes all tags; optionally `autop`.
- `drupal` (`FORMAT_DRUPAL`) — run through the specific named text format in `format` via `check_markup($output, $format, …)`.
- `php` (`FORMAT_PHP`) — **deprecated**; behaves like `limit_html` and adds a warning message.

Order of operations in `viewElements()`: pick summary-or-value → token replace → filter →
trim → optional link.

## Set it live with drush (no UI)

The formatter is a display **component**; write it into the `entity_view_display`:

```php
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("body", [
    "type" => "advanced_text",
    "label" => "hidden",
    "settings" => [
      "trim_length" => 300,
      "ellipsis" => 1,
      "word_boundary" => 1,
      "use_summary" => 0,
      "token_replace" => 0,
      "filter" => "limit_html",
      "format" => "plain_text",
      "allowed_html" => "<a> <b> <em> <strong> <p>",
      "autop" => 0,
      "link_to_entity" => 0,
    ],
    "weight" => 1,
    "region" => "content",
  ])->save();
'
```

Read the current settings back:

```php
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  print_r($vd->getComponent("body"));
'
```

Restore the core default text formatter (baseline for `text_long` body):

```php
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("body", ["type" => "text_default", "label" => "hidden", "settings" => [], "third_party_settings" => [], "weight" => 1, "region" => "content"])->save();
'
```

Any keys you omit from `settings` fall back to `defaultSettings()`. There is no config
schema shipped by the module (`provides_config_schema` is false); settings validate
through core's generic `field.formatter.settings.*` fallback.
