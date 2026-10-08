<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Y Layout Builder Accordion provides a collapsible-panel block type for YMCA Layout Builder pages.

---

The accordion is how a location page handles the questions everyone asks — membership options, opening arrangements, programme details — where each answer is self-contained and showing all of them at once would bury the page.

It suits independent items and suits narrative badly, because collapsing prose hides the thread a reader is following.

The block (`lb_accordion`) holds an ordered list of `accordion_item` sub-blocks, each a title plus a body. An "Is FAQ?" checkbox, when set, emits a `FAQPage` JSON-LD schema into the page head so a single accordion of question/answer pairs can be surfaced as structured data — Google's guidance is to add only one FAQ per page, and the schema is emitted on the rendered page, not in the Layout Builder preview.

The accessibility requirements are specific and are the part most often missed: each header is a real button carrying `aria-expanded` that reflects state and `aria-controls` pointing at its panel, with the panel reachable by keyboard. A click-only accordion is content a keyboard user cannot open at all. Worth deciding whether the first panel starts open — the template opens the first item by default.

**Diff 3.0.x → 3.1.x.** This is a new major (3.1.0). The project title in `lb_accordion.info.yml` is now "Y Layout Builder - Accordion **Block**". The `.info.yml` dependency list is now explicit — `drupal:paragraphs`, `drupal:block_content`, `y_lb` — and `composer.json` now constrains the layout-builder base package to `ycloudyusa/y_lb: ^4.0 || ^5.0` (alongside `drupal/entity_reference_revisions` and `cweagans/composer-patches`), with `php: >=8.1`. Core support is unchanged (`^9 || ^10 || ^11`). Because it pins `y_lb ^4.0 || ^5.0`, Composer fails early and legibly rather than at enable time if the YMCA repository is missing (see the installation note). No breaking change to the block's own fields or Twig contract; existing `accordion_item` content carries forward.

**This module cannot be enabled as composer resolves it, and the cause is now familiar.** It depends on `y_lb` (Y Layout Builder), and `ycloudyusa/y_lb` on Packagist has exactly one published version — 0.1, from 2022, declaring `core_version_requirement: ^8 || ^9`. The current releases (3.x, 4.x, 5.x) live in the YMCA's own composer repository, which this campaign does not add. Add the YMCA composer repository before requiring anything in this family. See `modules/y_/y_lb` for the full characterisation.

---

- Present frequently asked questions.
- Emit FAQPage JSON-LD structured data with the "Is FAQ?" flag.
- Add only one FAQ accordion per page for valid structured data.
- Group membership options.
- Show programme details collapsibly.
- Fit many answers on one page.
- Avoid collapsing narrative prose.
- Make accordion headers real buttons.
- Set aria-expanded to reflect state.
- Point aria-controls at the panel.
- Ensure keyboard operation.
- Decide whether the first panel starts open.
- Add a section subtitle above the items.
- Consider search snippet visibility.
- Add the YMCA composer repository.
- Diagnose a y_lb core incompatibility.
- Note the new y_lb ^4.0 || ^5.0 composer constraint on upgrade.
- Audit accordions for accessibility.
- Document the module's behaviour for the team.
- Review it during a site audit.
- Verify its assumptions after an upgrade.
