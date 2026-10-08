<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VLSuite Block CTA is the call-to-action component — a heading, supporting text and a button.

---

The call to action is the component a landing page exists for, and the one most likely to be rebuilt per project because "ours is different". Shipping it as a block type with defined fields settles the structure: a heading, some text, a link rendered as a button, and the suite's per-instance styling options.

Settling the structure is what makes the rest work. A CTA with known fields can be styled consistently, restricted to certain sections, translated, reported on and — because it is a `block_content` entity — made reusable so one campaign message appears in twenty places and is edited once.

The thing to decide per site is how much visual variation the CTA needs. Utility classes cover a lot of it; if a project genuinely needs three visually distinct CTAs, that is a design conversation before it is a Drupal one, because three block types is where a component library starts to sprawl.

---

- Add a call to action to a landing page.
- Place a primary CTA above the fold.
- Render a link as a styled button.
- Reuse one campaign CTA across pages.
- Edit a shared CTA in one place.
- Restrict CTAs to certain sections.
- Translate a call to action.
- Style a CTA with utility classes.
- Track which pages carry a CTA.
- Vary CTA appearance per instance.
- Keep CTA structure consistent sitewide.
- Avoid a new block type per CTA variation.
- Revision CTA copy.
- Report on CTA usage.
- Give editors a defined CTA component.
