# AI Translate — permissions

Defined in `ai_translate.permissions.yml`.

| Permission | Gates | Route / entry point |
|---|---|---|
| `create ai content translation` | Trigger AI translation of a content entity (creates + saves the target-language translation). Also the base of the access gate for the AI function call and the Tool plugin. | `ai_translate.translate_content`, `ai_translate:translate_entity` function call, `ai_translate_tool:translate_entity` Tool |
| `create ai interface translation` | Use the AJAX "AI translate" button on the locale interface-translation form. | `ai_translate.translate_interface` |
| `manage ai translation prompts` | Access the settings form / manage prompts. | `ai_translate.settings_form` |

## How content-translation access is enforced

`create ai content translation` is only the first of several checks. The web route
`ai_translate.translate_content` requires a CSRF token and runs
`AiTranslateController::checkAccess`, which defers to
`EntityTranslationOrchestrator::checkTranslateAccess()`. That gate additionally requires the entity to
be translatable, the entity type to have a translation handler, the caller's **`update` access on the
target entity**, and the translation handler's **`create` access**. The same gate is applied by the
`translate_entity` AI function call and the `ai_translate_tool` Tool plugin, so a user can only generate
a translation for an entity they are allowed to update.

The Drush commands (`ai:translate-entity`, `ai:translate-text`) run with CLI trust and do not perform a
per-entity access check — treat CLI access accordingly.
