<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ElevenLabs plugs the ElevenLabs voice API into the AI module's provider system, so anything in Drupal that requests text-to-speech through the AI abstraction can be served by ElevenLabs.

---

The AI module's value is that callers ask for an *operation type* rather than a vendor: request text-to-speech and whichever provider is configured for it responds. This module is one such provider — `Plugin/AiProvider/ElevenlabsProvider` with `ElevenLabsApiService` behind it — which means adopting or replacing ElevenLabs later is a configuration change, not a code change.

Credential handling here is done the right way and worth calling out, because AI provider modules frequently get it wrong: the settings form uses a `key_select` element and stores a **Key entity reference**, not the secret itself. That makes `key:key` a hard dependency and lets the API key live in an environment variable through Key's env provider, so nothing sensitive reaches exported configuration. Set the variable in the environment, create the Key with the env provider, then pick it on `/admin/config/system/eleven-labs-settings`.

Practical uses follow from what ElevenLabs is good at: reading an article aloud for accessibility, generating narration for a video, producing audio versions of alerts or newsletters, or building a voice for a chatbot answer. Two things to keep in mind — calls are billed per character, so anything that generates speech on page render rather than on save will produce a surprising invoice, and synthesised voice output is subject to ElevenLabs' own usage terms about who may be imitated.

---

- Add ElevenLabs as a text-to-speech provider for the AI module.
- Generate an audio version of an article.
- Read page content aloud for accessibility.
- Narrate a video script from text in Drupal.
- Produce audio for a newsletter or digest.
- Give a chatbot a spoken response.
- Generate voice prompts for an IVR flow.
- Create audio versions of alerts or announcements.
- Switch TTS vendors later without changing calling code.
- Store the API key in a Key entity backed by an environment variable.
- Keep the ElevenLabs credential out of exported configuration.
- Choose a voice per request through the provider.
- Compare providers behind the AI abstraction.
- Cache generated audio so speech is not re-billed on every render.
- Restrict who can trigger paid speech generation.