<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ElevenLabs (elevenlabs) — agent index

ElevenLabs provider plugin for the **AI** module — text-to-speech via the AI provider abstraction.
Configure at `/admin/config/system/eleven-labs-settings`. Version **1.1.1**.
Core `^10.2 || ^11`. Depends on `ai:ai` and `key:key`. No permissions of its own.

Classes: `Plugin/AiProvider/ElevenlabsProvider`, `ElevenLabsApiService`,
`Form/ElevenLabsSettingsForm`.

**Credentials are handled correctly** — the settings form uses `'#type' => 'key_select'` and
stores a **Key entity id**, not the secret. Put the API key in an environment variable, create the
Key with Key's env provider, then select it here. Nothing sensitive reaches exported config.

Two operational notes worth passing on: ElevenLabs bills **per character**, so generating speech
during page render rather than on save is an invoice problem; and cache the resulting audio.
Voice-cloning use is governed by ElevenLabs' own terms about whose voice may be synthesised.