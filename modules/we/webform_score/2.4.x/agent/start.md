# Webform Score — agent index

Scores Webform submissions. "Quiz" webform elements carry a scoring config; on submission save the
total is computed and stored on a `fraction` base field `webform_score` (numerator/denominator).
No settings page (`configure` null). Depends on `webform` + `fraction`. Defines the `webform_score`
plugin type.

- **The four Quiz elements, the *Quiz answer* config, how a form is turned into a quiz** → [configure/quiz-elements.md](configure/quiz-elements.md)
- **The `webform_score` plugin type: built-ins + writing a scoring plugin** → [plugins/webform_score.md](plugins/webform_score.md)
- **The `webform_score` base field, tokens, and how the score is computed/read** → [api/score.md](api/score.md)
- **`view any` / `view own` submission-score permissions & field access** → [permissions/permissions.md](permissions/permissions.md)
- **`hook_webform_score_info_alter`** → [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Quiz elements (`src/Plugin/WebformElement/`, category "Quiz"): `webform_score_checkboxes`,
  `webform_score_radios`, `webform_score_select`, `webform_score_textfield`. They implement
  `QuizInterface` via `QuizTrait`; element props `webform_score_plugin` + `webform_score_plugin_configuration`.
- Scoring runs in `HookService::webformSubmissionPreSave` (from `hook_ENTITY_TYPE_presave`): sums
  `getMaxScore()`/`score()` over Quiz elements → writes `webform_score` fraction field.
- Plugin type `webform_score`: manager `plugin.manager.webform_score`, dir `Plugin/WebformScore`,
  annotation `@WebformScore` (`id`, `label`, `compatible_data_types`, `is_aggregation`). Built-ins:
  `equals`, `contains`, `sum`, `maximum`, `set_equals`.
- Score field is read-only (calculated); visibility gated by two permissions via `hook_entity_field_access`.
