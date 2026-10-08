<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VLSuite Modal provides the modal dialogs the suite uses — both for front-end components and for the Layout Builder editing experience.

---

Two quite different needs share one implementation here. On the front end, a component may open content in a dialog — a video, a form, a larger image. In the editing UI, `vlsuite_layout_builder` uses modals so editing a block does not hide the page behind a sidebar.

Sharing the implementation is the right call: a site gets one set of dialog behaviours, one focus-management implementation and one set of styles, rather than the editing modals and the front-end modals diverging.

**Focus management is what makes or breaks a modal.** When it opens, focus must move into it; while it is open, focus must not escape to the page behind; Escape must close it; and on close, focus must return to whatever opened it. A modal that gets this wrong is not merely awkward — for a keyboard or screen-reader user it can be a trap with no way out. Verify all four behaviours on the shipped implementation, on both the front-end and editing surfaces.

---

- Open a video in a modal.
- Show a form in a dialog.
- Display a larger image in a modal.
- Edit a block in a modal rather than a sidebar.
- Keep the page visible while editing.
- Share one dialog implementation sitewide.
- Verify focus moves into the modal.
- Verify focus does not escape while open.
- Confirm Escape closes the dialog.
- Confirm focus returns on close.
- Avoid a keyboard trap.
- Style modals with the site's CSS.
- Test modals with a screen reader.
- Use modals consistently across components.
- Audit dialog accessibility.