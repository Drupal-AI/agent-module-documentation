<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor Braille lets editors write Braille directly in CKEditor 5: letter combinations are mapped to Braille Unicode characters, and a toolbar toggle switches Braille input on and off. It also bundles a practice course/quiz and supports formatted text and math operations in Braille.

The module provides a CKEditor 5 plugin (added to a format's toolbar via a Braille icon), a text-format **filter** (`BraillePreview`) that renders stored Braille in output, and an **Exercise** page (`/ckeditor-braille/exercise`, `access content`) offering practice challenges. The letter→Braille key mapping is handled by the JS plugin (the classic `f d s j k l` keys); the per-format settings form instead configures **API** (method/URL/skip-paths for fetching challenge data), **UI** (strict-input warning, auto-insert, clear/evaluate button selectors, prevent-enter/delete, special-characters), and **Speech** (pitch/rate/voice) options. Setup: install CKEditor 5, create/edit a CKEditor 5 text format, drag the Braille button into the toolbar, then optionally tune the Braille Settings fieldset.

The Exercise route is a read-only practice page. There is no admin configuration beyond the per-format toolbar/filter/mapping settings; a dev workflow (`npm install`, `npm run watch`) is documented for building the JS.
---
Add the Braille button to a CKEditor 5 toolbar and map letter combos; editors then type Braille and can practise on the exercise page.
---
- Write Braille inside the CKEditor 5 editor
- Toggle Braille input on and off from the toolbar
- Map letter combinations to Braille Unicode values
- Use different Braille mappings per text format
- Render Braille in output via the text-format filter
- Offer a Braille practice course to learners
- Run a Braille quiz/challenge on the exercise page
- Compose Braille math operations
- Mix formatted text with Braille content
- Add the Braille button to a specific toolbar
- Support accessible content authoring workflows
- Preview Braille as it will render
- Teach Braille interactively via `/ckeditor-braille/exercise`
- Configure mappings in the text format configuration
- Build/watch the plugin JS during development