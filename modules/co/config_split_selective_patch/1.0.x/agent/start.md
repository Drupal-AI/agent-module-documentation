<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Split Selective Patch (config_split_selective_patch) — agent index

info.yml name **Config Split Selective Patch**, version **1.0.1**, package `Config`, core `^10.3 || ^11`,
PHP `>=8.2`. Depends on **Config Split 2.x** (`config_split:config_split`). No routes, no controllers,
no permissions of its own, no Drush commands, no settings form.

An **add-on for Config Split 2.x** that adds a per-split **Partial Split (Patch)** list. Config Split's
2.x default exports the active↔sync diff of a config as a compact schema-aware patch file
(`config_split.patch.*`). Teams that turn on **Do not patch dependents** (`no_patching: true`) keep
1.x-style behaviour instead, where Partial Split items are stored as full config copies when they
differ. This module lets you name specific config to *still* export as patches under that mode — a way
to adopt patch-based splitting on a chosen subset only. **Import behaviour is unchanged**; Config Split
already merges `config_split.patch.*` on import.

## Mechanism (real names)

- **`config_split_selective_patch.module`**
  - `hook_entity_type_alter` — swaps the `config_split` entity class to `Entity\ConfigSplitEntity` and
    appends `patch_list` to the entity type's `config_export` list (so it persists in the split's YAML).
  - `hook_config_schema_info_alter` — adds `patch_list` (a `sequence` of config-name strings) to
    `config_split.config_split.*` schema. (The `config/schema/*.schema.yml` file is only a comment;
    the schema is registered from this hook.)
  - `hook_form_config_split_edit_form_alter` / `..._add_form_alter` → `_config_split_selective_patch_alter_split_form()`
    adds the **Partial Split (Patch)** fieldset (a `patch_picker` checkboxes/select + a `patch_text`
    wildcard textarea), shown only when the split form's `no_patching` checkbox is checked (`#states`).
    Its submit handler `config_split_selective_patch_config_split_entity_form_submit()` is appended to
    the Save button `#submit`, reads the picker + textarea, and saves the merged list into `patch_list`.
- **`Entity\ConfigSplitEntity`** — extends `config_split`'s `ConfigSplitEntity`, adds the
  `protected $patch_list = []` property.
- **`SelectivePatchExportSubscriber`** (`event_subscriber`) — subscribes to `config.transform.export`
  at priority **-255** (runs after Config Split's own transform). For each enabled split with
  `no_patching` true and a non-empty `patch_list`, it calls `PatchListExporter::apply()` on the split's
  preview storage.
- **`PatchListExporter`** — reproduces Config Split's partial-patch logic for the `patch_list` items:
  matches active-storage config names against the list, and for each match writes the sync value into
  the transforming storage while emitting a `config_split.partial.<name>` patch (via
  `@config_split.patch_merge` `ConfigPatchMerge::createPatch`/`mergePatch`), or moves the full config
  into the split when no sync baseline exists. Handles `stackable` splits by composing higher-weight
  splits into the comparison baseline. Uses in-memory Drupal config storages only.
- **`ConfigNameFilter::inFilterList()`** — wildcard matcher: `preg_quote` each list entry, turn `\*`
  into `.*`, anchored regex match. **`ConfigSplitFormHelper`** — picks checkboxes vs. select widget
  (state `config_split_use_select`, or if `chosen`/`select2_all` enabled); `filterConfigNames()`
  lower-cases and strips textarea input to `[a-z0-9_.\-*]`.
- **Services**: `…patch_list_exporter`, `…form_helper`, `…export_subscriber` (see `.services.yml`).

## Do this → look here

- Turn config into patch exports under no-patching → edit the split at
  `/admin/config/development/configuration/config-split`, enable **Do not patch dependents**, fill
  **Partial Split (Patch)**, `drush cex`. See [usage.md](../usage.md) and
  [human-docs](../human-docs/index.md).

## Behaviour table (from README)

| Do not patch dependents | List | Result |
| --- | --- | --- |
| Off | `partial_list` | Config Split 2.x patch (unchanged; the Patch fieldset is hidden) |
| On | `partial_list` | 1.x conditional full copy (unchanged) |
| On | `patch_list` | Patch files via this module |
| On | both lists, same config | Patch wins |

Optional UX modules: **Chosen** / **Select2 All** switch the picker to a select widget (no hard dep).
