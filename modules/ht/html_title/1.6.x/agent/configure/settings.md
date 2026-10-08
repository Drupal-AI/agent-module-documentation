<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure HTML Title

## Allowed-tags setting (the only setting)

- Config object: **`html_title.settings`**, single key **`allow_html_tags`** — a
  space-separated string of HTML start-tags, e.g. `<br> <sub> <sup>` (the shipped default).
- Only tags listed here are permitted; the module parses them with
  `preg_match_all('/<(.+?)\/?>/', ...)` and passes the tag names to `Xss::filter()`. Any tag
  not listed is stripped from displayed titles.
- Intended/supported inline tags: `em, sub, sup, b, i, strong, cite, code, bdi, wbr`.
  (You *can* list others, but block/interactive tags defeat the purpose and may be re-stripped.)

### UI
- Route `html_title.settings` → **`/admin/config/user-interface/html_title`**
  (menu: *Configuration → User interface → Html title*).
- Form `Drupal\html_title\Form\HtmlTitleSettingConfigForm`, one textfield "Allow html tags"
  (maxlength 64). Permission required: **`administer html title settings`**
  (`restrict access: true`).

### Drush / config
```bash
# read current allowlist
drush config:get html_title.settings allow_html_tags
# allow italics + superscript + subscript
drush config:set html_title.settings allow_html_tags '<em> <sup> <sub>' -y
```
Storing the marked-up text happens in the ordinary title field — no special widget. The
allowlist governs what survives at render time.

## `html_title` field formatter

- Formatter id **`html_title`**, label **"HTML-title text"**, for **`string`** field types
  (`Drupal\html_title\Plugin\Field\FieldFormatter\HtmlTitleFormatter`, extends core
  `StringFormatter`). Its `viewValue()` returns
  `['#markup' => $this->htmlTitleFilter->decodeToMarkup($item->value)]`.
- Use it on a plain-text (`string`) field's **Manage display** to render that field's value
  through the same allowlist filter. Set via config on the entity view display component:
  `content.<field>.type: html_title`.

## Views node-title handler

- `hook_views_data_alter()` swaps `node_field_data.title` field id to **`node_html_title`**
  (`Drupal\html_title\Plugin\views\field\NodeHtmlTitle`, extends `EntityField`). Existing and
  new Views showing the node **Title** field render the decoded markup automatically; the
  handler honours the field's *Link to entity* setting. No per-view config change is required.
- Provider is rewritten to `node` so uninstalling the module leaves the views working.

## Notes
- Titles are filtered at **display** time only; the stored `node.title` value keeps whatever
  the editor typed. Nothing is written to the field schema.
- RSS titles are deliberately stripped of tags (`html_title_preprocess_views_view_row_rss`).
