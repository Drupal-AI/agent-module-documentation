Audio Recorder Webform Integration exposes the parent module's browser audio recorder as a Webform "Audio recorder" file-upload element, so form builders can collect recorded MP3 audio in a Webform.

---

This submodule of Audio Recorder bridges the recorder widget into the Webform module. It registers a Webform element plugin, `WebFormAudioRecorderFileElement` (id `webform_audio_recorder_file_element`, label "Audio recorder", category "File upload elements"), that extends Webform's `WebformAudioFile` element and swaps in a recorder-aware render element, `WebformAudioRecorderFileElement`, which itself extends the parent module's `AudioFileRecorder`. In supported browsers the element captures microphone audio with the bundled vmsg library, encodes it to MP3 client-side, and saves it as a managed file on submission; unsupported browsers fall back to a normal file upload. The element always allows the `mp3` extension regardless of the configured extensions, always previews with the HTML5 audio player, and adds a required "Maximum Recording Time" property (default 45 seconds). Requires the parent `audiorecorder` module and `webform`, plus the vmsg library installed as described in the parent module's README, and an HTTPS site for microphone access.

---

- Add an "Audio recorder" element to a Webform to collect spoken responses.
- Build a survey where respondents record audio answers instead of typing.
- Collect spoken testimonials or feedback through a public Webform.
- Capture a spoken name pronunciation as part of a registration Webform.
- Add a "record a voice message" step to a contact or support Webform.
- Gather audio submissions for a contest or call-for-entries form.
- Let event registrants record a spoken question ahead of a session.
- Collect audio consent statements alongside other Webform fields.
- Capture spoken language-exercise answers in an assessment Webform.
- Record short audio pitches or introductions in an application form.
- Add an audio-note field to a booking or intake Webform.
- Collect field observations as audio in a mobile-friendly Webform.
- Gather spoken translations or interpretations via a submission form.
- Provide an accessible audio-answer option where typing is difficult.
- Cap each recording (e.g. 45 seconds) so submissions stay short.
- Preview the recording inline before the Webform is submitted.
- Store recorded submissions as managed files handled by Webform's file element.
- Offer recording to capable browsers while others use the standard upload.
- Collect audio pronunciations of names/terms through an editorial Webform.
- Add a spoken-message option to a voicemail-style Webform.
