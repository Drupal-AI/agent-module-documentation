<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Ai Interpolator Auphonic adds an AI Interpolator field rule, "Auphonic Normalize Audio", that automatically runs the audio in one file field through the Auphonic service and writes the normalized result into another file field.

---

The submodule ships one plugin: `NormalizeAudio` (`@AiInterpolatorFieldRule id = "ai_interpolator_auphonic_normalize_audio"`, `field_rule = "file"`, `target = "file"`), depending on `ai_interpolator` and `auphonic`. Configured as an AI Interpolator rule on a **file** field, its `generate()` iterates each file referenced by the rule's `base_field`, calls `auphonic.api::startProduction($fileEntity)` for it, and — when a production `uuid` comes back — polls `getProduction()` every 5 seconds (up to 10 tries) until Auphonic reports `status == 3` (done). It then collects each output file's `download_url` and `filename`. `verifyValue()` accepts a value only if its `uri` passes `FILTER_VALIDATE_URL`. `storeValues()` resolves the target field's destination directory from its `uri_scheme` + `file_directory` settings (token-replaced), ensures the directory exists, downloads each production via `auphonic.api::downloadProduction($uri, $destination)` (writing the file, renaming `.mp3` → `.auphonic.mp3`), and on HTTP 200 creates a **permanent** managed `file` entity owned by the current user with the detected MIME type, finally setting those file entities onto the field. The rule needs no prompt, no advanced mode and defines no tokens (`needsPrompt()`/`advancedMode()` return FALSE, `tokens()` = `[]`). It provides no routes, permissions, services, config or schema of its own — it is purely an AI Interpolator plugin wiring the parent module's `auphonic.api` client into a field-generation workflow. (The submodule's `info.yml` declares `core_version_requirement: ^9.2 || ^10`.)

---

- Auto-normalize an uploaded audio file into a second "processed" file field when content is saved.
- Build a podcast/episode content type where the raw upload is mastered by Auphonic automatically.
- Level the loudness of user-submitted audio without manual steps.
- Populate a "normalized audio" file field from a "raw audio" file field via AI Interpolator.
- Batch-process existing audio fields by running the interpolator rule over a content type.
- Store the Auphonic output as a permanent managed file (owned by the current user) on the entity.
- Keep the processed file distinct from the source by the `.auphonic.mp3` naming convention.
- Route processed files into a specific directory/scheme via the target field's file settings.
- Integrate Auphonic post-production into an automated editorial pipeline (AI Automator).
- Validate that Auphonic returned a usable download URL before saving anything.
- Reuse the parent module's configured Auphonic account (username + Key password) for field automation.
- Trigger cloud audio mastering as a side effect of normal content editing.
- Chain audio normalization after an upload without writing custom code.
- Regenerate the normalized file by re-running the interpolator rule.
- Apply the account's default Auphonic production settings to each field-triggered production.
