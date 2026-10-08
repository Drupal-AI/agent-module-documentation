<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `config/rewrite/` directory + rewrite YAML format

## Directory convention

Place rewrite files in your module at:

```
mymodule/
  config/
    rewrite/
      system.site.yml                 # rewrites the active system.site config
      user.role.authenticated.yml     # rewrites an existing role
      language/
        fr/
          system.site.yml             # French override (needs the language module)
```

- The **filename is the config object name** to rewrite (minus `.yml`), e.g.
  `system.site.yml` rewrites `system.site`.
- Files are applied on **`hook_module_preinstall`** of the module that owns them
  (constant `ConfigRewriterInterface::CONFIG_REWRITE_DIRECTORY = 'config/rewrite'`).
- The target config **must already exist** in active storage, otherwise the rewrite
  throws `NonexistentInitialConfigException` (you can only rewrite, never create).
- The rewrite folder is **not** recursed for the default language — only top-level
  `*.yml` files are scanned. Language subfolders are scanned per enabled language.

## YAML format — default is deep-merge

The YAML holds only the keys you want to change; they are deep-merged
(`NestedArray::mergeDeep`) onto the existing config. Everything else is kept.

```yaml
# system.site.yml — change two fields, keep the rest
slogan: 'Powered by config_rewrite'
mail: admin@example.com
```

Scalars overwrite; **sequence (list) values are appended/merged**, so adding a
permission to a role adds to the existing list rather than replacing it:

```yaml
# user.role.authenticated.yml — adds a permission to the existing set
permissions:
  - 'access content overview'
```

## The `config_rewrite:` control key

An optional top-level `config_rewrite:` key changes the strategy. It is **stripped
before saving** (never persisted).

Replace the **entire** object:

```yaml
config_rewrite: replace
label: 'Fully replaced'
permissions:
  - 'change own username'
```

Replace **only listed keys** (dot-paths). A listed key that is *absent* from the
rewrite is **deleted** from the result:

```yaml
config_rewrite:
  replace:
    - is_admin        # present below? set it. absent? delete it from target.
    - permissions
label: 'Selectively replaced'
permissions:
  - 'change own username'
# is_admin omitted -> removed from the saved config
```

## UUID / `_core` handling

By default the original `uuid` and `_core` keys are **retained** so the rewrite does
not orphan the config entity. To let your rewrite supply its own (or drop them), add:

```yaml
config_rewrite_uuids: true   # do NOT re-inject the original uuid/_core
```

## Multilingual

`config/rewrite/language/<langcode>/<name>.yml` rewrites the language override for that
config (via `language.config_factory_override`). These files are only applied for
languages that are enabled, and only when the `language` module is installed.
