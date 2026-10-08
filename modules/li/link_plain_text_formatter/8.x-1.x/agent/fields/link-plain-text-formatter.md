<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field formatter: link_plain_text_formatter

Class: `Drupal\link_plain_text_formatter\Plugin\Field\FieldFormatter\LinkPlainTextFormatter`
(extends core `Drupal\Core\Field\FormatterBase`).

| Property | Value |
| --- | --- |
| Plugin id | `link_plain_text_formatter` |
| Label | "Plain text" |
| Applies to field type | `link` only |
| Base class | `Drupal\Core\Field\FormatterBase` |
| Formatter settings | none (no `defaultSettings()`, `settingsForm()`, or `settingsSummary()` override) |
| Config schema | none provided by this module |

This is a plugin *instance* of core's field-formatter plugin type — the module does **not**
define a new plugin type or manager. It applies only to fields of type `link` (provided by core's
`link` module, which is a hard dependency).

## What it renders

Core's built-in link formatters ("Link", "Link (separate title and URL)") always emit an `<a>`
anchor element. This formatter instead emits the link as plain, non-clickable text.

`viewElements(FieldItemListInterface $items, $langcode)` iterates each delta and builds
`$element[$delta] = ['#markup' => $this->itemText($item)]`.

`itemText(LinkItemInterface $item)` (LinkPlainTextFormatter.php:51) decides the string:

- If `$item->title` is **empty** → take `$item->getUrl()` (falling back to the `<none>` route via
  `Url::fromRoute('<none>')` when there is no URL) and use `$url->toString()`.
- Otherwise → use `$item->title` (the link's title text).

The chosen string is passed through `Drupal\Component\Utility\Html::escape()` (htmlspecialchars)
before being returned, so the emitted `#markup` is HTML-safe escaped text rather than markup.

Note the asymmetry: when a title exists you get **only the title** (never the URL); when no title
exists you get **only the URL string**. There is no setting to force one or the other, and no
option to render both.

## Enable it on a field (UI)

1. Create or reuse a **Link** field on any entity/bundle (e.g. a node type).
2. Go to that bundle's **Manage display** (`/admin/structure/types/manage/<bundle>/display`).
3. Set the Link field's **Format** to **"Plain text"**.
4. There are no formatter settings to configure — the format has no gear/settings summary.

## Configure it in code / config export

The formatter appears in a view display's `content.<field>.type` as `link_plain_text_formatter`
with an empty `settings: {}`. Example fragment of a
`core.entity_view_display.node.<bundle>.default.yml`:

```yaml
content:
  field_website:
    type: link_plain_text_formatter
    label: above
    settings: {}
    third_party_settings: {}
    weight: 0
    region: content
```
