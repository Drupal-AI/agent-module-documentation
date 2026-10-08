<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Name Pronunciation (name_pronunciation) — agent index

**Provides a field type, browser recorder widget and audio-player formatter for name pronunciations.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11
- **Field plugins:** `NamePronunciationItem` (field type), `NamePronunciationRecorderWidget` (widget), `NamePronunciationPlayerFormatter` (formatter).
- **Theme:** `name_pronunciation_audio_player` (audio_url, file_mime_type, button_text, description, written_pronunciation).
- **Routes/permissions:** none.

**Security:** Pure field-plugin module; no routes, permissions or HTTP endpoints. Access is entirely governed by the host entity's field access. No security findings.
