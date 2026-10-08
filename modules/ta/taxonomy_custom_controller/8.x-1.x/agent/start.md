<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Taxonomy Custom Controller (taxonomy_custom_controller) — agent index

Takes over the taxonomy term canonical route and dispatches an event while building the page, so any
module can decide what a term page renders without patching core or writing its own route subscriber.
The mechanism is two pieces: `EventSubscriber/RouteAlterSubscriber` repoints the `_controller` default
of `entity.taxonomy_term.canonical` to `Controller/TaxonomyCustomController::build` (on
`RoutingEvents::ALTER`, priority `-200`, so it runs after other route work such as the core Views
override), and that controller fires `TermPageBuildEvent` (event name
`taxonomy_custom_controller.term_page_build`). A subscriber that calls `$event->setBuildArray($build)`
wins; if none does, the controller falls back to embedding the `taxonomy_term` view (`page_1`
display), and if that view is disabled/removed it falls back again to rendering the term entity in its
default view mode.

The whole public API is one event. There are no routes, permissions, config, plugin types, services
(beyond the internal event subscriber), or drush commands of its own. Extend it by subscribing to
`TermPageBuildEvent`; read the term with `$event->getTaxonomyTerm()` and return a render array with
`$event->setBuildArray()`. The route alter only changes `_controller` — it never touches the route's
access requirements, so the term page keeps whatever access requirement is on the route (core's
`_entity_access: taxonomy_term.view`, or the `taxonomy_term` view's access when Views overrides the
route).

- Depends on: `drupal:taxonomy`, `drupal:views` (info.yml).
- Core: `^9 || ^10 || ^11`.
- Package: none declared.
- Settings page / configure route: none.
- Permissions: none. Drush: none. Config schema: none. Plugin types: none.
- Submodule: `taxonomy_custom_controller_example` (optional, demo only) — a `TermPageBuildSubscriber`
  that adds a "hello" markup line plus the term description above the embedded `taxonomy_term` view for
  every term. Enable it only to see the pattern; do not enable it on a real site.

## What you'd do → where
- Change what a term page renders from a module → [api/term-page-event.md](api/term-page-event.md)
- Understand the controller build order / fallbacks → [api/term-page-event.md](api/term-page-event.md)
- Understand the route override and its priority → [api/term-page-event.md](api/term-page-event.md)

## Key facts (real machine names)
- Event name constant: `TaxonomyCustomControllerEvents::PAGE_BUILD` = `taxonomy_custom_controller.term_page_build`.
- Event class: `Drupal\taxonomy_custom_controller\Event\TermPageBuildEvent`
  (`getTaxonomyTerm(): TermInterface`, `getBuildArray(): array`, `setBuildArray(array): void`).
- Controller: `Drupal\taxonomy_custom_controller\Controller\TaxonomyCustomController::build($taxonomy_term)`.
- Route altered (not created): `entity.taxonomy_term.canonical` — only its `_controller` default is replaced.
- Service (internal): `taxonomy_custom_controller.route_alter_subscriber`
  (`EventSubscriber/RouteAlterSubscriber`, `event_subscriber` tag).
- Example submodule service: `taxonomy_custom_controller_example.term_page_build_subscriber`.
- Views display the controller embeds on fallback: view `taxonomy_term`, display `page_1`.
