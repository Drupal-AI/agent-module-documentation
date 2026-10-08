<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EPT Micromodal adds a ready-made "button that opens an accessible popup dialog" paragraph type built on the Micromodal.js library, part of the Extra Paragraph Types family.

---

Enabling the module creates one Paragraphs bundle, **`ept_micromodal`** ("EPT Micromodal"), that an editor adds to content through any Paragraphs field. The paragraph holds an optional page-level **Title**, a **Micromodal Title** (the dialog's header), a **Text** body (the dialog's content, with a WYSIWYG editor), and a **Settings** tab. On the Settings tab the editor chooses the trigger **button text**, whether the trigger renders as a **link or a button**, the **close-button text**, whether to **disable page scrolling** while the modal is open, and whether to show the header **"X" close icon** — plus the shared EPT **Design options** (margins, padding, border, background color/image/video, edge-to-edge, container width) that come from `ept_core`. At render time the template outputs the trigger and a `MicroModal`-compatible modal keyed by the paragraph id, ept_core passes the settings to `drupalSettings`, and `js/ept-micromodal.js` initialises Micromodal (respecting the disable-scroll option). It depends on `ept_core` and `paragraphs`, and Composer additionally pulls `levmyshkin/micromodal` into `/libraries/micromodal/`; core requirement is `^10.1 || ^11 || ^12`. There is no module settings page, no permissions and no Drush — install with `drush en ept_micromodal` (or via the UI), then add the paragraph to a content type that has a Paragraphs field. The EPT-wide Primary/Secondary colors and Mobile/Tablet/Desktop breakpoints live on the shared `ept_core` settings form at Administration » Configuration » Content authoring » Extra Paragraph Types (EPT) settings.

---

- Add a button-that-opens-a-popup element to a page as a paragraph.
- Show a privacy policy, terms, or long disclaimer in a modal instead of inline.
- Reveal extra detail (specs, fine print, help text) on demand without leaving the page.
- Present a call-to-action that opens a dialog.
- Render the trigger as a text link or as a styled button.
- Set custom trigger text (for example "Read more" or "Open").
- Set custom close-button text in the modal footer.
- Give the modal its own header title, separate from the page heading.
- Author the modal body with the site's WYSIWYG editor and text formats.
- Show or hide the header "X" close icon.
- Disable background page scrolling while the modal is open.
- Rely on Micromodal's accessible dialog markup (focus trap, ARIA roles, ESC/overlay close).
- Apply shared EPT design options (background, spacing, border, container width) to the paragraph.
- Add an optional heading above the trigger via the paragraph's Title field.
- Reuse the modal paragraph on any content type that has a Paragraphs field.
- Pair it with other EPT paragraph types on the same page.
- Give editors a ready-made modal without writing custom JavaScript.
- Install just this EPT paragraph type without the rest of the family.
- Translate the modal header title (the field is translatable).
- Backfill the close-icon setting on old paragraphs via the shipped update hook.
