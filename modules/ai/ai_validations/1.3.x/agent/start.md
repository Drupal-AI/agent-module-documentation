<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Validations (ai_validations) — agent index

Adds **seven AI-backed validation rules** to the contributed **Field Validation** module. Each
rule is a `field_validation` **FieldValidationRule plugin** paired with a **Symfony Validator
constraint + validator**. Attach a rule to a field via Field Validation's rule-set UI; on entity
validation the value is sent to an **AI Core** provider and turned into a pass/fail. Package `AI`,
core `^10.4 || ^11 || ^12`, license GPL-2.0-or-later, version 1.3.0.

- Dependencies: `ai` (AI Core), `field_validation`, core `image`. Composer: `drupal/ai:^1.3`,
  `drupal/field_validation:^3.0@beta`.
- **No routes, no permissions, no Drush, no config schema, no services.yml, no own config forms.**
  Provider/model pickers reuse AI Core's `ai_provider_configuration` form element; credentials are
  the AI module's concern.
- **The seven rules, their config keys, and exactly how each verdict is decided** →
  [rules/validation-rules.md](rules/validation-rules.md)

## What it provides (from source)

Base classes: `src/AiConstraintFieldValidationRuleBase.php` (rule plugins; injects `ai.provider`,
`token`, `logger.factory`) and `src/AiConstraintValidatorBase.php` (validators; injects
`ai.provider`, `entity_type.manager`; shared helpers `resolveProviderOption`, `loadFile`,
`transcribeAudio`, `runBooleanChat`, `applyImageStyle`, `labelMatchesFinder`).

| Rule plugin id | Constraint id | AI operation | Field target |
|---|---|---|---|
| `ai_text_prompt_constraint_rule` | `AiTextPrompt` | `chat` | text |
| `ai_moderation_constraint_rule` | `AiModeration` | `moderation` | text |
| `ai_text_classification_constraint_rule` | `AiTextClassification` | `text_classification` | text |
| `ai_image_classification constraint_rule` | `AiImageClassification` | `image_classification` | image/file |
| `ai_image_constraint_rule` | `AiImagePrompt` | `chat_with_image_vision` | image/file |
| `ai_object_detection_constraint_rule` | `AiObjectDetection` | `object_detection` | image/file |
| `ai_audio_constraint_rule` | `AiAudioPrompt` | `speech_to_text` + `chat` | audio/file |

Plugin classes live in `src/Plugin/FieldValidationRule/*` and
`src/Plugin/Validation/Constraint/*` (one `*Constraint.php` + `*ConstraintValidator.php` per rule).

## Mechanics worth knowing

- **Prompt rules** (text/image/audio) build a two-message `ChatInput` — a system prompt that must
  instruct the model to answer `XTRUE`/`XFALSE`, plus the user value — and a violation is added
  unless the reply contains the literal token `XTRUE` (`runBooleanChat()`).
- **Provider selection** falls back to AI Core's *default provider for the operation type* when the
  rule leaves the provider blank (`resolveProviderOption()`).
- **Image rules** can apply an image style first (`applyImageStyle()`), falling back to the original
  file if the derivative can't be built.
- `.module` ships one `hook_form_FORM_ID_alter` (`ai_validations_form_field_validation_rule_form_alter`)
  that works around an upstream field_validation save bug by syncing the edited rule back into the
  plugin collection before save.
- `.install` `hook_requirements` warns (runtime) if the deprecated bundled `ai/modules/ai_validations`
  is still resolving after moving to this standalone package (fix: `drush cr`).

## Notes

- No config schema is shipped; rule configuration is persisted by field_validation's rule-set config
  entity.
- Behavior when the provider errors differs by rule — see the "provider error / model unavailable"
  section in [rules/validation-rules.md](rules/validation-rules.md) before relying on any rule as a
  hard gate.
