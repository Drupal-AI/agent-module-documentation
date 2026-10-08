# Generate content (UI)

Each `DevelGenerate` plugin exposes a form under `/admin/config/development/generate/<id>`
(route provider `DevelGenerateRoutes`, form `DevelGenerateForm`). No persistent config object —
you submit values and a Batch API run creates the entities.

Built-in generators (`src/Plugin/DevelGenerate/`):
- **content** — nodes: pick content types, count, delete-existing, comments, aliases,
  authored-by users, created-date range, languages, add statistics.
- **user** — users: count, roles, active/blocked, password.
- **term** — taxonomy terms: vocabulary, count, min/max depth.
- **vocabulary** — vocabularies: count.
- **menu** — menus + links: count of menus and links, link depth, title length.
- **media** — media entities: media types, count, delete-existing.
- **block_content** — custom block content: block types, count.

Common options: number to create, "Delete all … before generating", and per-type extras.
The same options are available on the CLI — see [../drush/commands.md](../drush/commands.md).
