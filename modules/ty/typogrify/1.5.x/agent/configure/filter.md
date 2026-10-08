<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable & configure the Typogrify filter

Typogrify is a **text-format filter**, so it is configured per text format — there is no global
settings page (`configure: null`).

## Enable in the UI

1. *Configuration → Content authoring → Text formats and editors*
   (`/admin/config/content/formats`).
2. Edit a format (e.g. Full HTML) → tick **Typogrify** under *Enabled filters*.
3. Set the per-filter options in the **Filter settings** section, Save.
4. Filter order matters: Typogrify has plugin weight 10; adjust order if another filter should
   run before/after it.

## Enable / configure with PHP or config

```php
use Drupal\filter\Entity\FilterFormat;
$format = FilterFormat::load('full_html');
$format->setFilterConfig('typogrify', [
  'status'   => TRUE,
  'weight'   => 10,
  'settings' => [
    'smartypants_enabled' => 1,
    'smartypants_hyphens' => 3,   // 1: -- em; 3: -- em / --- en; 2: --- em / -- en
    'widont_enabled'      => 1,
    'wrap_caps'           => 1,
    'space_hyphens'       => 1,    // stand-alone " - " -> em dash
  ],
])->save();
```

Stored at `filter.format.<format>` → `filters.typogrify.settings`.

## Settings keys (defaults from the plugin)

| Key | Default | Effect |
|---|---|---|
| `smartypants_enabled` | 1 | Smart quotes & dashes (SmartyPants) |
| `smartypants_hyphens` | 3 | Dash mode: 1=`--`→em; 3=`--`→em,`---`→en; 2=`---`→em,`--`→en |
| `space_hyphens` | 0 | Stand-alone ` - ` → ` — ` (em dash) |
| `wrap_ampersand` | 1 | Wrap `&` in `<span class="amp">` |
| `widont_enabled` | 1 | Insert nbsp to prevent single-word widows |
| `space_to_nbsp` | 1 | nbsp before `! ? : ;` (French spacing) |
| `hyphenate_shy` | 0 | `=` → soft hyphen (`&shy;`) break points |
| `wrap_abbr` | 0 | Wrap abbreviations, thin space after dots (0/4/1/2/3) |
| `wrap_caps` | 1 | Wrap runs of capitals in `<span class="caps">` |
| `wrap_initial_quotes` | 1 | Wrap leading quotes (`quo`/`dquo`) for hanging |
| `wrap_numbers` | 0 | Thin-space digit grouping in large numbers (0/1/2/3/4) |
| `ligatures` | `a:0:{}` | Serialized map of ASCII→Unicode ligatures to convert |
| `arrows` | `a:0:{}` | Serialized map of ASCII→Unicode arrows |
| `fractions` | `a:0:{}` | Serialized map of ASCII→Unicode fractions |
| `quotes` | `a:0:{}` | Serialized map of ASCII→Unicode quote chars |

The four map settings (`ligatures`/`arrows`/`fractions`/`quotes`) are **serialized** on save
(`settingsSerialize`) and unserialized on use; set them as PHP arrays via
`setFilterConfig()`/`setConfiguration()` and the filter serializes them for you.

## Output / styling

`process()` returns a `FilterProcessResult` that attaches the **`typogrify/typogrify`** CSS
library (styles `.amp`, `.caps`, `.quo`/`.dquo`, `.number`, `.abbr`). The filter type is
`TYPE_TRANSFORM_IRREVERSIBLE`. `tips()` renders a per-format summary of active refinements.
