<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Permissions DragCheck lets an administrator tick a run of permission checkboxes by clicking and dragging across them on the core permissions page.

---

The core permissions page (`admin/people/permissions`) on a site with many modules is a grid of thousands of checkboxes, and setting up a role means clicking a great many of them one at a time. Permissions DragCheck is a small, focused UX improvement for exactly that task: **click and drag across a column or run of checkboxes to tick them all in one gesture**, with each cell tinted green when checked and lemon when unchecked so the current state is easy to read. It is **JavaScript only** — no permissions, no routes, no settings page, no configuration — and it changes nothing about what the permissions page does or how permissions are saved; core still handles the actual grant on form submit, so it is a pure client-side speed-up layered on the standard form. Enable the module, then place scarlac's third-party `drag-check-js` library into `/libraries/drag-check-js/` (via Composer as a `type: package`, or manually) so the browser can load `/libraries/drag-check-js/dist/jquery.dragcheck.js`; without that library the module still enables cleanly but the drag gesture simply does nothing. It pairs well with the *Permissions filtered by modules* (`pfm`) contrib module, which adds a per-module filter to the same page.

---

- Tick a run of permission checkboxes quickly by click-and-drag.
- Configure a new role faster on the permissions page.
- Reduce individual clicking on a large permissions grid.
- Set up all permissions at the start of a project.
- Grant a module's whole block of permissions to a role in one gesture.
- Read cell colours (green = checked, lemon = unchecked) to see the current state at a glance.
- Speed up repetitive admin work on `admin/people/permissions`.
- Avoid mis-clicks when scanning a dense checkbox grid.
- Use it as a lightweight alternative to the FPA (Fast Permissions Administration) module.
- Enable the module without adding any Drupal module dependencies.
- Install scarlac's drag-check-js library into `/libraries` via Composer as a `type: package`.
- Keep the standard core permission-save behaviour unchanged while speeding up input.
- Combine with the `pfm` module to filter the permissions grid by module.
- Roll out to admins who manage permissions across many roles.
- Review the resulting role after a bulk change to confirm what was granted.
- Export configuration so a permissions change appears in a reviewable diff.
