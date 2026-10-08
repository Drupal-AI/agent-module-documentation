<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tamper Convert Encoding (feeds_tamper_convert_encoding) — agent index

One **Tamper plugin**, id **`convert_encoding`**, that converts a value between character encodings
during an import. Class `Drupal\feeds_tamper_convert_encoding\Plugin\Tamper\ConvertEncoding` extends
Tamper's `TamperBase`. Depends on `tamper` and core `system (>=8.5.0)`. Core requirement
`^8 || ^9 || ^10 || ^11`. No routes, no permissions, no config schema, no drush.

Key facts:
- **Whole module** = `src/Plugin/Tamper/ConvertEncoding.php` plus `.info.yml`, `README.txt`,
  `LICENSE.txt` (four files). It does **not** define a plugin type — it *implements* the `Tamper`
  plugin type provided by the `tamper` module.
- **Despite the project name it depends on Tamper, not Feeds.** It works anywhere Tamper plugins are
  consumed; a Feeds importer is the common case but not required.
- The transform calls **`iconv($input_encoding, $output_encoding . $mode, $data)`** — *not*
  `mb_convert_encoding`, despite the class doc comment. `mb_list_encodings()` is used only to build
  the two encoding select fields, so an encoding offered in the form may not be a valid `iconv` name.
- Convert **at import**. Once mis-decoded text is stored, recovering the original bytes is guesswork
  and sometimes impossible — the wrong-direction conversion is lossy.
- Configured **per field** inside the Tamper plugin chain, so different fields in one importer can use
  different source encodings.

## What you'd do → where

- **Understand the `convert_encoding` plugin — its settings, defaults, form, and how it transforms a
  value** → [plugins/feeds_tamper_convert_encoding.md](plugins/feeds_tamper_convert_encoding.md)

## Key facts (real names)

- Plugin: id `convert_encoding`, label "Convert text encoding", description "Converts string from one
  encoding to another.", category `Text` (annotation `@Tamper`).
- Settings keys: `input_encoding` (default `''`), `output_encoding` (default `UTF-8`),
  `mode` (default `//IGNORE`). Constants `DEFAULT_OUTPUT_ENCODING = 'UTF-8'`,
  `DEFAULT_MODE = '//IGNORE'`.
- `mode` options: `''` (Do nothing — generates a PHP notice), `//TRANSLIT` (transliterate unknown
  characters), `//IGNORE` (ignore unknown characters).
- `tamper($data, ...)` throws `Drupal\tamper\Exception\TamperException('Input should be a string.')`
  for non-string input; otherwise returns `iconv(...)`.
