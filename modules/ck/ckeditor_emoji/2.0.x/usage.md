<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor(5) Emoji adds an **Emoji** toolbar button to the CKEditor 5 rich-text editor so content authors can browse or search a categorised emoji picker and insert emoji characters straight into their text.

---

The module ships a self-contained CKEditor 5 JavaScript plugin (`emojiPlugin.Emoji`, exposed to Drupal as the `ckeditor_emoji_Emoji` CKEditor5 plugin definition). It has **no PHP**: no settings form, no configure route, no permissions, no config schema, no Drush, and no Drupal plugin types — its only footprint is the toolbar button it contributes to CKEditor 5. You enable it purely by adding the **Emoji** button to a text format's CKEditor 5 toolbar on the *Text formats and editors* admin page; the button then appears for anyone editing with that format. Clicking it opens a dropdown with a search box, a category navigation strip (Smileys & People, Nature, Food, Activity, Places, Objects, Symbols, Flags), and a grid of emoji; picking one inserts the emoji as a normal Unicode character via CKEditor's `input` command. Because the plugin declares `elements: false`, it introduces no new HTML tags or data-model markup — the emoji is just text, so no text-format filter changes or extra allowed-tags are required. It depends on Drupal core's `ckeditor5` module and works only with CKEditor 5 (it is the CKEditor 5 successor to the older CKEditor 4 "Emoji" module).

---

- Add an emoji picker button to the Full HTML editor toolbar for blog authors.
- Let editors insert 😀 smileys into node bodies without copy-pasting from another app.
- Enable emoji only on a specific text format (e.g. a "Social post" format) and not on others.
- Give comment authors an emoji button if comments use a CKEditor 5 format.
- Search emoji by name ("rocket", "heart") inside the editor instead of scrolling a full list.
- Browse emoji by category (People, Nature, Food, Activity, Travel, Objects, Symbols, Flags).
- Insert flag emoji into multilingual landing-page copy.
- Add expressive emoji to marketing call-to-action text edited in CKEditor 5.
- Provide an emoji button on a custom "Announcement" text format used in a block.
- Insert food and drink emoji into a restaurant site's menu descriptions.
- Standardise emoji entry across an editorial team via one toolbar configuration.
- Allow emoji in field widgets (any long-text field using a CKEditor 5 format).
- Insert emoji as plain Unicode text so it renders anywhere without special markup or filters.
- Avoid granting any extra permission — the button is available to anyone who can use the format.
- Migrate from the CKEditor 4 "Emoji" module to a CKEditor 5-native equivalent.
- Add emoji support to a text format without changing its allowed HTML tags.
- Offer a familiar emoji-picker UX (grid + search) inside Drupal's authoring interface.
- Put the Emoji button anywhere in the toolbar order, including inside a toolbar group.
- Enable emoji on a "Basic HTML" format upgraded to CKEditor 5.
- Insert symbols and object emoji (✅, ⭐, 📎) as quick visual markers in content.
- Keep the editor lightweight — the plugin is a single pre-built, minified JS asset.
- Let non-technical authors add emoji without knowing Unicode code points.
- Provide emoji entry for taxonomy term or custom-entity description fields using CKEditor 5.
- Remove the Emoji button from a format simply by dragging it out of the active toolbar.
