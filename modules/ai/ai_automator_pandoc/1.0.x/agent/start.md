<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Automator: Pandoc (ai_automator_pandoc) — agent index

One **AI Automators plugin** that converts a document from a file field to HTML by shelling out to the
**pandoc** CLI, storing the result in a `text_long` field on entity save. Package `AI`. Core
`^10.4 || ^11 || ^12`. License GPL-2.0-or-later. Project version 1.0.0-rc1.

Depends on core **`system`** and the AI module's **`ai_automators`** sub-module. Requires **pandoc**
installed on the server; the binary path is site config.

- **The automator plugin, its options, the settings form, install requirements, and the Drush command** →
  [plugins/pandoc-word-to-html.md](plugins/pandoc-word-to-html.md)

## What it actually is

- One plugin: `PandocWordToHtml` (`src/Plugin/AiAutomatorType/PandocWordToHtml.php`), attribute
  `#[AiAutomatorType(id: 'pandoc_word_to_html', label: 'Pandoc: Word to HTML', field_rule: 'text_long')]`,
  extending `ai_automators`' `ExternalBase`. `allowedInputs()` = `['file']`; `needsPrompt()` = FALSE.
- Settings form `PandocSettingsForm` (`src/Form/PandocSettingsForm.php`, route
  **`ai_automator_pandoc.settings`** at `/admin/config/content/pandoc`, permission
  **`administer site configuration`**) writes config object **`ai_automator_pandoc.settings`**
  (`pandoc_binary`; schema in `config/schema/`, install default `''`). Menu link under
  *Configuration → Content authoring*.
- `ai_automator_pandoc.install`: `hook_install()` warns to configure the path; `hook_requirements()`
  reports OK/Warning/Error on the status page based on the configured binary.
- Drush: `PandocCommands` (`drush.services.yml`) → command **`ai-automator-pandoc:test`** (alias
  `pandoc-test`). No permissions of its own; no config schema beyond the settings object.

## Mechanism (from source)

- `generate()` iterates the source file field, resolves each file's real path
  (`file_system->realpath()`), maps MIME/extension to a pandoc input format (`detectInputFormat()`), and
  calls `runPandoc()`.
- `runPandoc()` builds an **argv array** `[$pandoc, $inputFile, '-f', $fmt, '-t', $out, '--wrap=…', …,
  '--output=-']` and runs it with **`proc_open($args, …)`** (array form ⇒ no shell). stdout is the HTML;
  non-zero exit is logged and yields NULL. Optional flags: `--standalone`, `--embed-resources`,
  `--number-sections`, `--toc`, plus the space-split **extra-args** string.
- `getPandocBinary()` reads `ai_automator_pandoc.settings:pandoc_binary` and requires it to exist and be
  executable. `storeValues()` writes the HTML to the target field and, if the entity has
  `field_ai_doc_proofread_status`, sets it to `word_to_html`.

## Notes / caveats

- pandoc must be reachable by the PHP process; the settings form validates the path with
  `escapeshellcmd($path) . ' --version'` and the status report reflects availability.
- Output is whatever pandoc produces; how that HTML is later filtered/displayed depends on the target
  field's text format, not this module.
