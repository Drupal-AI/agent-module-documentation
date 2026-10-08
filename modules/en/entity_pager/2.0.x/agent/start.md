# Entity Pager — agent index

Provides **one Views style plugin** (`entity_pager`) that renders `< prev / All / next >`
navigation on an entity's canonical page, driven by a View that lists the sibling entities.
No configure route, no settings form, no permissions, no Drush. Depends on `views`. Its only
persistent state is each View's style configuration (`views.view.<id>` →
`display.*.display_options.style`).

- **Set up the pager: build the View, pick the `entity_pager` format, all style options** →
  [configure/views-style.md](configure/views-style.md)
- **How links/current/count are computed; the `entity_pager.factory` service & `EntityPager` object** →
  [api/factory.md](api/factory.md)
- **Theme hook `entity_pager`, template variables, CSS library** →
  [theming/template.md](theming/template.md)

Key facts: style plugin id `entity_pager` (`Drupal\entity_pager\Plugin\views\style\EntityPager`),
config schema `views.style.entity_pager`, theme hook `entity_pager`
(`entity-pager.html.twig`), library `entity_pager/entity-pager`, demo View
`entity_pager_example` (shipped **disabled**, has a `entity_pager_example_block` block display).
