<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Audio Field is a file field whose MP3 audio is generated from text by an AI text-to-speech provider, with a widget for writing the text and generating or regenerating the audio inline.

---

AI Audio Field (the provider-agnostic follow-up to the ElevenLabs Field module) turns text into speech through Drupal's AI module. It defines a field type (`ai_audio_file`) that extends core's file field: alongside the generated audio file it stores the source text, the chosen text-to-speech provider, model and provider configuration. Its custom widget lets an editor type the text, choose from the providers registered for the `text_to_speech` operation, pick a model, tune model-specific settings, and press Generate (or Regenerate) to synthesise an MP3 via an AJAX call, previewing it in an inline audio player before saving; on entity save a field left with text but no file generates the audio automatically. The generated file is a normal managed file rendered by core's default file formatter. The module also ships two AI Automators rules for the `ai_automators` module: "Generate story", which asks an LLM to produce a multi-speaker dialogue as JSON and then synthesises each line with a per-speaker voice/provider/model; and "Merge Audio Files", which uses ffmpeg to concatenate a field's audio files into one (only offered when ffmpeg is present on the server). It requires the AI module (`^1.0.5`) and core file, on Drupal 10.2+/11, and relies entirely on the AI module for provider selection and credentials.

---

- Add a field that reads out an article body as generated speech.
- Generate an MP3 narration from text typed into the widget.
- Regenerate audio after editing the text, replacing the previous file.
- Preview the generated audio in an inline player on the edit form.
- Let editors pick which text-to-speech provider to use per item.
- Choose a specific model for a provider (e.g. a standard vs. premium voice).
- Tune provider-specific options (language, sample rate, encoding, voice) from the widget.
- Store the source text with the audio so it can be regenerated later.
- Auto-generate the audio on save when text is present but no file exists yet.
- Swap providers without changing the field (provider-agnostic, unlike ElevenLabs Field).
- Produce accessible audio versions of written content.
- Add narrated summaries to news or blog posts.
- Generate multi-voice podcast-style dialogue with the "Generate story" AI Automator.
- Assign a distinct voice/provider/model to each speaker placeholder in a dialogue.
- Merge several generated clips into one file with the ffmpeg "Merge Audio Files" automator.
- Build a text-to-speech workflow into a content type via AI Automators.
- Store generated audio in public or private file storage per field settings.
- Set a default file name and subdirectory for generated MP3s.
- Use any AI-module text-to-speech provider the site has configured.
- Offer audio content for language-learning or low-literacy audiences.
