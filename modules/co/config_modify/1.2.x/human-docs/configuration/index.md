# Configuration

Config Modify has no settings screen. You "configure" it by shipping YAML files in
your own module and, optionally, using its two Drush commands. This page explains
the file format, when modifications run, and the commands.

## The `config/modify` file

Create the file inside the module that should own the modification:

```
<your_module>/config/modify/<your_module>.<unique>.yml
```

The filename **must** start with the module's machine name, and `<unique>` can be
any machine‑name string that describes the change (for example
`add_search_field`).

Each file has two top‑level keys:

```yaml
dependencies:            # optional — gate when the modification is allowed to run
  modules:
    - search_api
  config:
    - field.field.node.article.body
items:                   # required — the actual changes to make
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

- **`items`** is a map of config‑object name → a *Config Update Definition* (the
  add / change / delete format from the Update Helper module). `expected_config`
  describes the baseline the change expects; `add` / `change` / `delete` describe
  what to do.
- Every config name listed under `items` is treated as an **implicit
  dependency** — the change is atomic, so if the target config is missing the
  modification simply does nothing.
- **`dependencies`** adds extra gating: the listed modules must be enabled and/or
  the listed config objects must exist before the modification will run.

## When modifications run

- They're applied **after core installs a module's optional config** — that is,
  when you install a module that ships `config/optional`. At that point Config
  Modify applies every applicable, not‑yet‑applied modification from all enabled
  modules.
- A modification runs only if its dependencies are met **and** it hasn't already
  been applied. Applied files are recorded in a tracker
  (`config_modify.applied`), so each runs at most once.
- Modifications are **skipped during a config import/sync** — the assumption is
  that the source environment already applied the change, so re‑running it would
  cause conflicts.

## Drush commands

### Scaffold a modification file — `drush config-modify:create` (alias `cmc`)

Interactively builds a `config/modify` file by diffing your config. It prompts
for:

1. which (non‑core) module should contain the file,
2. a machine name for the modification,
3. the **direction** of the diff — *from disk to database* (the default) or *from
   database to disk*,
4. which config objects to include, and
5. any extra module/config dependencies.

It diffs each selected config object's on‑disk value against its active (database)
value, skips anything unchanged or missing on disk, and writes the resulting
`items` (plus `dependencies`) into the module's `config/modify/` folder (asking
before overwriting).

```bash
drush config-modify:create
```

### Prepare before database updates — `drush config-modify:pre-update` (alias `cmpu`)

Marks any newly added, currently applicable `config/modify` files as *applied*
**before** you run database updates, so they don't fire unexpectedly during
`drush updb`. Run it before deploying update hooks that themselves introduce new
modification files.

```bash
drush config-modify:pre-update
```
