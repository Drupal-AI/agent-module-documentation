<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Name Pronunciation provides a field type for recording and playing audio pronunciations of names.

---

The module ships a `name_pronunciation` field type (`src/Plugin/Field/FieldType/NamePronunciationItem.php`) that stores an audio file reference plus an optional written (phonetic) pronunciation. A recorder widget (`NamePronunciationRecorderWidget`) lets an author capture audio in the browser or upload a clip, and the player formatter (`NamePronunciationPlayerFormatter`) renders an accessible play button using the `name_pronunciation_audio_player` theme hook defined in the `.module` file.

It solves the accessibility and inclusivity problem of names that are easy to mispronounce — common on staff directories, author bios, speaker lists and profile pages. Add the field to any fieldable entity (typically a user or a "person" content type), configure the widget for recording, and choose the player formatter on the display. There are no routes, permissions or callbacks — it is a pure field-plugin module, so its security posture is governed entirely by the host entity's field access.

---
- Add a pronunciation field to a user profile
- Record a name pronunciation directly in the browser
- Upload a pre-recorded pronunciation clip
- Store a written/phonetic spelling alongside the audio
- Show a play button on author bio pages
- Add pronunciations to a staff directory
- Provide correct name audio for conference speakers
- Improve accessibility of people-focused content
- Let users self-record their own name
- Display a description/label next to the player
- Configure the button text for the player
- Attach pronunciation to a custom "person" content type
- Render the field in a Views listing
- Provide pronunciation guidance for customer service teams
- Include name audio in an alumni or member registry
- Expose the field in different view modes (teaser vs full)
