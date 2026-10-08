<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Speech to Text adds browser speech-to-text (dictation) to text-box fields.

---

Speech to Text **adds dictation to text fields** — using the browser's Web Speech API (`SpeechRecognition`)
so editors can dictate into text-box fields instead of typing, for accessibility/convenience. It provides its own
permissions, in the Accessibility package.

Use it to enable voice input on fields. It is an accessibility/content-editing feature that runs **client-side in
the browser**. Privacy note: the Web Speech API is a **browser** feature — in some browsers (e.g. Chrome) the
captured **audio is sent to the browser vendor's servers** (e.g. Google) for recognition; that's a browser
behavior, not Drupal egress, but disclose it to users as a privacy consideration. It has no content or access role
beyond its permission. Enable dictation on chosen fields.

---

- Add dictation to text fields.
- Use the browser Web Speech API.
- Aid accessibility/convenience.
- Provide its own permissions.
- Serve accessibility/content editing.
- Run client-side in the browser.
- NOTE the browser may send audio to its vendor (e.g. Google) for recognition.
- Disclose the browser behavior as a privacy consideration.
- Have no content/access role beyond permission.
- Enable dictation on fields.
- Handle speech-to-text.
- Dictate text.
- Configure the fields.
- Transcribe speech.
- Handle the input.
- Voice-type fields.
- Configure accessibility.
- Handle the dictation.
- Speak to fields.
- Provide speech-to-text.
