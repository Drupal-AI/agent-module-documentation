# Views Serialization Pager — agent index

One Views **style** plugin that wraps REST Export serialized output with pager metadata. Extends core
REST's `Serializer` style; usable on `data` displays (REST Export). Depends on `serialization` +
`views`. No settings page (`configure` null), no permissions, no config schema, no Drush.

- **The style plugin, output shape, and how to configure a REST Export view** →
  [configure/style.md](configure/style.md)

Key facts:
- Style plugin id `views_serialization_pager`, title "Serialization with Pager", `display_types = {"data"}`.
- Output envelope: `{"rows": [...], "pager": {"current_page", "total_items", "total_pages",
  "items_per_page"}}`, serialized to the display's content type.
- `total_pages` uses `pager->getPagerTotal()` except for `None` / `Some` pagers (and `Mock_*`), where it
  stays 0.
