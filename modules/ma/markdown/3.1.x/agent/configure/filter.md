<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable & configure the Markdown filter

## Add the filter to a text format

The `markdown` filter renders Markdown to HTML on output. Enable it on a text format at
*Configuration → Content authoring → Text formats and editors* → edit a format → tick
**Markdown**. It is a MARKUP_LANGUAGE filter (weight -15).

Config lives on the `filter_format` entity under `filters.markdown`:

```yaml
# filter.format.<format>
filters:
  markdown:
    status: true
    settings:
      id: commonmark          # the parser plugin id
      override: false
      render_strategy: { type: filter_output, custom_allowed_html: null, plugins: [] }
```

Create/enable via API:

```php
use Drupal\filter\Entity\FilterFormat;
FilterFormat::create([
  'format' => 'markdown', 'name' => 'Markdown',
  'filters' => ['markdown' => ['status' => 1, 'settings' => ['id' => 'commonmark']]],
])->save();
```

Read back: `drush cget filter.format.markdown filters.markdown` (look at `status` and
`settings.id`).

## Choose / configure a parser

- The selected parser is `filters.markdown.settings.id` (e.g. `commonmark`, `commonmark-gfm`,
  `parsedown`, `parsedown-extra`, `php-markdown`, `php-markdown-extra`).
- Parser libraries are **external Composer packages** (e.g. `composer require
  league/commonmark`). The module detects installed ones; an unavailable parser resolves to
  `_missing_parser`. Check availability: the parser's `isInstalled()`.
- Per-parser settings, enabled extensions and the render strategy (which HTML is allowed) are
  edited under the admin overview.

## Admin UI & permission

| Route | Path | Purpose |
|---|---|---|
| `markdown.overview` (the `configure` route) | `/admin/config/content/markdown` | Lists parsers, their install status and global config. |
| `markdown.parser.edit` | `/admin/config/content/markdown/{parser}` | Configure one parser (settings, extensions, render strategy). |
| `markdown.parser.operation` / `.confirm_operation` | `.../{parser}/operation/{operation}` | Install/enable operations on a parser. |

All require the permission **`administer markdown`** (title "Administer markdown
configuration"). A `markdown:parser` param converter resolves the `{parser}` slug to a parser
plugin.

## Render strategy (HTML safety)

Each parser has a **render strategy** controlling output HTML: `filter_output` (let the text
format's other filters / `custom_allowed_html` restrict HTML — the default), plus stricter
options. The `allowed_html` plugin type (see plugins/plugins.md) declares which tags a
parser/module/theme contributes.
