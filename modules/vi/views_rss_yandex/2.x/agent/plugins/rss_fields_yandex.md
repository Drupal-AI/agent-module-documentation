<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views style plugin: `rss_fields_yandex` (RssFieldsYandex)

File: `src/Plugin/views/style/RssFieldsYandex.php`. Class `RssFieldsYandex` **extends**
`Drupal\views_rss\Plugin\views\style\RssFields` (the views_rss "RSS Feed - Fields" style).

## Attribute / registration

```
#[ViewsStyle(
  id: "rss_fields_yandex",
  title: "Yandex RSS Feed - Fields",
  help: "Generates an RSS feed from fields in a view.",
  theme: "views_view_row_rss",
  display_types: ["feed"],
)]
```

- Selectable as a **Format/Style** on any View **Feed** display. It is a thin subclass: all the
  heavy lifting (row rendering, per-element field mapping, channel build) is inherited from
  views_rss's `RssFields` / `RssFields` row plugin.
- `create()` reconstructs the parent with the two services the parent needs —
  `module_handler` and `config.factory` — so the subclass keeps working under DI.

## What it adds over the parent

- **`defineOptions()`** adds one option:
  `feed_settings['contains']['yandex_turbo'] = ['default' => 0]`.
- **`buildOptionsForm()`** adds one form control under the parent's *Feed settings*:
  `feed_settings['yandex_turbo']`, a `#type => checkbox`, `#title` *"Enable yandex turbo for this
  feed"*, `#weight => 0`, default from `!empty($this->options['feed_settings']['yandex_turbo'])`.

That is the entire plugin — no query changes, no access changes. The Yandex **namespaces and item
elements** themselves are provided by the module's `hook_views_rss_*` implementations (see
[../api/hooks.md](../api/hooks.md)) and are available to **any** views_rss "fields" feed once the
module is enabled; you do not have to pick this style to get `yandex:full-text` etc. The style's
only extra job is the **Turbo** toggle, which drives the template/preprocess Turbo branch.

## Turbo behaviour (when the checkbox is on, i.e. `yandex_turbo === 1`)

- `views_rss_yandex_preprocess_views_view_rss()` adds channel namespace
  `xmlns:turbo="http://turbo.yandex.ru"`.
- `views_rss_yandex_preprocess_views_view_row_rss()` sets `yandex_turbo_enabled = TRUE` on the row.
- The overridden row template then renders `<item turbo="true">`, a
  `<turbo:extendedHtml>true</turbo:extendedHtml>` flag, and wraps the **`yandex:full-text`** value
  in a `<turbo:content><![CDATA[ … ]]></turbo:content>` block instead of a plain `yandex:full-text`
  element. Note the comparison is strict `=== 1`, so the option must be stored as integer `1`.
