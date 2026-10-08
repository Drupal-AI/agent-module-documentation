<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
IXM Blocks Modal opens content in a dialog over the page.

---

A modal is right when the content is a detour: a form the visitor chose to open, a larger image, a confirmation. It is wrong as a way to deliver something the visitor did not ask for, which is what an on-load promotional modal is — and those are consistently the most disliked pattern on the web.

**Focus management is what makes or breaks it, and it is four specific behaviours.** Focus must move into the dialog when it opens; it must not escape to the page behind while open; Escape must close it; and focus must return to whatever opened it. Get any of those wrong and a keyboard or screen reader user is trapped in a dialog they cannot leave — which is worse than the modal simply not working.

Verify all four against the shipped implementation rather than assuming, and check the same behaviours for anything the modal contains, since a form inside a trapped dialog cannot be submitted either.

---

- Open content in a dialog.
- Show a larger image over the page.
- Present a form the visitor opened.
- Confirm a destructive action.
- Avoid an unrequested on-load modal.
- Verify focus moves into the dialog.
- Verify focus cannot escape while open.
- Confirm Escape closes the dialog.
- Confirm focus returns on close.
- Avoid trapping keyboard users.
- Test a form inside a modal.
- Style the dialog with the theme.
- Test with a screen reader.
- Audit dialog accessibility.
- Decide what belongs in a modal.
