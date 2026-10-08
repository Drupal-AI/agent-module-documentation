<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Canvas External JS (canvas_extjs) — agent index

Adds an **external JavaScript component source** to Drupal Canvas.
Version **1.2.1**. Core `^11.2`. Depends on `canvas:canvas`.

**The trade to state:** the site renders code it does not version, review or control, and whoever
controls that JavaScript controls what runs in the page. Supply-chain decision, not a technical one
— known origin, change process, subresource integrity, and a **CSP naming allowed origins**.

**Documented from source — `canvas` could not be kept enabled.** Its SDC discovery runs
`ComponentMetadataRequirementsChecker` over every SDC component on the site and trips
`assert($property !== NULL)` on unresolvable field-type property expressions; with `zend.assertions`
on (DDEV default) that is a container-build fatal. **First seen in wave 85, recurred here against a
different module set** — a property of Canvas meeting any third-party SDC, not of one wave.