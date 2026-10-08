<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Term page build event (API)

The module's only extension point. The term page is rendered by a custom controller that dispatches
one event; you subscribe to it and set the render array.

## Event

- Name constant: `Drupal\taxonomy_custom_controller\Event\TaxonomyCustomControllerEvents::PAGE_BUILD`
- String value: `taxonomy_custom_controller.term_page_build`
- Event object: `Drupal\taxonomy_custom_controller\Event\TermPageBuildEvent`
  - `getTaxonomyTerm(): \Drupal\taxonomy\TermInterface` — the term for the requested page.
  - `getBuildArray(): array` — the current build (empty `[]` until a subscriber sets it).
  - `setBuildArray(array $build): void` — set the render array to use for the page.

## Subscribe to it

```php
namespace Drupal\my_module\EventSubscriber;

use Drupal\taxonomy_custom_controller\Event\TaxonomyCustomControllerEvents;
use Drupal\taxonomy_custom_controller\Event\TermPageBuildEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyTermPageSubscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return [TaxonomyCustomControllerEvents::PAGE_BUILD => 'onBuild'];
  }

  public function onBuild(TermPageBuildEvent $event): void {
    $term = $event->getTaxonomyTerm();
    // Only act on the vocabularies/terms you care about; return early otherwise.
    if ($term->bundle() !== 'tags') {
      return;
    }
    $event->setBuildArray([
      '#markup' => $term->label(),
    ]);
  }

}
```

Register the class as a tagged `event_subscriber` service in your `*.services.yml`
(`tags: [{ name: event_subscriber }]`). Multiple subscribers can run; because they all read/write the
same `TermPageBuildEvent`, the effective result is whatever the last-priority subscriber leaves in
`getBuildArray()`. Use event priorities if order matters.

## Controller build order

`Controller/TaxonomyCustomController::build($taxonomy_term)` (`TaxonomyCustomController.php:47`) does,
in order:

1. Dispatch `TermPageBuildEvent` for the term.
2. `if (!empty($event->getBuildArray())) return that build;` — a subscriber's array wins.
3. Otherwise `views_embed_view('taxonomy_term', 'page_1', $taxonomy_term->id())`; return it if truthy.
   This is the same view the stock term page uses, so with no subscriber the page looks unchanged.
4. Otherwise (the `taxonomy_term` view is disabled/removed) render the term entity itself via
   `entity_type.manager` → `getViewBuilder('taxonomy_term')->view($taxonomy_term)` (default view mode).

The controller returns whatever render array these produce; it does not wrap or post-process them.

## How the route is taken over

`EventSubscriber/RouteAlterSubscriber` (`RouteAlterSubscriber.php:29`) subscribes to
`RoutingEvents::ALTER` at priority `-200` and, if `entity.taxonomy_term.canonical` exists, calls
`$route->setDefault('_controller', 'Drupal\taxonomy_custom_controller\Controller\TaxonomyCustomController::build')`.
It changes **only** the `_controller` default — no path, no `_title_callback`, and no `requirements`.

Operational notes for agents:

- The negative priority means it runs late, after core's Views route subscriber has (on a default
  site) already overridden `entity.taxonomy_term.canonical` with the `taxonomy_term` view's page
  display. The net route therefore keeps the view display's defaults (`view_id`, `display_id`) and
  its access requirement (`_permission: 'access content'`) but points `_controller` at this module.
  When the `taxonomy_term` view is disabled, Views does not override, and the route keeps core's own
  `_entity_access: 'taxonomy_term.view'` requirement.
- Because the term arriving in the event has already passed the route's access requirement, a
  subscriber operates on an access-checked term. If your subscriber renders term fields directly
  (rather than deferring to the view), apply the access logic your use-case needs the same way any
  custom render code would; the module does not add per-field checks for you.
- Editing the `taxonomy_term` view in the Views UI still changes the fallback output (steps 3), but a
  subscriber that sets its own build array bypasses the view entirely — a common source of "why does
  editing the view do nothing" confusion. Document the override in the site's own docs.

## Service reference

| Service id | Class | Purpose |
|---|---|---|
| `taxonomy_custom_controller.route_alter_subscriber` | `EventSubscriber\RouteAlterSubscriber` | Repoints the term route `_controller`. |
| `taxonomy_custom_controller_example.term_page_build_subscriber` | `taxonomy_custom_controller_example\EventSubscriber\TermPageBuildSubscriber` | Example subscriber (submodule only). |
