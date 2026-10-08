<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Website Services Event provides the event content type and its Layout Builder integration for YMCA sites.

---

Events are most of what a community organisation publishes — classes, camps, fundraisers, open days — and each needs a date, a location, a registration path and a page someone will actually read. Modelling that as a content type with Layout Builder means the structured parts stay queryable (so listings, calendars and filters work) while the page itself can be composed per event.

The tension worth naming is between those two. Structured event data is what makes a site's event listing useful; a freely composed page is what makes an individual event compelling. A content type that offers both has to be clear about which fields are authoritative — a date typed into a text block is invisible to the calendar that should be showing it.

**Unlike its siblings this module constrains its dependency**, requiring `ycloudyusa/y_lb ^4.0 || ^5.0`, and that is why it failed at **composer** time with a resolvable explanation rather than at enable time with a confusing one. Packagist publishes only `y_lb` 0.1, so the constraint cannot be satisfied without the YMCA's own composer repository. The stricter module gave the better error — worth remembering when writing constraints.

**This module cannot be enabled as composer resolves it, and the cause is now familiar.** It depends on `y_lb` (Y Layout Builder), and `ycloudyusa/y_lb` on Packagist has exactly one published version — **0.1, from 2022**, declaring `core_version_requirement: ^8 || ^9`. The current releases (3.x, 4.x, 5.x) live in the YMCA's own composer repository, which this campaign does not add.

Modules in this family that require `y_lb` **without a version constraint** install cleanly and then fail at enable time with *"Its dependency module 'y_lb' is incompatible with this version of Drupal core."* Modules that **do** constrain it — `ws_event` requires `^4.0 || ^5.0` — fail earlier and more usefully, at composer time with a resolvable explanation. The stricter-looking module behaves better.

Add the YMCA composer repository before requiring anything in this family. See `modules/y_/y_lb` for the full characterisation.

---

- Publish events on a community site.
- Model an event with structured dates.
- Compose an individual event page.
- Keep event data queryable for listings.
- Feed a calendar from event fields.
- Link an event to a registration path.
- Decide which fields are authoritative.
- Avoid dates typed into text blocks.
- Filter events by location.
- Add the YMCA composer repository.
- Read a composer-time failure rather than an enable-time one.
- Constrain a dependency to get a better error.
- Diagnose a y_lb resolution failure.
- Plan an events architecture.
- Document the module's behaviour for the team.
- Review it during a site audit.
- Verify its assumptions after an upgrade.
