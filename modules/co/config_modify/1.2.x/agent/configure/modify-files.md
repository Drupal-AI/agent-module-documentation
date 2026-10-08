# Config Modify — the `config/modify` mechanism

No admin UI (`configure` null). You configure the module by shipping YAML files in another
module's `config/modify/` folder.

## File location & name

`<your_module>/config/modify/<your_module>.<unique>.yml` — the prefix must match the module,
`<unique>` is any machine-name string (e.g. `add_search_field`).

## File format

```yaml
dependencies:            # optional; core config-dependency format
  modules:
    - search_api
  config:
    - field.field.node.article.body
items:                   # required; map of config name => Config Update Definition
  search_api.index.my_search:
    expected_config: { }
    add:
      field_settings:
        article_body:
          label: Article Contents
          datasource_id: 'entity:node'
          property_path: body
          type: text
          dependencies:
            config: field.field.node.article.body
```

- `items` uses `update_helper`'s **Config Update Definition** (CUD) format — per config name,
  the `add` / `change` / `delete` actions (and `expected_config` for the pre-change baseline).
- All config names under `items` are implicit dependencies (atomic: if a target is missing the
  modification no-ops).
- `dependencies.modules` / `dependencies.config` add extra gating conditions.

## When modifications run (`src/ConfigInstaller.php`)

- After core installs `config/optional` (i.e. when a module that provides optional config is
  installed), `installOptionalAlterConfig()` applies every applicable, not-yet-applied
  modification from all enabled modules via the overridden `Updater::doExecuteUpdate()`.
- **Skipped while syncing config** (`isSyncing()`) — the source environment already applied it.
- **Skipped when `config_modify` itself is first enabled** — pre-existing files are marked
  applied to avoid update-hook race conditions.
- A modification runs only if its dependencies are met and it is not already listed in
  `config_modify.applied`.

## Applied-files tracker

Config object **`config_modify.applied`** (schema `config_modify.schema.yml`) holds
`files: [ ]` — the list of modification file ids already applied, so each runs at most once.
`config_modify_mark_available_as_applied()` (module file) / `markAvailableModificationsAsApplied()`
mark the current set applied without executing them (used before update hooks).

## Service overrides (constraints)

`ConfigModifyServiceProvider` replaces `config.installer` with `Drupal\config_modify\ConfigInstaller`
and `update_helper.updater` with `Drupal\config_modify\Updater`. It **throws** if another
module has already replaced the core `ConfigInstaller` class — Config Modify cannot coexist
with such modules (decoration isn't possible because it hooks `installOptionalConfig`).
