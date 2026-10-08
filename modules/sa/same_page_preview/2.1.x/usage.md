<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Same Page Preview shows a live preview of the node being edited in a pane beside the form, instead of replacing the form with a full-page preview.

---

Drupal's preview takes the editor away from the form: press Preview, look at the rendered page, press Back to content editing, find where you were. For a short node that is a mild irritation and for a long one built from paragraphs it is a genuine obstacle, because the loop between changing something and seeing the effect is where editorial work actually happens — and a loop that costs two page loads and a scroll is a loop people stop using, which is how content ships without anyone having looked at it rendered. A side-by-side pane removes the round trip. Version **2.1.4** on core `^10 || ^11`. **This release fatals on Drupal 11.4.** `PreviewPaneController::$formBuilder` is typed `FormBuilderInterface` while core's `NodePreviewController`, which it extends, declares the property `?FormBuilderInterface` — nullable, because core made the constructor argument optional in 11.4 with a deprecation for callers that omit it. PHP rejects the narrowed property type and fatals on class load; verified on a clean install, where `drush pm:uninstall` itself could not run and the module had to be removed from `core.extension` by a direct configuration edit. The fix upstream is one character. Until then the module cannot be enabled on 11.4, and a site already running it will break on the core update rather than at install time, which is the worse order for a discovery.

---

- Preview a node beside the edit form.
- See changes without leaving the form.
- Preview a paragraph-built page live.
- Reduce the edit-preview round trip.
- Check rendering while editing.
- Preview a long article efficiently.
- Support a design-led editing flow.
- See a layout while editing fields.
- Reduce editorial iteration cost.
- Preview a landing page's components.
- Check a teaser while writing it.
- Support editors working visually.
- Preview without losing form state.
- Improve a complex content type's editing.
- Check responsive rendering while editing.
- Reduce publish-and-check cycles.
- Preview a translation side by side.
- Support a marketing page build.
