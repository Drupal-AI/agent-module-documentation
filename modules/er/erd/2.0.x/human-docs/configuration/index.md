# Configuration

Entity Relationship Diagrams works as soon as it's enabled — visit
**Structure → Entity Relationship Diagrams** and the diagram is drawn live from
your site's entity definitions. The settings form is where you tune **what the
diagram includes**, which is handy on large sites where showing every entity type
at once would be overwhelming.

## Open the settings form

1. Log in as a user with the **Administer ERD** permission.
2. Go to `/admin/structure/erd/settings` (reachable from the diagram page at
   **Structure → Entity Relationship Diagrams**).

## What you can control

The settings form governs which parts of the data model are drawn — letting you
scope the diagram down to the entity types and relationships you care about rather
than the entire site. A few things are useful to know about how the diagram is
built:

- The diagram is **generated dynamically** from Drupal's live entity definitions,
  so whatever you include always reflects the current site — it can't fall out of
  sync the way a hand-drawn diagram would.
- Only **entity-reference fields** and **comment fields** are drawn as connecting
  links between entities; other field types are not turned into relationship lines.
- Layout changes you make on the diagram page (dragging boxes around) are saved via
  an AJAX route, so your arrangement survives a reload independently of these
  settings.

## Save

Save the form, then return to **Structure → Entity Relationship Diagrams** to see
the diagram redrawn with your choices.
