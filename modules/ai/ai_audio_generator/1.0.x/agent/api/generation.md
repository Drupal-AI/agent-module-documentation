<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Generation pipeline & pronunciation dictionary

## Trigger (node form)

`Hook\NodeFormHooks::formNodeFormAlter` (attribute `#[Hook('form_node_form_alter')]`) adds a
**Save and generate Audio** submit button to node forms whose bundle appears in
`ai_audio_generator.settings:content_types`. Its `#submit` runs the standard node-save handlers
first, then the static `submitGenerateAudio`, which resolves the service instance via
`\Drupal::service(self::class)` and calls `doGenerateAudio()`. Generation therefore happens only on
a POST form submit gated by normal node-edit access.

`doGenerateAudio()` (in `NodeFormHooks`):

1. Loads the saved node from `$form_state` build info; reads the per-bundle `content_types` entry
   (errors out if the type isn't configured).
2. `TextExtractor::extractPlainText($node, $view_mode)` → plain text.
3. `TextExtractor::applyPronunciationDictionary($plain, $strip_ssml)` where `$strip_ssml` is
   `TRUE` for AI providers and `FALSE` for Google TTS (`provider_type === 'google_tts'` ⇒
   `$use_ssml = TRUE`).
4. `TextChunker::chunk($plain)` → ordered chunks.
5. Builds a `BatchBuilder`: one `AudioGeneratorBatch::processChunk` op per chunk, then
   `mergeChunks`, then (only if `cloudconvert_key_id` is set) `convertWithCloudConvert`, with
   `finished` as the finish callback. `batch_set(...)`.

## Text extraction — `Service\TextExtractor`

`extractPlainText(NodeInterface $node, string $view_mode)`:

- `EntityViewDisplay::collectRenderDisplay()` gets the display; iterates `getComponents()` in weight
  order but keeps **only** field names present in the raw
  `core.entity_view_display.node.<bundle>.<view_mode>:content` config (base fields auto-injected by
  the display are excluded — they are invisible in Manage Display and must not be voiced).
- Renders each field with `view_builder->viewField()` (values only, no labels) via
  `renderer->renderInIsolation()`, converts to text with `PlainTextOutput::renderFromHtml()`, and
  collapses whitespace.
- Joins fields with `". "` and normalises repeated periods.

Both public methods are Drush-callable for debugging (see the class docblock).

## Chunking — `Service\TextChunker`

`chunk()` normalises line endings, then splits: primary on paragraph boundaries (`\n\n+`); any
paragraph over `MAX_CHUNK_SIZE` (**800** chars) is split on sentence punctuation
(`(?<=[.?!])\s+`); any sentence still too long is hard-split with `str_split`. Result is an ordered
array each under 800 chars. Splitting at natural pauses means the micro-gap from concatenation
sounds like a breath, not a stutter.

## Batch — `Batch\AudioGeneratorBatch` (all static)

Batch callbacks must be static because the Batch API serialises them and cannot hold services.

### `processChunk(...)`

- Wraps the chunk in `<speak>…</speak>` when `$use_ssml` (Google SSML mode).
- Calls `callGoogleTtsDirect()` (when `provider_type === google_tts`) or `callAiProvider()`,
  **retrying up to 3 times**; on 3 failures it records an error, sets `results['abort'] = TRUE`,
  and stops the batch (preserving any existing audio).
- `callAiProvider()` uses AI Core: `ai.provider` → `loadProviderFromSimpleOption()` (or the global
  `text_to_speech` default), `setConfiguration(buildProviderConfiguration(...))` (forces
  `response_format => mp3`, adds `input_type => ssml` and `instructions` when relevant), then
  `textToSpeech(new TextToSpeechInput($text), $model, ['ai_audio_generator'])` and reads
  `getNormalized()[0]->getBinary()`.
- `callGoogleTtsDirect()` uses the `google/cloud-text-to-speech` SDK: reads the service-account JSON
  from the Key repository (`Json::decode`), builds `TextToSpeechClient`, `SynthesisInput`
  (`setSsml`/`setText`), `VoiceSelectionParams` (language + optional voice), `AudioConfig` with
  `AudioEncoding::MP3`, calls `synthesizeSpeech()`.
- Detects WAV via `detectWav()` (RIFF/WAVE) → stores PCM + `wav_meta`; otherwise treats as MP3 and
  runs `stripId3Tags()` + `stripVbrFrame()` so concatenated frames play to the true end.
- Saves each chunk to `temporary://tts_tmp/chunk_<batchid>_<index>.mp3` via `file_system->saveData`.

### `mergeChunks(int $node_id, string $filename_template, ...)`

Skips when `abort` is set. Sorts chunk files by index, verifies each exists/non-empty, then writes
`public://audio/<filename>`: for WAV it writes one rebuilt 44-byte header (`buildWavHeader`) then
streams all PCM; for MP3 it streams frames directly. `resolveFilename()` runs the template through
`\Drupal::token()->replace(['node' => $node])`, then the site's filename-sanitisation event
(`FileUploadSanitizeNameEvent`), then `sanitizeFilename()` (`basename()` to drop path components,
`[^a-zA-Z0-9_]+` → `-`), and reappends the `mp3`/`wav` extension; falls back to
`final_audio_<nid>.<ext>`. Temp chunks are cleaned up.

### `convertWithCloudConvert(string $key_id, ...)`

Added only when `cloudconvert_key_id` is set; no-op unless `audio_format === wav`. Reads the
CloudConvert API key from the Key repository, builds a CloudConvert job (`import/upload` →
`convert` to mp3 at `audio_qscale 2` → `export/url`), uploads the WAV, and polls across batch
requests using `$context['sandbox']` (`$context['finished']` 0.5 → 0.7 until `finished`). Downloads
the MP3 straight to disk with `\Drupal::httpClient()->request('GET', $files[0]->url, ['sink' => ...])`
(the URL comes from CloudConvert's own job result), unlinks the WAV, and updates
`results['final_uri']/final_real_path/audio_format`.

### `finished(bool $success, array $results, array $operations)`

Surfaces warnings/errors via messenger; stops on `abort`. Loads the node and the per-bundle
`media_type`/`media_field`, resolves the media source field, creates a managed File
(`status = 1`, owner = current user) for `final_uri`, and either **updates the existing media
in place** (swap source field, rename `Audio: <title>`, mark old file temporary for `file_cron`) or
**creates a new Media** and attaches it to the node field. Media is published only when the node is
published.

## Pronunciation dictionary — `Form\PronunciationDictionaryForm`

Edits `ai_audio_generator.dictionary:entries` (rows of `{original, replacement}`). AJAX add/remove
rows (`entry_count` in form state). The form description differs by active backend
(`isGoogleTtsActive()` = `provider_type === google_tts`): Google shows SSML guidance, otherwise it
notes tags are stripped to plain text.

**Validation** — `isValidSsmlFragment()`: a replacement is accepted if it is empty, contains no
markup (`strip_tags($v) === $v`), or parses as XML whose every element is in
`ALLOWED_SSML_TAGS = [phoneme, sub, say-as, break, emphasis, prosody, lang]`. Anything else
(e.g. `<script>`, `<audio>`, `<voice>`, malformed XML) is rejected with a form error. `<audio>`,
`<speak>`, and `<voice>` are deliberately excluded.

**Application** — `TextExtractor::applyPronunciationDictionary($text, $strip_ssml)` runs before
chunking (so inserted tags are never split across chunks): case-sensitive `str_replace` of each
`original` with its `replacement`. When `$strip_ssml` is TRUE (AI providers) the replacement is
`strip_tags()`-reduced to its text (e.g. `AWS` → `Amazon Web Services`); entries whose replacement
becomes empty after stripping are skipped. For Google TTS the SSML is kept, and `processChunk`
wraps each chunk in `<speak>` so `<phoneme>` is honoured.

## Other hook

`Hook\FormHooks::ginIgnoreStickyFormActions` returns the dictionary form id so Gin keeps its Save
button inline.
