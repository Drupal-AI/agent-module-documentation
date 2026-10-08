<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Audio Generator turns a node's text into a single spoken-audio file using AI text-to-speech, chunking long content and assembling it through the Batch API.

---

AI Audio Generator produces full-length MP3 (or WAV-then-MP3) audio from node content. It renders the node through a dedicated "Text to Speech" view mode so a site builder controls exactly which fields are read aloud, splits the extracted text into small chunks at natural paragraph and sentence boundaries, and synthesises each chunk through an AI Core text-to-speech provider (OpenAI, Google Gemini, ElevenLabs, …) or a direct Google Cloud TTS integration. Generation runs as a Batch API job so long articles do not exceed provider character limits or PHP time limits. The per-chunk audio is concatenated in pure PHP into one file, saved as a managed File, wrapped in a Media entity, and attached to the node via a configured media reference field. A pronunciation dictionary corrects mispronunciations (SSML phonemes for Google TTS, plain-text substitutions for AI providers), and an optional CloudConvert step compresses WAV output to MP3. Content editors start generation with a "Save and generate Audio" button on the node form. It depends on core `node`, `media`, `file`, plus the `ai` and `key` modules, and supports Drupal 10 and 11.

---

- Generate a single MP3 audio file from a node's text with one click on the node form.
- Offer content editors a "Save and generate Audio" button alongside the normal Save.
- Read arbitrarily long articles aloud without hitting TTS character limits.
- Split text at paragraph and sentence boundaries so concatenated audio sounds natural.
- Run generation as a Batch API job with a progress bar, avoiding PHP timeouts.
- Provide audio versions of articles and reports for accessibility (listen instead of read).
- Use any AI Core text-to-speech provider (OpenAI, Google Gemini, ElevenLabs, …).
- Use Google Cloud TTS directly via the official SDK, bypassing the provider abstraction.
- Curate exactly which fields are read aloud through a dedicated "Text to Speech" view mode.
- Preview the spoken transcript in the browser using the shipped `node--tts.html.twig` template.
- Choose the language (e.g. `en-GB` vs `en-US`) and a specific Google voice name.
- Pass voice-style instructions (tone, pacing, accent) to providers that support them.
- Fix mispronounced proper nouns, acronyms, and heteronyms with a pronunciation dictionary.
- Insert Google SSML `<phoneme>` substitutions for precise phonetic control on Google TTS.
- Expand abbreviations (e.g. "AWS" → "Amazon Web Services") as plain text for AI providers.
- Compress WAV output (e.g. Gemini PCM) to MP3 automatically via optional CloudConvert.
- Store the finished audio as a managed File wrapped in a Media entity of your choice.
- Attach the generated audio to a node media reference field you configure per content type.
- Regenerate audio on re-save, updating the existing media entity in place to keep the library tidy.
- Name the output file from a token template such as `final_audio_[node:nid]` or `[node:title]`.
- Enable audio generation selectively, per content type, from a single settings form.
- Store Google service-account and CloudConvert credentials securely via the Key module.
- Publish generated media only when the source node itself is published.
- Retry each chunk's TTS call up to three times and abort cleanly on repeated failure, preserving existing audio.
