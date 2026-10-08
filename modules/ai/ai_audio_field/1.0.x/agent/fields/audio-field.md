<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The AI Audio field type, widget and AI Automators rules

## Install & enable

```bash
composer require drupal/ai_audio_field   # requires drupal/ai ^1.0.5
drush en ai_audio_field -y
```

Depends on `ai` and core `file`. You must have at least one AI provider configured for the
`text_to_speech` operation in the AI module (that is where provider credentials live — this module
stores none). No config, routes or permissions of its own; access is core field/entity edit access.

## Field type `ai_audio_file`

`src/Plugin/Field/FieldType/AiAudioField.php`, extends core `FileItem`.

- **Stored properties:** the file `target_id` plus `text`, `provider`, `model`, `configuration`
  (all strings; `configuration` is a JSON blob). `display`/`description` are removed vs. core file.
  `schema()` defines the columns; `mainPropertyName()` = `target_id`.
- **Empty / generation:** `isEmpty()` is TRUE when `text` is empty. `hasNewEntity()` is true when
  non-empty and no file yet. `preSave()` calls `generateAudio()` when `target_id` is empty and
  `text` is set.
- **`generateAudio()`:** `ai.provider->createInstance($this->provider)`, `new
  TextToSpeechInput($this->text)`, `->textToSpeech($input, $this->model, $configuration)`, then
  `->getNormalized()[0]->getAsFileEntity('public://', 'test.mp3')` and returns the file id. (The
  hard-coded `test.mp3` name is what the AI module's normaliser saves under; the field's own
  `file_name`/`file_directory`/`uri_scheme` settings below govern the field-config UI.)
- **Storage/field settings forms:** `storageSettingsForm()` offers a `uri_scheme` (upload
  destination, public/private) radio; `fieldSettingsForm()` adds `file_directory` and `file_name`
  (default `generated-audio.mp3`).
- `default_widget = ai_audio_field_widget`, `default_formatter = file_default` (core renders the
  saved file), `constraints = ['ReferenceAccess' => []]`. `generateSampleValue()` writes a random
  file for test content.

## Widget `ai_audio_field_widget`

`src/Plugin/Field/FieldWidget/AiAudioFieldWidget.php`, extends core `FileWidget`,
`field_types: ['ai_audio_file', 'file']` (it can also be attached to a plain core file field).

- **Elements per delta** (`formElement()`): a `text` textarea; a required `provider` select built
  from `providerManager->getProvidersForOperationType('text_to_speech')`; a required `model` select
  from the provider's `getConfiguredModels()`; a dynamic provider **configuration** subform built
  from the model's `getAvailableConfiguration()` schema (via `generateFormElements()` /
  `mapSchemaTypeToFormType()`); a hidden `target_id`; and a **Generate/Regenerate audio** AJAX
  submit.
- **Generate (AJAX):** `generateSubmit()` reads the submitted text/provider/model/config,
  `providerManager->createInstance(...)->textToSpeech(...)`, saves the file, updates widget + form
  state; if a previous file existed its `status` is set to 0 (unmanaged). `generateForm()` rebuilds
  the element and renders the inline `<audio>` preview (a random query string busts the browser
  cache).
- **Widget settings:** `settingsForm()` exposes `show_start_time` and `show_advanced` checkboxes.
- `massageFormValues()` nulls empty text/provider/model and JSON-encodes the `ai` config subtree
  into `configuration`.

## AI Automators rules (optional — require the `ai_automators` module)

`src/Plugin/AiAutomatorType/`:

- **`AiAudioFieldStory`** — `#[AiAutomatorType(id: 'ai_audio_file', label: 'AI Audio Field: Generate
  story', field_rule: 'ai_audio_file', target: 'file')]`, extends `RuleBase`. Editors define one or
  more **voice placeholders** (each a placeholder token + provider + model + config). `generate()`
  appends a strict "RFC8259-compliant JSON" instruction to the prompt and runs the chat LLM;
  `verifyValue()` requires `speaker`/`speaker_id`/`text`; `storeValues()` synthesises each dialogue
  line with its speaker's voice via `textToSpeech` and sets the multi-value field. Default prompt is
  a two-host podcast dialogue.
- **`AiAudioFieldMerge`** — `#[AiAutomatorType(id: 'ai_audio_file_merge', label: 'AI Audio Field:
  Merge Audio Files', field_rule: 'file', target: 'file')]`, extends `ExternalBase`,
  `needsPrompt() = FALSE`. `ruleIsAllowed()` runs `which ffmpeg` (`where` on Windows) and disables
  the rule if ffmpeg is missing. `generate()` writes an ffmpeg concat list of the source files'
  `realpath`s to a temp file and runs `ffmpeg -f concat -safe 0 -i {input_list} -c copy {tmp_file}`;
  `storeValues()` copies the result to the field's configured path and creates the file entity.
  Command tokens are passed through `escapeshellarg()`.

## Notes

- The widget can attach to a plain core `file` field too; on such a field there is nothing to
  generate (no `text` property), so it behaves like an enhanced file widget.
- Generation is synchronous and calls the external AI provider; expect the request to take as long
  as the provider's synthesis of the text.
- No module-level permission gates generation — it is available to anyone with edit access to the
  field/entity, the same as any other field widget.
