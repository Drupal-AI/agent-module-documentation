Audio Recorder adds a Drupal field widget that lets users record audio directly in the browser and save it to a core file field, falling back to a normal file upload where the browser lacks the recording APIs.

---

Audio Recorder ships a single field widget, "Audio Recorder" (plugin id `file_audio_recorder`), that attaches to core **file** fields. In supported browsers it uses the bundled vmsg HTML5/WebAssembly library to capture microphone audio and encode it to MP3 client-side; the recorded blob is submitted as a base64 data-URL in a hidden form field and turned into a managed file when the entity form is saved. Browsers without the Web Audio / MediaRecorder APIs simply see the standard file-upload control, so the widget degrades gracefully. A per-widget "Maximum Recording Time" setting caps recording length. The module also rewrites saved audio file links into inline `<audio>` players for preview on the form. An optional submodule, Audio Recorder Webform Integration, exposes the same recorder as a Webform "Audio recorder" file element. Because recording needs `getUserMedia`, the site should be served over HTTPS, and the vmsg library must be installed into the site's `libraries/` directory (see the module README for the required composer.json tweaks and the `.wasm` MIME-type note).

---

- Let users record a pronunciation of their name into a "Name pronunciation" file field on their user profile.
- Collect short spoken introductions or bios from members during registration or profile editing.
- Gather audio testimonials or reviews attached to a content type.
- Capture spoken answers to survey or interview questions via a Webform (with the submodule).
- Let language-course students submit spoken exercises as MP3 recordings on a node.
- Record voice notes or reminders attached to case-management or CRM entities.
- Collect audio feedback on articles or products directly in an editorial form.
- Capture spoken consent statements alongside a form submission.
- Let podcast or radio contributors record and submit clips without external tools.
- Record pronunciation guides for glossary/dictionary terms.
- Provide an in-browser voicemail-style message field on a contact or support form.
- Capture field-worker audio observations from a mobile browser.
- Let event attendees record spoken questions ahead of a Q&A session.
- Collect audio answers in accessibility scenarios where typing is difficult.
- Record short audio ads or announcements submitted by community members.
- Let musicians or performers submit quick demo takes into a submission form.
- Capture spoken translations or interpretations attached to translatable content.
- Add a "record a message" step to a Webform-based booking or intake flow.
- Let editors attach a spoken editorial note to a piece of content in the edit form.
- Collect audio pronunciations of place names or product names for internationalization.
- Provide a fallback file upload for users on unsupported browsers while offering recording to everyone else.
- Cap recording length (e.g. 45 seconds) to keep submissions short and storage predictable.
- Preview recordings inline with an HTML5 audio player before the form is submitted.
- Store recordings in a private file field when the audio is sensitive.
