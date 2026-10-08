# ECA Helper — agent index

Extra ECA actions + events for the [ECA](https://www.drupal.org/project/eca) no-code
automation engine. No settings form (`configure` null), no own permissions (governed by
ECA's permissions), no Drush. Depends on `eca` + `eca_form`. All artifacts are configured
by admins inside ECA models.

- **Full catalogue of the ~30 `eca_helper_*` action plugins, the 3 custom events, and the
  Quick Action extension point (`sites/eca/EcaActions.php`)** → [plugins/actions.md](plugins/actions.md)
- **Services you can call from code / that back the hooks: private-file access via ECA
  (`FileDownloadManager`), page-attachment injection, the `messenger` decorator** →
  [api/services.md](api/services.md)

Submodule (own docs):
- `eca_helper_workflow` (Content Moderation state actions) →
  [../../modules/eca_helper_workflow/3.0.x/agent/start.md](../../modules/eca_helper_workflow/3.0.x/agent/start.md)

Key facts:
- Actions are ECA plugins (`Drupal\eca_helper\Plugin\Action\*`); use them as steps in an ECA model.
- Custom events: `eca_helper` (Status Messages), `eca_helper_file_download` (private file),
  `eca_helper_preprocess_hook` (generic preprocess).
- No `config/install` or `config/schema` — the module ships no configuration of its own.
