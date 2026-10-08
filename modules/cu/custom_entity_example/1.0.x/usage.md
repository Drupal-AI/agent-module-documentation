<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Entity Example

A reference implementation showing how to build a custom fieldable content entity type in Drupal, intended to be copied and renamed as a starting point.

- Defines the `custom_entity_example` content entity plus a `custom_entity_example_type` config-entity bundle.
- Uses the contrib Entity API query-access and permission-provider handlers.
- Ships a Drush command that scaffolds a new module by search-replacing the example's name.

---

## Installation & configuration

- Enable to explore a working entity type; manage the collection at `entity.custom_entity_example.collection`.
- Admin permission is `administer custom_entity_example`; a settings route requires it too.
- Bundles use permission granularity = bundle via the Entity API permission provider.
- The Drush service (`drush.services.yml`) exposes a generator command for cloning the example.
- Add fields via the field UI as with any bundle.
- Intended as developer scaffolding, not an end-user feature.

---

## Usage & behaviour

- Entity, storage, list-builder, forms, and access handler live under `src/`.
- The generator's `replaceInFile()` reads a file, `str_replace`s the example name, and writes it back — a local codegen helper, not a web endpoint.
- Access is entity-access driven through the standard handlers.
- Route `custom_entity_example.*` settings require `administer custom_entity_example`.
- Templates live in `templates/`.
- Use it to learn the entity annotation, handlers, links, and permissions wiring.
- Copy the module, run the generator (or manual rename) to produce your own entity type.
- No external network calls at runtime.
- The `file_get_contents`/`file_put_contents` usage is confined to the codegen command operating on local scaffold files.
- No unauthenticated mutation or disclosure routes.
- Bundle config entities are exportable like any config.
- Revisions/owner/published behaviours mirror core content entities.
- Good template for a canonical route + access handler pattern.
- Remove after copying if you do not need the example enabled in production.
- Read: `src/`, `drush.services.yml`, `custom_entity_example.routing.yml`.
