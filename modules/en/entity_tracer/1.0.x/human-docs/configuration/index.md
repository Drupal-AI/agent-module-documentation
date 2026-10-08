# Configuration

Entity Tracer needs a quick configuration pass before it will trace anything —
you choose which entity types it should follow and how deep the diagram goes.

## Open the settings form

1. Log in as a user who holds the Entity Tracer permission (grant it only to
   trusted administrators and developers).
2. Go to **Configuration → Development → Entity Tracer settings**, or navigate
   directly to `/admin/config/development/entity-tracer-settings`.

## Settings

- **Entity types to track** — select which entity types the tracer should follow
  when building a diagram. Only the types you tick here are included, which keeps
  the diagram focused on the content you care about.
- **Maximum depth** — how many levels of references the tracer recurses into
  before it stops (default **10**). A higher value follows references further down
  the chain but produces larger diagrams; a lower value keeps the map shallow and
  quick to read.

Save the form when you're done.

## Generating a diagram

With the settings saved, use the tracer's UI to generate a diagram for an entity.
The result is nested and recursive: reference fields are shown in bold, and each
referenced entity is a link to that entity's page, so you can move between the map
and the underlying content.
