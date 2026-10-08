# AI Translate — permissions

Defined in `ai_translate.permissions.yml`. None are marked `restrict access: true`.

| Permission | Gates | Route |
|---|---|---|
| `create ai content translation` | Trigger AI translation of a content entity (creates + saves the target-language translation). | `ai_translate.translate_content` |
| `create ai interface translation` | Use the AJAX "AI translate" button on the locale interface-translation form. | `ai_translate.translate_interface` |
| `manage ai translation prompts` | Access the settings form / manage prompts. | `ai_translate.settings_form` |
