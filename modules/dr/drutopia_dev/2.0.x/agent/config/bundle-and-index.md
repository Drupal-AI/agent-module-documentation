<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drutopia Dev — dependencies, Features bundle, and the "Dev node" index

Everything this module does at enable time. There is no settings form (`configure: null`).

## Install & enable

```bash
composer require drupal/drutopia_dev   # brings in devel, entity_clone, drutopia_core, drutopia_search, ...
drush en drutopia_dev -y
```

Composer `require` (from `composer.json`, all others come via the modules pulled in):

- `drupal/drutopia_core ^2`
- `drupal/devel ^5`
- `drupal/drutopia_search ^2`
- `drupal/entity_clone ^2`

`drutopia_dev.info.yml` additionally lists every `drutopia_*` content/feature module plus `node`,
`user`, and `search_api` as module dependencies, so enabling `drutopia_dev` enables the whole set.
The module carries **no packaged `version:`** in `info.yml` in this checkout (a dev checkout).

## The Features bundle (`config/install/features.bundle.drutopia.yml`)

Installs the `features.bundle.drutopia` config entity (id/machine name `drutopia`, `is_profile: true`,
`profile_name: drutopia`) that the Features module uses when packaging/exporting the distribution's
config. It defines the standard assignment plan (`assignments:`) — `base`, `core`, `dependency`,
`exclude`, `existing`, `forward_dependency`, `namespace`, `optional`, `packages`, `profile`, `site`,
`alter` — each with its config `types` and weight (e.g. `base` groups `comment_type`, `node_type`,
`group_type`, `user`; `site` groups `action`, `contact_form`, `taxonomy_vocabulary`, `filter_format`,
`search_page`, etc.). `drutopia_dev.features.yml` (`bundle: drutopia`, `required: true`) marks this
module as a required member of that bundle.

Note: `drutopia_dev_findit` ships a **byte-identical** `features.bundle.drutopia.yml`, which is why
the submodule's README calls the two mutually exclusive (both would install the same config object).

## The "Dev node" Search API index (`config/install/search_api.index.dev_node.yml`)

Installs a Search API index config entity:

- **id** `dev_node`, **name** "Dev node", **server** `database`, `read_only: false`,
  `index_directly: true`, `cron_limit: 50`, tracker `fifo`.
- **Datasource** `entity:node` (all bundles, all languages).
- **Description** (verbatim): *"Use the Dev node index to clone an index per content type."* — i.e. it
  is a template to copy when a developer wants a per-content-type index.
- **Indexed fields**: `rendered_item` (text, viewed as the `anonymous` role), `title` (boost 8),
  `field_tags` (integer; depends on `field.storage.node.field_tags`), `field_summary` (text; depends on
  `field.storage.node.field_summary`), `created`/`changed` (date), `uid`/`name` (author),
  `status`/`sticky`/`promote`/`node_grants` (locked node-access + status fields).
- **Config dependencies**: `field.storage.node.field_tags`, `field.storage.node.field_summary`,
  `search_api.server.database` (so it expects a `database` Search API server and those two node fields
  to exist — provided by the Drutopia feature set).
- **Processors**: `add_url`, `tokenizer`, `aggregated_field`, `stopwords` (standard English list),
  `rendered_item`, `entity_status`, `content_access`, `ignorecase`, `transliteration`, `html_filter`.

The index respects node access: it carries the `node_grants` field and the `content_access` processor,
and `status` is a locked indexed field, so unpublished/private nodes are handled by Search API's normal
access processing rather than exposed by this config.

## Uninstall

Uninstalling `drutopia_dev` removes the module; the `dev_node` index and `drutopia` bundle config it
installed follow normal config-install lifecycle. Because the module pulls in Devel and Entity Clone,
remove it from any environment before it reaches production.
