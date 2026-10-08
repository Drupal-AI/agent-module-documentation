<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Library Translate adds a translate button to the Media Library widget, so an editor who has just selected an image can translate its metadata — alt text, name, caption — without leaving the form they are filling in.

---

On a multilingual site, media metadata needs translating: the alt text that describes an image in English is useless to a French reader, and it lives on the media entity rather than on the node using it. The normal route to fix that is to abandon the node form, navigate to the media entity, find its translations tab, translate, and come back — which is enough friction that in practice it does not happen, and sites end up with English alt text across every language. This module puts the action where the decision is made: `js/media_library_translate.js` adds a button to the selected item in the widget, with `icons/translate.svg` and an admin stylesheet. It is a small module — no `src/` directory at all, no routes, permissions or configuration — depending on core `media`, `media_library` and `content_translation`, with a range of `^9 || ^10 || ^11`. Nothing about translation behaviour changes; it is a shortcut to the translation UI that already exists, which is the reason it is cheap to adopt and cheap to drop.

---

- Translate an image's alt text from the node form.
- Reduce friction in a multilingual editorial workflow.
- Avoid leaving a form to translate media.
- Keep alt text meaningful in every language.
- Translate a media item's name.
- Improve accessibility on translated pages.
- Prompt editors to translate media they select.
- Reach the media translations tab quickly.
- Reduce untranslated media metadata.
- Support a translation team's workflow.
- Translate captions alongside content.
- Improve consistency across language versions.
- Reduce editor training on media translation.
- Fix missing translations at the point of use.
- Support a bilingual institution's media library.
- Encourage per-language descriptions.
- Keep media metadata current in all languages.
- Improve SEO for translated pages.
