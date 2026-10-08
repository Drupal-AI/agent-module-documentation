<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Action Link Entity Links (action_link_entity_links) — agent index

Submodule of **action_link**. Outputs an action link's links in the **node/comment entity links**
area. Depends on `action_link` (and needs node or comment enabled). No permissions, no config schema.

## What it provides

- **Output plugin** `entity_links` (`src/Plugin/ActionLinkOutput/EntityLinks.php`,
  `#[ActionLinkOutput(id: "entity_links")]`, extends `ActionLinkOutputBase`). `appliesToActionLink()`
  returns TRUE only when the state action implements `EntityActionLinkInterface`, its dynamic
  parameters are exactly `['entity']`, and the target entity type is `node` or `comment`.
- **Hook class** `src/Hook/EntityLinksHooks.php` (autowired service, OOP `#[Hook]` attributes):
  `#[Hook('node_links_alter')]` and `#[Hook('comment_links_alter')]` both delegate to
  `entityLinksAlter()`.

## How it works

`entityLinksAlter()` loads action links via `storage->loadByUsingOutput('entity_links')`, checks each
plugin's `checkOperability()` for the entity, and for each direction registers a `#lazy_builder`
placeholder (hashed from entity type/id + action link id + direction). The lazy builder
`entityLinksLazyBuilder()` (`#[TrustedCallback]`) calls `buildLinkArray()` for the current user and
returns the single direction's build. A cache-tag dependency on the `action_link` entity list is
always added.

## Enable / operate

Enable the module; on an action link's **Output** tab check **Entity links**; ensure the entity
bundle's **Links** pseudo-field is shown in Manage Display. Access/CSRF for the links themselves are
enforced by the core `ActionLinkController` (see the parent module docs).

## Solution docs

- `agent/output/entity-links.md` — the output plugin and link-alter mechanics.
