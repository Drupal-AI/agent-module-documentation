Adds the CKEditor 5 Find and Replace plugin, giving editors an in-editor dialog to search text and replace matches within the rich text field.

---

This submodule of CKEditor 5 Plugin Pack registers the Find and Replace editor plugin (class `Plugin/CKEditor5Plugin/FindAndReplace`), adding a toolbar button that opens a search/replace panel inside CKEditor 5. Editors can find all occurrences of a string, step through matches, and replace one or all of them without leaving the editor. It also provides a CKEditor 4-to-5 upgrade plugin (`Plugin/CKEditor4To5Upgrade/Find`) so existing formats that had the CKEditor 4 Find button migrate cleanly. Enable the submodule and add the button to a text format toolbar at Admin → Configuration → Content authoring → Text formats and editors. It depends on the base `ckeditor5_plugin_pack` module and ships its own config schema, icon and CSS.

---

- Find every occurrence of a word in a long article.
- Replace all instances of an outdated term at once.
- Fix a repeated typo across a large body field.
- Step through matches one at a time.
- Replace a single selected match while leaving others.
- Update a product name globally within one document.
- Search case-sensitively for exact matches.
- Locate a phrase quickly in lengthy legal text.
- Swap placeholder text for final copy before publishing.
- Correct consistent misspellings in imported content.
- Migrate a CKEditor 4 Find button to CKEditor 5 automatically.
- Clean up boilerplate before reuse.
- Update URLs or references mentioned in body text.
- Replace deprecated terminology site-wide, document by document.
- Search within table content.
- Give editors a familiar Ctrl+F-style workflow inside the editor.
- Add the Find and Replace button only to formats that need it.
- Speed up copyediting of long-form content.
- Standardize wording across knowledge-base pages.
- Reduce errors from manual scrolling and editing.
