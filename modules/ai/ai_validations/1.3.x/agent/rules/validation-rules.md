<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The seven AI validation rules

## Install & enable

```bash
composer require drupal/ai_validations   # pulls drupal/ai ^1.3, drupal/field_validation ^3.0@beta
drush en ai_validations -y
```

Then configure AI Core with at least one provider/model, and enable the operation types you need
(chat, moderation, text/image classification, object detection, speech-to-text). There is **no
settings form in this module** — you add rules on a **Field Validation rule set**
(*Structure → Field validation*), attaching a rule to a field of a bundle. Provider/model pickers
are AI Core's `ai_provider_configuration` element; leaving one blank uses AI Core's configured
default provider for that operation type.

## How a rule is wired (base classes)

- `AiConstraintFieldValidationRuleBase` (`src/AiConstraintFieldValidationRuleBase.php`) — extends
  field_validation's `ConstraintFieldValidationRuleBase`. Injects `ai.provider`, `token`,
  `logger.factory:field_validation`. Stores the chosen provider as a single `"provider__model"`
  string (`extractStoredModel()`), decoding it back for the form (`buildModelDefaultValue()`).
  Each concrete rule declares its `@FieldValidationRule` id, `getConstraintName()`,
  `getOperationType()`, `defaultConfiguration()`, and the form.
- `AiConstraintValidatorBase` (`src/AiConstraintValidatorBase.php`) — extends Symfony
  `ConstraintValidator`. Injects `ai.provider` and `entity_type.manager`. Shared helpers:
  - `resolveProviderOption($option,$opType,$msg,$violateOnMissing=TRUE)` — returns the configured
    `provider__model`, else AI Core's default for the op type; if neither exists it adds the
    `$msg` violation (unless `$violateOnMissing` is FALSE) and returns NULL.
  - `loadFile($fid)` — loads the file entity; NULL (no violation) when the field is empty, or a
    `"No file accessible"` violation when a set id fails to load.
  - `runBooleanChat($option,$prompt,$userText,$image=NULL)` — sends `system`=prompt + `user`=value
    (optionally with an `ImageFile`) as a `ChatInput`; returns TRUE only if the normalized reply
    text contains the literal `XTRUE`. **Wraps the provider call in try/catch and returns FALSE on
    any exception.**
  - `transcribeAudio($fid,$option)` — wraps the file in `AudioFile`/`SpeechToTextInput`, calls the
    STT provider, returns the transcript.
  - `applyImageStyle($image,$file,$styleId)` — builds/uses the style derivative URI, falling back to
    the original file if the style is missing or the derivative can't be created.
  - `labelMatchesFinder($label,$needle,$finder)` — `contains` → `str_contains`, `substring` →
    `stripos` (case-insensitive), default/`exact` → `===`.

## The rules

### 1. AI text prompt — `ai_text_prompt_constraint_rule` / `AiTextPrompt`
Op `chat`. Config: `prompt` (required; must instruct the model to answer `XTRUE`/`XFALSE`),
`provider`, `message`. Validator (`AiTextConstraintValidator::validate`) sends
`prompt . "\n" . message` as the system message and the field value as the user message via
`runBooleanChat()`; **adds `message` as a violation when the reply is not `XTRUE`.**

### 2. AI moderation — `ai_moderation_constraint_rule` / `AiModeration`
Op `moderation`. Config: `provider`, `categories` (comma list; blank = any flagged category fails),
`threshold` (0–1, default 0.5, only applied to named categories), `message`. Validator calls
`provider->moderation(new ModerationInput($value))`. If `isFlagged()` and (no categories, or a named
category's score `> threshold`), adds `message`.

### 3. AI text classification — `ai_text_classification_constraint_rule` / `AiTextClassification`
Op `text_classification`. Config: `tag`, `finder` (`exact`/`contains`/`substring`), `model`,
`minimum` (default 0.8), `na` (`skip`/`fail`, default `skip`), `message`. Validator classifies the
text and, for each returned label matching `tag` under `finder` with `confidence >= minimum`, adds
`message`.

### 4. AI image classification — `ai_image_classification constraint_rule` / `AiImageClassification`
Op `image_classification`. Config like #3 plus `imageStyle` (optional). Loads the uploaded file,
applies the style, classifies the image; label match + `minimum` → violation.

### 5. AI image prompt (vision) — `ai_image_constraint_rule` / `AiImagePrompt`
Op `chat_with_image_vision`. Config: `prompt`, `provider`, `message`, `imageStyle`. Sends the image
plus the XTRUE/XFALSE prompt via `runBooleanChat()`; not-`XTRUE` → violation.

### 6. AI object detection — `ai_object_detection_constraint_rule` / `AiObjectDetection`
Op `object_detection`. Config: `model`, `keywords[]` (one per line/comma), `finder`, `minimum`
(default 0.8), `keywordFilter` (`or`/`and`), `ruleMode` (`disapprove_when_found` /
`approve_when_found`), `na` (`skip`/`fail`), `message`, `imageStyle`. Detections below `minimum`
are ignored; keywords are matched by `finder`; `and` requires all keywords matched, `or` any;
`approve_when_found` violates when **not** matched, `disapprove_when_found` violates when matched.
`calculateDependencies()` adds `image.style.<id>` when a style is set.

### 7. AI audio — `ai_audio_constraint_rule` / `AiAudioPrompt`
Ops `speech_to_text` (STT) + `chat`. Config: `provider` (STT), `chat_provider` (chat), `prompt`,
`message`. `transcribeAudio()` produces a transcript, then `runBooleanChat()` evaluates it against
the XTRUE/XFALSE prompt; not-`XTRUE` → violation.

## Behavior on provider error / model unavailable

This differs by rule and matters if you rely on a rule as a hard content gate:

- Each rule carries an **"If model is not available"** (`na`) option — `skip` or `fail` — that governs
  what happens when no provider/model is configured or the provider throws at call time.
- The text-prompt, image-prompt, audio (all via `runBooleanChat`) and moderation rules add the
  violation in that case (the value does not validate).
- The text-classification, image-classification and object-detection rules add the violation when
  their `na` option is set to `fail`; with `na = skip` (the default for those rules) the value
  validates when no verdict is available.

## Operating notes

- These rules validate content — a value not selected (`resolveProviderOption`) or an empty field is
  skipped without a violation.
- Prompt rules depend entirely on the model honoring the XTRUE/XFALSE instruction; a reply lacking
  the literal `XTRUE` is treated as a failure (for prompt rules) — keep prompts explicit.
- Costs/egress: every validated value (or transcribed audio) is sent to the provider on each entity
  validation; use an `imageStyle` to shrink image payloads.
- `.module` adds a submit handler on `field_validation_rule_form` to fix an upstream save-drop bug
  (see `_ai_validations_sync_rule_to_collection`); no configuration needed.
