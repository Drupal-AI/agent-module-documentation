<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WissKI Core (wisski_core) — agent index

Submodule of **wisski**, and **required** by it. Entity type, routing, UI, query factory.
Version **8.x-4.3**. Core `>=10.4 <12`.
Declares `inline_entity_form`, `wisski_autocomplete`, `wisski_pathbuilder`, `wisski_salz`.

**Design point:** a WissKI entity is a Drupal entity whose storage is a **triple store**.
`entity.query.wisski_core` is built from the pathbuilder manager plus SALZ's query annotator and
planner, so an entity-API query becomes SPARQL. That is what lets Views, forms and field displays
work against semantic data.

**This is the module that breaks a site without core Search.** `wisski_core.services.yml`:

```yaml
wisski.route_subscriber:
  arguments: ['@module_handler', '@entity_type.manager', '@search.search_page_repository']
```

— and `drupal:search` is **not** in its dependencies. **Verified:** the missing service fataled
every request *and* Drush, so recovery needed a direct `core.extension` DB edit. **Enable core
`search` first.** Documented from source for that reason.