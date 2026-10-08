# acquia_contenthub_metatag — agent start

Submodule of **acquia_contenthub** (Acquia Content Hub). During export it rewrites the
`canonical_url` in a content entity's **metatag** field so the syndicated CDF carries the
publisher's absolute node URL instead of the raw `[node:url]` token. Depends on
`acquia_contenthub` + `metatag`. No routes, permissions, Drush, or plugin types — one config
flag and one serialization event subscriber.

- **Turn the canonical-URL rewrite on/off; the config key; runtime behavior** → [configure/settings.md](configure/settings.md)

Key facts:
- Config object `acquia_contenthub_metatag.settings`, single key `ach_metatag_node_url_do_not_transform` (bool, default `FALSE`). When `TRUE`, the rewrite is skipped.
- Event subscriber service `acquia_contenthub.metatags.serializer` = `EntityMetatagsSerializer` (extends the base module's `FallbackFieldSerializer`), subscribed to `AcquiaContentHubEvents::SERIALIZE_CONTENT_ENTITY_FIELD` at priority **110**; only acts on fields of type `metatag`, then calls `stopPropagation()`.
- `.module` adds a help description to the `metatag_defaults_form` canonical-URL field and to any `metatag`-type field widget (`hook_form_metatag_defaults_form_alter`, `hook_field_widget_form_alter`).
- Extension point is the parent's event system (no hook/`*.api.php`); see the parent module `acquia_contenthub` doc `agent/extend/events.md`.
