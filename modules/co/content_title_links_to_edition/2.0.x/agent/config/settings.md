<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, configuration & rewrite mechanism

Everything the module does is driven by the config object **`content_title_links_to_edition.settings`**
and applied at Views render time. No entities, plugins, services, or Drush commands are provided.

## Install / enable

`drush en content_title_links_to_edition` (or Extend). Core `node` + `views` are required and are
its only dependencies. `hook_install` (`content_title_links_to_edition.install`) seeds the
`content_types` map from all **enabled** node types, each set to "1" if
`enable_contents_automatically` was true, else "0".

## Config object & schema

`config/schema/content_title_links_to_edition.schema.yml` defines
`content_title_links_to_edition.settings`:

- `allowed_views` — `sequence`. Each row is `{ enabled, view, title }` where `view` is a **view
  machine ID** and `title` is the **Views field machine name** to rewrite.
- `enable_contents_automatically` — `boolean`. When on, node bundles created later are auto-enabled.
- `all_content_types` — `boolean`. When on, the rewrite applies to every node bundle.
- `content_types` — `sequence` of `string` (map of bundle machine name → "0"/"1").

Install defaults (`config/install/content_title_links_to_edition.settings.yml`):

```yaml
allowed_views:
  - { enabled: '1', view: content, title: title }
enable_contents_automatically: false
all_content_types: true
content_types: {  }
```

So out of the box it rewrites the `title` field of the core `content` admin view for all node
types.

## Settings form

`\Drupal\content_title_links_to_edition\Form\SettingsForm` (`ConfigFormBase`), form id
`content_title_links_to_edition_settings_form`.

- **Route** `content_title_links_to_edition.content_title_links_to_edition_settings_form` →
  `/admin/config/content_title_links_to_edition/settings`, `_admin_route: TRUE`, requires
  permission **`administer content title links to edition`** (`restrict access: TRUE`).
- Menu link + local task defined in `*.links.menu.yml` / `*.links.task.yml`, parent
  `system.admin_config_content` (Configuration → Content authoring), weight 99.
- **Views table** (`#type table`, id `table--allowed-views`): one row per `allowed_views` entry
  with Enabled (checkbox), View ID (textfield), View Title Column (textfield) and a per-row Remove
  button. **Add Row** / **Remove** are AJAX submit handlers (`addRowAjax` / `removeRowAjax`) that
  adjust the row count stored in `$form_state` and rebuild via `allowedViewsAjaxCallback`.
- **Configure contents** fieldset: `enable_contents_automatically` checkbox; a nested Content
  types fieldset with `all_content_types` and a `content_types` checkboxes element whose options
  come from `getKeyedNodeTypes()` (enabled node types only).
- `submitForm()` writes `allowed_views` (rebuilt from the table via `getFormTableValues()`),
  `enable_contents_automatically`, `all_content_types`, `content_types`, then calls
  `invalidateAllowedViewsCache()` — which loads each enabled view and calls
  `Cache::invalidateTags($view->getCacheTags())` so the listing re-renders with the new links.

## Rewrite mechanism (`content_title_links_to_edition.module`)

`content_title_links_to_edition_preprocess_views_view_field(&$variables)`:

1. Returns early unless `$variables['view']` is a `ViewExecutable`, `$variables['field']` an
   `EntityField`, and `$variables['row']` a `ResultRow`.
2. Loads `content_title_links_to_edition.settings` and iterates `allowed_views`. A row matches when
   it is `enabled`, its `view` equals `$variables['view']->id()`, and its `title` equals
   `$variables['field']->field`.
3. On a match it checks the row entity: it must be a `NodeInterface`, and either `all_content_types`
   is true or its bundle is in `content_types`; otherwise it returns.
4. Builds the edit URL `Url::fromRoute('entity.node.edit_form', ['node' => $entity->id()], …)`,
   adding `['language' => …]` from `$variables['row']->node_field_data_langcode` on multilingual
   sites.
5. Strips existing `<a>` tags from `$variables['output']` with
   `preg_replace("/<\/?a(.|\s)*?>/", '', …)` and re-wraps the (already-rendered, sanitized) title
   text with `Link::fromTextAndUrl(Markup::create(...), $edit_link)`.

The generated link targets the standard node edit route, whose own access checking applies when the
link is rendered/followed; the module does not itself grant edit access.

## Bundle lifecycle hooks

- `content_title_links_to_edition_entity_bundle_create($entity_type_id, $bundle)` — for `node`
  bundles, adds the new bundle to `content_types` (value = bundle name when
  `enable_contents_automatically`, else "0") if not already present, and saves.
- `content_title_links_to_edition_entity_bundle_delete(...)` — removes the bundle from
  `content_types` and saves.

## Operating notes

- To add a custom listing: on the settings form add a row with the view's machine ID and the exact
  Views field machine name of its title column, tick Enabled, and save.
- If titles are not becoming edit links, verify the row is enabled, the view ID and title-field
  machine name match exactly, the bundle is permitted, and clear caches (config save already
  invalidates the configured views' cache tags).
