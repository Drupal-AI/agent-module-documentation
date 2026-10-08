<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Filter Link" entity-reference formatter

## Install & enable

```bash
composer require drupal/entity_ref_filtering_link
drush en entity_ref_filtering_link -y
```

No dependencies beyond Drupal core, no submodules, no permissions, no Drush commands, no
`.install`, no `config/install` defaults.

## The two plugins

Both live in `src/Plugin/Field/FieldFormatter/` and target `field_types = { "entity_reference" }`.

| Plugin id | Label | Class | Notes |
|---|---|---|---|
| `entity_reference_filtered_link` | Filter Link | `EntityReferenceFilteredLinkFormatter` | Extends `EntityReferenceFormatterBase`; contains all logic. |
| `entity_reference_filtered_link_disable` | Filter Link Disable | `EntityReferenceFilteredLinkDisableFormatter` | **Empty subclass**, `no_ui = true`. Identical behaviour, just not selectable in the Field UI. |

Note: the `_disable` plugin does **not** suppress links on its own — despite the label and the
project README's older wording. It is simply a hidden variant. The README's claim that the second
formatter adds a label-exclusion option is outdated: the exclusion option (`disable` / "Skip
Linking") lives in the shared base and is available on **both** plugins.

## Enable it on a field

UI: *Structure → (entity type/bundle) → Manage display* → set an **entity reference** field's
format to **Filter Link** → click the gear to configure. Config/Drush equivalent:

```bash
drush cset core.entity_view_display.node.article.default \
  content.field_tags.type entity_reference_filtered_link -y
drush cr
```

## Formatter settings

From `defaultSettings()` and `settingsForm()` in `EntityReferenceFilteredLinkFormatter.php`:

| Setting | Default | Required | Meaning |
|---|---|---|---|
| `view_url` | `''` | yes | Base path the filter is applied to (the listing/view/page). README advises the internal `/node/123` form so links survive alias changes. |
| `argument_name` | `''` | yes | Query argument / facet key. If empty, `getArgumentName()` falls back to `$this->fieldDefinition->getName()` (the field machine name). |
| `mode` | `id` | yes | How the referenced entity's id/label is appended — see modes table. |
| `skip_access_check` | `FALSE` | no | If set, resolves `view_url` with `getUrlIfValidWithoutAccessCheck()` so a user lacking access to the destination is still linked (e.g. bounced to login) instead of seeing plain text. |
| `disable` | `''` | no | Comma-separated list of entity **labels**. A referenced entity whose label is in the list is rendered as `#plain_text` (no link). |
| `permission` | `''` | no | If non-empty and the current user lacks it (`currentUser->hasPermission()`), the label is rendered as plain text instead of a link. |

`settingsSummary()` echoes the view url, argument name, mode, and whether the access check is
skipped. Note the config **schema** is stale (see bottom).

## URL modes

`viewElements()` switches on `mode` to build `$options['query']` on the resolved `Url` (`$id` is
`$entity->id()`, `$argument` the argument name). Example base `/search`, arg `tag`, term
"StarTrek" id 7:

| `mode` value | Form built | Example URL |
|---|---|---|
| `id` | `query[tag] = 7` | `/search?tag=7` |
| `id_multiple` | `query["tag[]"] = 7` | `/search?tag[]=7` |
| `id_multiple_d9` | `query["tag[7]"] = 7` | `/search?tag[7]=7` |
| `autocomplete` | `query[tag] = "StarTrek (7)"` | `/search?tag=StarTrek (7)` |
| `facet` | `query["f[0]"] = "tag:7"` | `/search?f[0]=tag:7` |
| `label` | `query["f[0]"] = "tag:StarTrek"` | `/search?f[0]=tag:StarTrek` (Facet - Label) |
| `label_no_facet` | `query[tag] = "StarTrek"` | `/search?tag=StarTrek` (Label) |

The destination view must actually accept the parameter shape produced — the module only writes
the URL, it does not configure the view.

## Render logic (`viewElements()`)

For each entity from `getEntitiesToView($items, $langcode)` (inherited base method), in order:

1. Label in the `disable` list → `#plain_text` label (with the entity's cache tags), skip.
2. `permission` set and user lacks it → `#plain_text` label (cache tags + `user.permissions`
   context), skip.
3. Resolve `view_url` via `path.validator`: `getUrlIfValidWithoutAccessCheck()` when
   `skip_access_check`, else `getUrlIfValid()`. If it resolves to **no** URL (invalid path or no
   access) → `#plain_text` label, skip.
4. Otherwise build the query per `mode`, set it on the `Url`, and emit a
   `#type => 'link'` element (`#title => $label`, `#url`, `#options`). Any per-item
   `_attributes` are merged into the link options.
5. Entity with no id → `#plain_text` label.
6. Every element gets `#cache[tags] = $entity->getCacheTags()`.

`checkAccess()` (used by the base `getEntitiesToView()`) returns
`$entity->access('view label', NULL, TRUE)`, so entities the user cannot even view the label of
are filtered out upstream.

Dependency injection (`create()`): `path.validator` (`PathValidatorInterface`) and `current_user`
(`AccountInterface`).

## Config schema (note: out of date)

`config/schema/entity_ref_filtering_link.schema.yml` declares
`field.formatter.settings.entity_reference_filtered_link` with keys `view_mode, link, number,
max, view_url, argument_name, mode`. This **does not match** the code: the plugin's real settings
are `view_url, argument_name, mode, skip_access_check, disable, permission`. The schema declares
four keys the code never uses (`view_mode, link, number, max`) and omits three it does
(`skip_access_check, disable, permission`). Settings still save and work, but strict
config-schema tooling may flag the view-display config for the undeclared keys.
