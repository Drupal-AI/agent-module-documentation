<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Pandoc: Word to HTML" automator

## Install & enable

```bash
composer require drupal/ai_automator_pandoc
drush en ai_automator_pandoc -y
```

Depends on core **`system`** and the AI module's **`ai_automators`** sub-module. Also requires the
**pandoc** binary on the server (`brew install pandoc`, `apt-get install pandoc`, `apk add pandoc`, …).
`hook_install()` shows a warning banner linking to the settings form; the module cannot convert anything
until the binary path is set.

## 1. Set the pandoc binary path (site config)

Form `PandocSettingsForm` (`src/Form/PandocSettingsForm.php`), route **`ai_automator_pandoc.settings`**,
path **`/admin/config/content/pandoc`**, permission **`administer site configuration`**. Menu link
`ai_automator_pandoc.settings` under *Configuration → Content authoring*.

- Single field `pandoc_binary` (textfield, required, maxlength 512) — the absolute path to `pandoc`.
- `validateForm()` requires the path to exist and be executable, then runs
  `exec(escapeshellcmd($path) . ' --version 2>&1')` and rejects it on non-zero exit.
- `submitForm()` saves it into config object **`ai_automator_pandoc.settings`** (key `pandoc_binary`;
  schema `config/schema/ai_automator_pandoc.schema.yml`, install default `''`).
- When a path is saved, the form shows a status fieldset with the detected pandoc version.

`ai_automator_pandoc.install` `hook_requirements('runtime')` mirrors this on `/admin/reports/status`:
`REQUIREMENT_WARNING` when unset, `REQUIREMENT_ERROR` when the path is missing/not executable,
`REQUIREMENT_OK` (with the path) otherwise.

## 2. Configure the automator on a field

The plugin `PandocWordToHtml` (`src/Plugin/AiAutomatorType/PandocWordToHtml.php`) is an AI Automators
type: `#[AiAutomatorType(id: 'pandoc_word_to_html', label: 'Pandoc: Word to HTML', field_rule: 'text_long')]`,
extending `Drupal\ai_automators\PluginBaseClasses\ExternalBase`. `allowedInputs()` = `['file']`,
`needsPrompt()` = FALSE, `advancedMode()` = FALSE.

In the AI Automator settings of a `text_long` **target** field: choose **Pandoc: Word to HTML**, set the
**source** to a file field, and set the options below (`extraFormFields()`):

| Option key | Type / default | Effect (pandoc flag) |
|---|---|---|
| `automator_pandoc_output_format` | select, `html5` (or `html4`) | `-t html5` / `-t html4` |
| `automator_pandoc_wrap` | select, `none` (auto/preserve) | `--wrap=<value>` |
| `automator_pandoc_standalone` | checkbox, off | `--standalone` |
| `automator_pandoc_embed_resources` | checkbox, off | `--embed-resources` (inline referenced resources as data URIs) |
| `automator_pandoc_number_sections` | checkbox, off | `--number-sections` |
| `automator_pandoc_toc` | checkbox, off | `--toc` |
| `automator_pandoc_extra_args` | textfield, '' | space-split and appended as additional pandoc arguments |

## 3. Conversion flow

`generate($entity, $fieldDefinition, $automatorConfig)`:
1. Loop the source field (`$automatorConfig['base_field']`); for each referenced `File`, resolve its real
   path via `file_system->realpath($file->getFileUri())` (skips missing files, logs an error).
2. `detectInputFormat($mimeType, $filename)` maps MIME type → pandoc input format, falling back to the
   file extension, defaulting to `docx`. Supported: docx (docx/doc/msword), pdf, html, plain, odt, rtf.
3. `runPandoc($realPath, $inputFormat, $automatorConfig)` returns the HTML (or NULL).

`runPandoc()` assembles an **argument array**:

```php
$args = [$pandoc, $inputFile, '-f', $inputFormat, '-t', $outputFormat, '--wrap=' . $wrap];
// + optional --standalone / --embed-resources / --number-sections / --toc
// + array_values(array_filter(explode(' ', $extraArgs)))
$args[] = '--output=-';
$process = proc_open($args, $descriptors, $pipes);   // array form: no shell
```

stdout (fd 1) is captured as the HTML string; stderr (fd 2) and a non-zero `proc_close()` exit code are
logged (`logger.channel` `ai_automator_pandoc`) and cause a NULL return. `getPandocBinary()` re-reads
`ai_automator_pandoc.settings:pandoc_binary` and requires it to exist and be executable, else logs and
returns NULL.

`verifyValue()` accepts any non-empty string. `storeValues()` calls `parent::storeValues()` and, if the
entity has a `field_ai_doc_proofread_status` field, sets it to `word_to_html` (the `ai_doc_proofread`
workflow hand-off).

## 4. Drush test command

Service `ai_automator_pandoc.commands` (`PandocCommands`, `drush.services.yml`) provides
**`ai-automator-pandoc:test`** (alias **`pandoc-test`**):

```bash
drush ai-automator-pandoc:test                       # bundled ai_doc_proofread test docx
drush ai-automator-pandoc:test /path/to/document.pdf # a specific file
drush ai-automator-pandoc:test /path/to/x.docx --save --output-format=html4
```

It resolves pandoc from `ai_automator_pandoc.settings` or common install locations (`findPandoc()` — uses
`which`/absolute-path checks), prints the version, runs the **same `proc_open()` argv-array conversion** as
the plugin, and reports exit code, timing, and an HTML preview (first 3000 chars). `--save` writes the full
HTML next to the input file. CLI-only; not reachable over the web.

## Notes

- The module adds **no permissions**; the only route is the settings form gated by
  `administer site configuration`.
- Format detection defaults to `docx` when neither MIME nor extension matches — a mismatch usually just
  produces a pandoc error (logged), not silent bad output.
