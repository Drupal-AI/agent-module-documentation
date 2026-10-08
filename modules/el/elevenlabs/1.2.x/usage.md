<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ElevenLabs plugs the ElevenLabs voice API into the AI module's provider system, so any Drupal code that requests text-to-speech, speech-to-speech or audio isolation through the AI abstraction can be served by ElevenLabs.

---

The AI module lets callers ask for an *operation type* rather than a named vendor: request `text_to_speech` and whichever provider is configured for it responds. This module is one such provider — `Plugin/AiProvider/ElevenlabsProvider` (id `elevenlabs`) backed by `ElevenLabsApiService` — declaring support for `text_to_speech`, `speech_to_speech` and `audio_to_audio` (noise/voice isolation). Adopting or swapping ElevenLabs later becomes a configuration change, not a code change, and everything built on the AI abstraction (including the AI Automator) can reach it. Credentials are handled the way AI provider modules should: the settings form uses a `key_select` element and stores a **Key entity reference** (dependency `key:key`), so the secret can live in an environment variable via Key's env provider and never reaches exported configuration. It talks to `https://api.elevenlabs.io/v1/` over Drupal's shared HTTP client, sending the key in the `xi-api-key` header. Two operational cautions: ElevenLabs bills per character, so generating speech on every page render rather than on save produces surprising invoices (the module caches voice and model listings for an hour but not the generated audio); and synthesised voice output is subject to ElevenLabs' own terms about whose voice may be imitated.

---

- Add ElevenLabs as a text-to-speech provider for the AI module.
- Generate an audio (MP3) version of an article or node from a text field.
- Read page content aloud for accessibility.
- Narrate a video script written in Drupal.
- Produce audio for a newsletter, digest or announcement.
- Give a chatbot or AI Automator flow a spoken response.
- Generate voice prompts for an IVR or telephony flow.
- Use a predefined professional ElevenLabs voice per request.
- Use your own cloned/custom-trained voice for narration.
- Re-voice an existing audio file with speech-to-speech (`eleven_english_sts_v2`).
- Remove background noise / isolate speech from an audio file (audio isolation).
- Split long text automatically into ~5000-character chunks and concatenate the audio back together.
- Pass previous/next-text context between chunks for smoother multi-chunk narration.
- Tune stability, similarity boost, style, speed and speaker boost per request.
- Set a deterministic seed for repeatable generations.
- Switch TTS vendors later without changing calling code.
- Store the API key in a Key entity backed by an environment variable.
- Keep the ElevenLabs credential out of exported configuration.
- Cache generated audio in your own field/entity so speech is not re-billed on every render.
- Restrict who can trigger paid speech generation via the surrounding AI workflow.
- Expose ElevenLabs voices to the AI Automator for automatic field population.
