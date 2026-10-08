# eva — agent start

EVA (Entity Views Attachment) provides a Views **display plugin** (id `entity_view`, label
"EVA") that attaches a view's output to a content entity's display as a **pseudo-field**. It
passes the current entity to the view as a contextual argument (entity ID or tokens). Depends
only on core `views`; optional `drupal/token` adds a token browser. No admin settings form
(`configure` is null) — everything is configured on the view display itself.

- Add an EVA display to a view, bind it to an entity type + bundles, place/reorder it on
  Manage display, and pass the entity ID or tokens as arguments → [configure/eva.md](configure/eva.md)
- Services, hooks, plugin & template internals (`eva.view_displays`, `eva.token_handler`) →
  [api/eva.md](api/eva.md)
