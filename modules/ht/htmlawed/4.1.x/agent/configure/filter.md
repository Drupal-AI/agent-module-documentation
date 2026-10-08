<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the htmLawed filter

htmLawed has **no dedicated settings page** (`configure` is null). It is a filter you enable and
tune on each text format at `admin/config/content/formats` (requires the core `administer filters`
permission). More than one format may use it, each with its own settings.

## Where settings are stored

Per text format, in the format config entity:

```
filter.format.<format_id>:
  filters:
    filter_htmlawed:
      id: filter_htmlawed
      status: true
      weight: 50            # usually run LAST; raise weight if other filters emit markup
      settings:
        config:   "<comma-separated quoted key => value pairs>"   # htmLawed $config
        spec:     "<optional htmLawed $spec string>"              # per-element attribute rules
        help:     "<short tip shown to authors>"
        helplong: "<long tip shown to authors>"
```

Schema: `config/schema/htmlawed.schema.yml` (`filter_settings.filter_htmlawed`, all four values are strings).

## The four settings

| Setting | Meaning |
|---|---|
| `config` | The htmLawed `$config` array body, written as comma-separated **quoted** key/value pairs (interpreted as PHP array elements). Controls what is allowed/denied. |
| `spec` | Optional htmLawed `$spec` string: per-element attribute-value rules, e.g. `table=border:0-2; img=height:100-300`. |
| `help` | Short filter tip (plain text) shown under the editor. |
| `helplong` | Long filter tip; falls back to a generic message if empty. |

## Default `config`

```
'safe' => 1, 'elements' => 'a, em, strong, cite, code, ol, ul, li, dl, dt, dd, br, p', 'deny_attribute' => 'id, style'
```

Allows only those tags, denies `id`/`style`, and applies htmLawed's `safe` anti-XSS ruleset.

## Common `config` keys (htmLawed library)

| Key | Effect |
|---|---|
| `safe => 1` | Enable htmLawed's built-in anti-XSS behaviour (drops scripts, event attributes, etc.). |
| `elements => 'a, p, ...'` | Whitelist of allowed tags (supports `* -script` style syntax). |
| `deny_attribute => 'id, style'` | Attributes to strip globally. |
| `schemes => 'href: http, https, mailto; src: http, https'` | Restrict URL protocols per attribute. |
| `comment => 2` | Preserve HTML comments (needed for the Drupal `<!--break-->` teaser marker). |
| `save_php => 1` | Module pseudo-param: protect `<?php … ?>` blocks from being altered (not executed). |
| `keep_bad => 1..6` | How to handle disallowed tags (strip vs. neutralise). |
| `tidy => 1` | Pretty-print / indent the output. |

Full reference: the bundled `htmLawed/htmLawed_README.htm` (also linked from `admin/help/htmlawed`).

## Set it with Drush (example)

```php
// drush php:eval
$f = \Drupal::configFactory()->getEditable('filter.format.basic_html');
$f->set('filters.filter_htmlawed.status', TRUE);
$f->set('filters.filter_htmlawed.settings.config',
  "'safe' => 1, 'elements' => 'a, em, strong, p', 'deny_attribute' => 'id, style, class'");
$f->save();
```

`config` is evaluated as PHP array syntax when the filter runs. htmLawed does **not** create links from URLs or convert newlines — combine
with other filters and generally give htmLawed the highest weight so it validates their output.
