<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Y Layout Builder Accordion provides a collapsible-panel block type for YMCA Layout Builder pages.

---

The accordion is how a location page handles the questions everyone asks — membership options, opening arrangements, programme details — where each answer is self-contained and showing all of them at once would bury the page.

It suits independent items and suits narrative badly, because collapsing prose hides the thread a reader is following.

The accessibility requirements are specific and are the part most often missed: each header must be a real button rather than a styled div, carrying `aria-expanded` that reflects state and `aria-controls` pointing at its panel, with the panel reachable by keyboard. A click-only accordion is content a keyboard user cannot open at all. Verify those against what the block actually renders.

Worth deciding whether the first panel starts open. Everything closed is tidy and hides content from readers who are scanning and from search-result snippets; the first panel open signals the pattern without costing much.

**This module cannot be enabled as composer resolves it, and the cause is now familiar.** It depends on `y_lb` (Y Layout Builder), and `ycloudyusa/y_lb` on Packagist has exactly one published version — **0.1, from 2022**, declaring `core_version_requirement: ^8 || ^9`. The current releases (3.x, 4.x, 5.x) live in the YMCA's own composer repository, which this campaign does not add.

Modules in this family that require `y_lb` **without a version constraint** install cleanly and then fail at enable time with *"Its dependency module 'y_lb' is incompatible with this version of Drupal core."* Modules that **do** constrain it — `ws_event` requires `^4.0 || ^5.0` — fail earlier and more usefully, at composer time with a resolvable explanation. The stricter-looking module behaves better.

Add the YMCA composer repository before requiring anything in this family. See `modules/y_/y_lb` for the full characterisation.

---

- Present frequently asked questions.
- Group membership options.
- Show programme details collapsibly.
- Fit many answers on one page.
- Avoid collapsing narrative prose.
- Make accordion headers real buttons.
- Set aria-expanded to reflect state.
- Point aria-controls at the panel.
- Ensure keyboard operation.
- Decide whether the first panel starts open.
- Consider search snippet visibility.
- Add the YMCA composer repository.
- Diagnose a y_lb core incompatibility.
- Audit accordions for accessibility.
- Document the module's behaviour for the team.
- Review it during a site audit.
- Verify its assumptions after an upgrade.
