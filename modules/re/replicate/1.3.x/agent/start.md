# replicate — agent start

Developer-only API to clone (duplicate) any content entity in code, dispatching events so
you control exactly how each entity type and field type is duplicated (deep vs shallow
references). No UI, no config, no permissions. Depends only on Drupal core; core entity
support (node, term, comment, file) works out of the box.

- Clone/replicate entities in code (the `replicate.replicator` service) → [api/replicate.md](api/replicate.md)
- Control per-entity / per-field duplication via events (deep vs shallow) → [extend/replicate.md](extend/replicate.md)
