<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Audio Translator (ai_audio_translator) — agent index

**Chains AI module STT → chat translation → TTS to produce translated audio media, via a queue.**

- **Version:** 0.1.x (0.1.0-rc1)  •  **Core:** ^11  •  **Package:** AI  •  **Project:** ai_audio_translate
- **Depends on:** media, taxonomy, ai
- **Routes:** `ai_audio_translator.settings` `/admin/config/ai/audio-translator` (`administer ai audio translator`); `ai_audio_translator.translate` `/admin/ai/audio-translator/translate/{media}` (`translate audio media`); `ai_audio_translator.run_queue` (`administer ai audio translator`).
- **Permissions:** `translate audio media`, `administer ai audio translator` (restricted).
- **Entity:** `audio_translation` (status tracker).  **Queue:** `ai_audio_translation`.

**Security:** all routes permission-gated (editor perm for translate, admin perm for config/queue); AI keys handled by the drupal/ai provider layer. `run_queue` is an admin-only GET with no CSRF token but only drains the module's own queue. See [configure/settings.md](configure/settings.md).
