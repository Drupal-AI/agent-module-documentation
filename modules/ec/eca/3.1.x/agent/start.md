# eca — agent start

ECA Core = the engine. Listens to Drupal **events**, checks **conditions**, runs **actions**,
driven by **models** (`eca` config entities). Core ships no rules itself — capabilities come from
submodules; you edit models in a visual modeler (e.g. `bpmn_io`) via ECA UI at
`/admin/config/workflow/eca`. Requires `modeler_api`. PHP >= 8.3.

- Models as config, settings, deployment → [configure/models.md](configure/models.md)
- Plugin types it defines (Event/Condition) + adding actions → [plugins/components.md](plugins/components.md)
- Drush commands → [drush/commands.md](drush/commands.md)
- Submodules map (what provides which events/actions) → [configure/submodules.md](configure/submodules.md)
