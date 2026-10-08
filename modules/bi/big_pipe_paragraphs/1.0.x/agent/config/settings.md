<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — settings form & `big_pipe_paragraphs.settings`

## Install / enable

`drush en big_pipe_paragraphs`. This pulls in core `big_pipe` + `dynamic_page_cache` and contrib
`paragraphs` + `preprocess` (all listed in `big_pipe_paragraphs.info.yml`). BigPipe must actually
be doing its job on the site (default in standard installs) for the deferred paragraphs to stream.

## Route, form, menu

- Route `big_pipe_paragraphs.settings` (`big_pipe_paragraphs.routing.yml`):
  path `/admin/config/system/big-pipe-paragraphs`, `_form:
  \Drupal\big_pipe_paragraphs\Form\SettingsForm`, `_permission: 'administer site configuration'`,
  `options._admin_route: TRUE`.
- Menu link `big_pipe_paragraphs.settings` (`big_pipe_paragraphs.links.menu.yml`): title
  *Big Pipe Paragraphs*, parent `system.admin_config_system`, weight 99.
- `Form\SettingsForm` extends `ConfigFormBase`; form id `big_pipe_paragraphs_settings`.

## Config object

`big_pipe_paragraphs.settings` — the only key is `entity_type`, a nested map:

```
entity_type:
  <entity_type_id>:
    <field_name>:
      entity_bundles: [<bundle>, ...]   # host bundles the deferral is enabled for
      offset: <int>                     # first N deltas render inline; deltas >= N are deferred
      skip_bundles: [<paragraph_bundle>, ...]  # paragraph types never deferred
```

`config/install/big_pipe_paragraphs.settings.yml` ships **empty** (no entries → module is a no-op
until configured). There is **no `config/schema/`** in this project, so this config has no typed
schema (config export/translation UIs treat it as schemaless).

## How the form builds itself (`SettingsForm::buildForm`)

- Enumerates every `entity_reference_revisions` field via
  `entityFieldManager->getFieldMapByFieldType('entity_reference_revisions')` and renders a
  `details` element per entity type, then per field.
- Per field it offers three widgets, defaulted from config:
  - **Bundles** (`entity_bundles`, checkboxes) — the host-entity bundles to enable on; options come
    from the field map's `bundles`.
  - **Offset** (`offset`, number, `#min => 0`) — paragraphs at delta `< offset` stay inline; the
    rest are deferred.
  - **Skip paragraph types** (`skip_bundles`, checkboxes) — options are all paragraph bundles from
    `entityTypeBundleInfo->getBundleInfo('paragraph')`; listed types are never deferred.

## Save path & known bugs (from source)

- `submitForm()` reads `values['entity_type']`, filters each set through
  `filteredEntityTypeValueSet()` / `filteredFieldValueSet()` (drops unchecked boxes with
  `array_filter`, unsets fields with empty offset **and** empty bundles), then
  `configFactory->getEditable('big_pipe_paragraphs.settings')->set('entity_type', …)->save()`.
- `validateForm()` is **empty** (no validation).
- Two copy-paste leftovers that do **not** affect the working config object:
  `getEditableConfigNames()` returns `['geocoder.settings']` (wrong name — but `submitForm` writes
  `big_pipe_paragraphs.settings` directly via `getEditable()`, so the save works; the `ConfigFormBase`
  editable-name guard is simply pointed at the wrong object), and the class doc-comment says
  "geocoder settings form". Cosmetic/inherited-guard only.
- Pruning quirk: `filteredEntityTypeValueSet()` prunes a **field** when its offset is empty and it
  has no bundles, but prunes an **entity type** only when the pre-filter `$entityTypeValueSet` is
  empty (checked against the un-reassigned local), so emptied entity-type keys can linger. Harmless
  — `LazyParagraphBuilder::bundleEnabled()` still returns FALSE for them.
