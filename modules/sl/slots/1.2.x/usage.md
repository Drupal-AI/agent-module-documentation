<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Slots provides named content placeholders that "push" condition-matched content blocks into a page, letting editors fill layout positions without exporting that content into configuration.

---

A slot is a lightweight identifier plus a cardinality (how many blocks it may render). You place a slot via the Block UI, Layout Builder, Views (header/footer), a Paragraph, or a `slot()` Twig function, then create content blocks that carry a "slot" field; each such block is shown in a slot when its configured conditions (including a Slot condition matching the identifier) are met. `SlotsService` evaluates conditions against the current context, loads the matching blocks and renders them through the block_plugin_view_builder, caching results. A `Slot` content entity (admin routes under `/admin/content/slots`, gated by `administer slots`) records where slots exist; a `ControllerAlterSubscriber` injects an "Add slot" create link into the Layout Builder choose-block screen.

Permissions separate concerns: `administer slots` (restricted) manages slot entities, `access slot library` views the overview, `view slot identifiers` surfaces slot locations/interactions, and `create slots` allows creating slot IDs from UI integrations. There are no anonymous mutation endpoints — front-end rendering is read-only condition evaluation, and an internal slot-id query uses `accessCheck(FALSE)` only for looking up config-like slot identifiers. Submodules add Paragraphs, Views, Twig and test integrations. Set-up: place a slot, add the "Slots" field to a block type, then create content blocks with a Slot condition.

---

- Place a content placeholder in a region via the Block UI.
- Add a slot in Layout Builder using the injected "+ Add slot" link.
- Add a slot to a View's header or footer.
- Add a slot inside a Paragraph (via slots_paragraphs).
- Add a slot in a Twig template with `{{ slot(slot_id, cardinality) }}` (via slots_twig).
- Set a slot's cardinality to limit how many blocks it renders.
- Reuse the same slot identifier across multiple contexts.
- Push a CTA block into a slot based on node type conditions.
- Show condition-matched content without exporting it to config YAML.
- Add the "Slots" field to a block content type.
- Flag a content block to display in slots and configure its conditions.
- Target a slot by adding a matching "Slot" condition to a block.
- Manage slot entities at `/admin/content/slots` (permission `administer slots`).
- View a slot overview with `access slot library`.
- Surface where slots exist on the page with `view slot identifiers`.
- Allow UI creation of new slot IDs with `create slots`.
- Cache rendered slot content for performance.
- Swap slot content later without redeploying configuration.