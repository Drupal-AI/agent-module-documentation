<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Automator Extractor (ai_automator_extractor) — agent index

A set of **AI Automators field-processor plugins** that extract values from a source field with plain
**PHP/regular expressions — no AI/LLM call**. Package `AI Tools`. Core `^10.3 || ^11`. License
GPL-2.0-or-later. Project version 1.0.0-beta2.

Depends only on the AI module's **`ai_automators`** sub-module (composer `drupal/ai`). No routes,
permissions, config schema, or Drush of its own. Supersedes the older AI Interpolator Extractor on D10.3+.

- **All seven extractor plugins, their fields, options and store behaviour** →
  [plugins/extractors.md](plugins/extractors.md)

## What it actually is

Seven `#[AiAutomatorType]` plugins in `src/Plugin/AiAutomatorType/`, each extending
`Drupal\ai_automators\PluginBaseClasses\ExternalBase`, `needsPrompt()` = FALSE:

| Plugin id | Class | `field_rule` (target) | Does |
|---|---|---|---|
| `ai_automator_extractor_link` | `LinkExtractor` | `link` | regex all URLs out of text; skips disallowed extensions |
| `ai_automator_extractor_email` | `EmailExtractor` | `email` | regex all e-mail addresses out of text |
| `ai_automator_extractor_image` | `ImageExtractor` | `image` (target `file`) | regex image URLs, then **downloads** each and saves as image |
| `ai_automator_extractor_file` | `FileExtractor` | `file` (target `file`) | regex file URLs by allowed extension, then **downloads** each |
| `ai_automator_extractor_regex_text` | `TextRegExExtractor` | `text` | run a configured regex, store `matches[0]` |
| `ai_automator_extractor_regex_string` | `StringRegExExtractor` | `string` | run a configured regex, store `matches[1]` (capture group) |
| `ai_automator_extractor_regex_counter` | `RegExCounter` | `integer` | store the **count** of regex matches |

## Mechanism (from source)

- Each plugin's `generate()` loops the source field (`$automatorConfig['base_field']`) and runs
  `preg_match_all()` over each item's `->value` (or `->uri` for link fields; regex plugins first
  `htmlspecialchars_decode()`), returning the matched strings. `verifyValue()` validates before store:
  URL (`FILTER_VALIDATE_URL`), e-mail (`FILTER_VALIDATE_EMAIL`), non-empty string, or numeric.
- `LinkExtractor`/`EmailExtractor` set the values directly on the target field. `ImageExtractor` and
  `FileExtractor` `storeValues()` **fetch each matched URL server-side** (`file_get_contents()` /
  `getimagesize()`), create file/image entities via `ExternalBase::getFileHelper()`, and honour
  cardinality plus (image) min/max resolution and amount/offset.
- The RegEx plugins expose a **Regular Expression** textfield in `extraAdvancedFormFields()` /
  `extraFormFields()`; the Link extractor exposes a disallowed-extensions textfield.

## Notes / caveats

- Despite the "AI" package name, these plugins do **not** call any AI provider — they are pure
  regex/code helpers meant for the deterministic steps of an Automators chain (often after a scraper step).
- `composer.json` still carries the legacy package name `drupal/ai_interpolator_extractor`; the project /
  module machine name is `ai_automator_extractor`.
