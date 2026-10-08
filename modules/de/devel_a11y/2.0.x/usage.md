<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Devel Accessibility extends Devel with front-end debugging aids for accessibility: it logs what Drupal announces to screen readers, logs tabbing-manager activity, and can visualise which elements are currently in the tab constraint.

---

Drupal's JavaScript has two accessibility mechanisms that are invisible when you look at a page: `Drupal.announce()` pushes messages into an ARIA live region, and the tabbing manager constrains keyboard focus to part of the page (for modals, off-canvas dialogs and similar). Bugs in either are hard to spot because nothing is rendered. This module makes them observable. Three settings, stored in `devel_a11y.settings`, control it: `aural.announce.log` writes every `Drupal.announce()` call to the browser console, `keyboard.tabbingmanager.log` does the same for tabbing-manager activity, and `keyboard.tabbingmanager.visualize` draws the current tabbing constraint on screen so you can see exactly which region has focus trapped. All three default to on. The settings form lives at `/admin/config/development/devel/a11y` behind Devel's own `access devel information` permission, and the JS/CSS are attached through an OO `#[Hook('page_attachments')]` implementation so they load only when enabled. Being a Devel add-on it requires `devel` and targets recent core (`^11.2 || ^12`).

---

- See what a screen reader would be told when a page updates.
- Debug a missing or duplicated `Drupal.announce()` message.
- Verify that an AJAX update announces its result.
- Watch the tabbing manager engage when a modal opens.
- Visualise which region currently traps keyboard focus.
- Diagnose a focus trap that never releases.
- Check that off-canvas dialogs constrain tabbing correctly.
- Test accessibility of a custom JavaScript component.
- Confirm announcements fire once, not on every keystroke.
- Teach developers how Drupal's a11y JS works.
- Review a contrib module's announcement behaviour.
- Catch regressions in focus management during upgrades.
- Debug keyboard navigation on a complex admin form.
- Pair with automated a11y tests for manual verification.
- Log announcements while running a manual test script.
- Turn individual aids on or off from a settings form.
- Restrict the aids to developers via Devel's permission.
- Check announcement timing relative to DOM updates.
- Investigate why a screen reader misses a status message.
- Demonstrate accessibility behaviour in code review.
