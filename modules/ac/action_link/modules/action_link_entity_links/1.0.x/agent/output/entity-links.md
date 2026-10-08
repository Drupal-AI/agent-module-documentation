<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# entity_links output plugin

## Plugin

`src/Plugin/ActionLinkOutput/EntityLinks.php` — `#[ActionLinkOutput(id: "entity_links", label:
"Entity links")]`, extends `Drupal\action_link\Plugin\ActionLinkOutput\ActionLinkOutputBase`.

`appliesToActionLink(ActionLinkInterface $action_link): bool` gates which action links may use it:
- state action must implement `EntityActionLinkInterface`,
- `getDynamicParameterNames()` must equal `['entity']` (only the entity is passed, so the module
  knows how to supply the parameter),
- `getTargetEntityTypeId()` must be `node` or `comment` (the only entity types with a links area).

Selecting this output on the action link's Output tab stores `entity_links` in the entity's `output`
sequence; `ActionLink::usesOutputPlugin('entity_links')` then reports TRUE.

## Link injection

`src/Hook/EntityLinksHooks.php` (autowired via `action_link_entity_links.services.yml`; deps:
`entity_type.manager`, `current_user`, `renderer`).

- `#[Hook('node_links_alter')]` / `#[Hook('comment_links_alter')]` → `entityLinksAlter(&$links,
  $entity, &$context)`.
- Adds a cache-tag dependency on the `action_link` entity list (`getListCacheTags()`) so adding /
  editing / deleting an action link invalidates these links, even when none currently use the plugin.
- Loads applicable action links with `entityTypeManager->getStorage('action_link')
  ->loadByUsingOutput('entity_links')`.
- For each action link (skipping those whose `checkOperability()` fails for the entity) and each
  direction, it creates a placeholder string `Crypt::hashBase64(...)` and registers
  `$links['#attached']['placeholders'][$placeholder]['#lazy_builder']` pointing at
  `EntityLinksHooks::entityLinksLazyBuilder`. The placeholder title is set as the link title so
  `theme_links` emits just the placeholder inside the `<li>`. (theme_links doesn't run child render
  arrays, so the module registers the lazy builder manually rather than via a `#lazy_builder` key.)

## Lazy builder

`entityLinksLazyBuilder($entity_type_id, $entity_id, $action_link_id, $direction)`
(`#[TrustedCallback]`): loads the entity and action link, builds all directions once with
`stateActionPlugin->buildLinkArray($action_link, currentUser, ['entity' => $entity->id()])`, caches
them on the instance, and returns the requested direction's build (with `#attached` moved up). If the
direction is not reachable it returns an empty build.

## Operate

Enable node and/or comment; set the bundle's **Links** pseudo-field to display; check **Entity
links** on the action link Output tab. Authorization/CSRF of a click is handled by the core
`ActionLinkController` (parent docs), not here. Known issue: the Output-locations option may not
appear until the action link is saved once.
