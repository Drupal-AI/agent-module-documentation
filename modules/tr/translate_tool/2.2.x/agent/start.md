# Translate Tool — agent index

Developer helper to add/delete **locale interface-translation strings from code** (update/install
hooks), wrapping core `locale.storage`. No UI, no config, no permissions, no Drush, no plugins —
just one service and two procedural wrappers. Depends on core `locale`.

- **The `translate_tool` service and the `add()` / `delete()` + procedural functions** →
  [api/service.md](api/service.md)

Key facts:
- Service id `translate_tool` = `\Drupal\translate_tool\TranslateTool`, arg `@locale.storage`.
- `add($source, $langcode, $translation, $context = '')`, `delete($source, $context = '')`.
- Procedural: `translate_tool_add(...)`, `translate_tool_delete(...)` (same signatures).
