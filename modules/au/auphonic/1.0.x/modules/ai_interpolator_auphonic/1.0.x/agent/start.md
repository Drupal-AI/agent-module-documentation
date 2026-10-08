<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ai Interpolator Auphonic (ai_interpolator_auphonic) — agent index

Submodule of **auphonic**. Adds one **AI Interpolator field rule**, "Auphonic Normalize Audio", that runs a
file field's audio through Auphonic and stores the normalized result on a file field. Package
`AI Interpolator`. Depends on `ai_interpolator` and `auphonic`.
Core `^9.2 || ^10` (as declared in `info.yml` — note: not `^11`).

## What it provides (from source)

- **Plugin** `NormalizeAudio`
  (`src/Plugin/AiInterpolatorFieldRules/NormalizeAudio.php`), annotation
  `@AiInterpolatorFieldRule(id = "ai_interpolator_auphonic_normalize_audio", field_rule = "file", target = "file")`,
  extends `AiInterpolatorFieldRule`, implements `AiInterpolatorFieldRuleInterface` + `ContainerFactoryPluginInterface`.
  DI: `auphonic.api`, `token`, `entity_type.manager`, `file_system`, `current_user`, `http_client`.
  See [plugins/normalize_audio.md](plugins/normalize_audio.md).

## Behavior in one line

`generate()` starts an Auphonic production per referenced file and polls (10×5s) to `status==3`;
`verifyValue()` requires a valid URL; `storeValues()` downloads each output into the target field's
directory (renaming `.mp3` → `.auphonic.mp3`) and creates a permanent managed `file` entity.

## Not provided

No routes, permissions, services, config, schema, hooks, Drush, or entities of its own. `needsPrompt()` /
`advancedMode()` = FALSE, `tokens()` = `[]`. Reuses the parent's `auphonic.api` client (and thus its
username + Key-stored password).

Parent module index: [../../../../agent/start.md](../../../../agent/start.md).
