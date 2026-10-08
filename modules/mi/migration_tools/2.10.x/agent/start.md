# Migration Tools — agent index

Developer toolkit on top of Migrate + Migrate Plus + Redirect for hard content migrations
(HTML scraping especially). It defines **no plugin types of its own** and has **no
permissions**; you consume its migrate plugins, helper classes and Obtainer framework from
your own migration configs/code. `configure` route = `migration_tools.migration_tools_admin_form`
(`/admin/content/migrate/migration_tools`, permission `administer site configuration`) — debug
logging only. Depends on `migrate_plus`, `migrate`, `redirect`.

- **Migrate process/source/parser plugins it adds** (`convert_boolean`, `skip_on_substr`,
  `skip_on_not_empty`, `gate_comparator`, `create_default_paragraph_revision`, the `dom` data
  parser, the `url_list` source) → [plugins/migrate.md](plugins/migrate.md)
- **Helper library** (static classes `CheckFor`, `StringTools`, `Url`, `Media`, `Redirects`,
  `Operations`, `Message`; the `migration_tools_message` event; prepare/post-row subscribers) →
  [api/helpers.md](api/helpers.md)
- **Writing your own Obtainer / SourceParser / Modifier** (extract fields from messy HTML) →
  [extend/obtainers.md](extend/obtainers.md)
- **Admin debug settings** (`migration_tools.settings`) → [configure/settings.md](configure/settings.md)

Submodule (own docs):
- `migration_tools_example` → [../../modules/migration_tools_example/2.10.x/agent/start.md](../../modules/migration_tools_example/2.10.x/agent/start.md)

Key facts:
- Obtainers require the QueryPath library (QueryPath module or standalone install).
- Redirect creation happens automatically via the `PrepareRow` / `PostRowSave` Migrate Plus
  event subscribers when your migration provides the needed source/destination URLs.
- No Drush command service ships in this release despite older README mentions of `mt-*` commands.
