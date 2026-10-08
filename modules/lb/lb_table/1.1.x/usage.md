<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Y Layout Builder Table provides a table block type for YMCA Layout Builder pages.

---

Tables are how a location publishes a schedule, a price list or a comparison, and they are the component that most needs to be structured data rather than pasted markup — a table an editor maintains in a WYSIWYG drifts, loses its header row and becomes unreadable on a phone.

As a block type the structure is enforced, and the two things that decide whether a table is usable can be handled once rather than per page: real header cells with the right scope, so a screen reader announces context rather than a stream of values; and a deliberate responsive strategy, since horizontal scrolling preserves comparison while stacking rows destroys it, and the wrong choice makes the data harder to use than a list would have been.

Its `datalayer` dependency is worth noticing — it suggests table interactions are reported to analytics, which is a data-collection decision as much as a measurement one.

**This module cannot be enabled as composer resolves it, and the cause is now familiar.** It depends on `y_lb` (Y Layout Builder), and `ycloudyusa/y_lb` on Packagist has exactly one published version — **0.1, from 2022**, declaring `core_version_requirement: ^8 || ^9`. The current releases (3.x, 4.x, 5.x) live in the YMCA's own composer repository, which this campaign does not add.

Modules in this family that require `y_lb` **without a version constraint** install cleanly and then fail at enable time with *"Its dependency module 'y_lb' is incompatible with this version of Drupal core."* Modules that **do** constrain it — `ws_event` requires `^4.0 || ^5.0` — fail earlier and more usefully, at composer time with a resolvable explanation. The stricter-looking module behaves better.

Add the YMCA composer repository before requiring anything in this family. See `modules/y_/y_lb` for the full characterisation.

---

- Publish a schedule as a table.
- Show a price list.
- Present a comparison table.
- Keep tabular data structured.
- Use real header cells with scope.
- Give the table an accessible name.
- Choose a responsive strategy deliberately.
- Preserve comparison on small screens.
- Avoid hand-maintained WYSIWYG tables.
- Notice the datalayer analytics dependency.
- Add the YMCA composer repository.
- Diagnose a y_lb core incompatibility.
- Constrain y_lb explicitly in a project.
- Audit tables for header markup.
- Document the module's behaviour for the team.
- Review it during a site audit.
- Verify its assumptions after an upgrade.
