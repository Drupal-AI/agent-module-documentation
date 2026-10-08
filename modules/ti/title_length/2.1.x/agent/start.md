# Title length — agent index

Raises the max length of entity title columns above 255. The **parent module is machinery
only** (an abstract service + a Drush command); the submodules apply it:
`node_title_length` (node titles) and `taxonomy_term_title_length` (term names).

- **Default length (500) and the `settings.php` overrides** →
  [configure/length.md](configure/length.md)
- **The `EntityTitleLength` service / how to lengthen another entity type** →
  [api/service.md](api/service.md)
- **The `title_length:update` Drush command** →
  [drush/commands.md](drush/commands.md)

Key facts:
- `configure` = null, no config object, no permissions. Enabling the **parent alone does
  nothing** — enable a submodule.
- Default length = 500 (`EntityTitleLengthInterface::DEFAULT_LENGTH`); original = 255.
- Override via `$settings['node_title_length_chars']` /
  `$settings['taxonomy_term_title_length_chars']` in `settings.php`.
- Re-apply after a change: `drush title_length:update node` / `... taxonomy_term`.
- Submodules: [node_title_length](../../modules/node_title_length/2.1.x/agent/start.md),
  [taxonomy_term_title_length](../../modules/taxonomy_term_title_length/2.1.x/agent/start.md).
