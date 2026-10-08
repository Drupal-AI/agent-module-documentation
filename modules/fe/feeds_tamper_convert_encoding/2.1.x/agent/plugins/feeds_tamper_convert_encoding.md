<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `convert_encoding` Tamper plugin

This module implements a single plugin of the **`Tamper`** plugin type (defined by the `tamper`
module — manager `plugin.manager.tamper`, discovery dir `src/Plugin/Tamper/`, base `TamperBase`).
It defines **no** plugin type of its own.

- Class: `Drupal\feeds_tamper_convert_encoding\Plugin\Tamper\ConvertEncoding` extends
  `Drupal\tamper\TamperBase`.
- Annotation `@Tamper`: `id = "convert_encoding"`, `label = "Convert text encoding"`,
  `description = "Converts string from one encoding to another."`, `category = "Text"`.
- No `create()`/DI — pure config-and-transform plugin.

## Settings

| Key | Form element | Default | Notes |
| --- | --- | --- | --- |
| `input_encoding` | required `select` | `''` | Options = `mb_list_encodings()`, `natcasesort`-ed, with a leading `'' => '-- Select encoding --'`. The empty default is invalid for a real conversion, so it must be set. |
| `output_encoding` | required `select` | `UTF-8` (`DEFAULT_OUTPUT_ENCODING`) | Same option list as input. |
| `mode` | required `select` | `//IGNORE` (`DEFAULT_MODE`) | How to handle characters not representable in the target — see below. |

`mode` options (`buildConfigurationForm`):

- `''` — "Do nothing (will generate PHP notice)". With this mode `iconv` returns `FALSE` on an
  untranslatable character and emits an E_NOTICE.
- `//TRANSLIT` — "Transliterate unknown characters" (approximate with similar characters).
- `//IGNORE` — "Ignore unknown characters" (drop them). This is the shipped default.

`defaultConfiguration()` merges these onto `parent::defaultConfiguration()`.
`submitConfigurationForm()` writes the three values back via `setConfiguration()`.

## How it transforms a value

```php
public function tamper($data, TamperableItemInterface $item = NULL) {
  if (!is_string($data)) {
    throw new TamperException('Input should be a string.');
  }
  $input_encoding  = $this->getSetting('input_encoding');
  $output_encoding = $this->getSetting('output_encoding');
  $mode            = $this->getSetting('mode');
  $data = iconv($input_encoding, $output_encoding . $mode, $data);
  return $data;
}
```

- **Non-string input** (array, int, object from an upstream Tamper step) → throws
  `Drupal\tamper\Exception\TamperException('Input should be a string.')`. It does not iterate lists;
  place it after any explode/split so it receives scalars, or let Tamper apply it per multi-value item.
- The **mode string is concatenated onto the output encoding** (`$output_encoding . $mode`), which is
  exactly `iconv`'s `//TRANSLIT` / `//IGNORE` suffix convention.
- **`iconv`, not `mb_convert_encoding`** — the class comment says the latter but the code uses the
  former. Consequence: names from `mb_list_encodings()` (e.g. `HTML-ENTITIES`, `UUENCODE`, `BASE64`)
  are offered in the select but are **not** valid `iconv` charsets and will fail at runtime. Stick to
  standard charset names (`UTF-8`, `ISO-8859-1`, `Windows-1252`, `ASCII`, …).
- On failure `iconv` returns `FALSE`; the plugin returns whatever `iconv` returns, so a failed
  conversion can propagate `FALSE` (or a PHP notice under mode `''`) downstream.

## Using it

There is nothing to configure at the module level. In a Feeds importer (or any Tamper UI), add the
**"Convert text encoding"** Tamper to a target field, pick the source **Input encoding**, the target
**Output encoding** (usually `UTF-8`), and a **Mode**. Add one instance per field that needs it;
different fields may use different source encodings.
