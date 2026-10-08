# UI Examples — agent index

Collects example render arrays declared by modules/themes into a browsable "Examples library"
for theme development (part of UI Suite). Examples are YAML plugins; a controller renders them.
No config page (`configure` null), no Drush. PHP 8.3+, Drupal 11.4+.

- **Defining examples (YAML plugin format, discovery, the syntax converter, alter hook, permission)** →
  [plugins/examples.md](plugins/examples.md)

Submodule (own docs):
- `ui_examples_defaults` → [../../modules/ui_examples_defaults/2.1.x/agent/start.md](../../modules/ui_examples_defaults/2.1.x/agent/start.md)

Key facts:
- Routes: `ui_examples.overview` (`/admin/appearance/ui/examples`), `ui_examples.single` (`/admin/appearance/ui/examples/{name}`), `ui_suite.index` (`/admin/appearance/ui`).
- Permission `access_ui_examples_library` (NOT `restrict access`). `update_8101` grants it to **all roles** — the library only shows developer-authored demo render arrays.
- Plugin manager `Drupal\ui_examples\ExamplePluginManager`; discovery from `<ext>/ui_examples/*.ui_examples.yml` and `<ext>/<ext>.ui_examples.yml`; alter hook `hook_ui_examples_examples`.
- `ExampleSyntaxConverter` re-adds `#` prefixes to render properties so example YAML can omit them.
- Theme hook `ui_examples_overview_page`.
