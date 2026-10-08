<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the canonical schema path (`backend_config.repo_path`)

There is no settings page. Configuration is a single field added to each Solr-backed **Search API
server** edit form, and its value lives on that server's own config object.

## Where the field appears

`search_api_solr_schema_check_form_alter()` (`search_api_solr_schema_check.module:6`) targets form id
**`search_api_server_edit_form`**. It only injects the field when the backend form exposes an
`$form['backend_config']['advanced']` group (i.e. the server uses a Search API Solr backend that renders
its *Advanced* settings). It adds:

```php
$form['backend_config']['advanced']['repo_path'] = [
  '#type' => 'textfield',
  '#title' => t('Solr config repo path'),
  '#default_value' => $repo_path,           // current backend_config.repo_path, or ''
  '#description' => t('Path to where the solr config is stored within your repo. …'),
];
```

In the UI: **Configuration → Search and metadata → Search API →** edit your Solr **Server →** the
backend's **Advanced** section → **"Solr config repo path"**. Editing the server (which requires the
`administer search_api` permission) and saving persists the value.

## What to put there

The directory that holds the canonical Solr config files — the ones you would otherwise download as
`config.zip` from Search API Solr and deploy to the core — typically the copy committed to your repo
(e.g. `solr/conf` or a `jump-start/…/conf` directory). The check reads every *file* directly inside that
directory (non-recursive; subdirectories are skipped) and compares them to the running core.

## Where it is stored / how the check reads it

The value ends up on the Search API server config object **`search_api.server.<server_id>`** under
**`backend_config.repo_path`**. Both the form default and `hook_requirements()` read it via
`\Drupal::service('config.factory')->getEditable('search_api.server.' . $server_id)->get('backend_config')`
then `$backend_config['repo_path']`.

Path resolution (`search_api_solr_schema_check.install:34`): if `repo_path` starts with `/` it is used
as an **absolute** path; otherwise it is resolved as `DRUPAL_ROOT . '/' . $repo_path` (relative to the
Drupal document root). Leave it empty to disable the check for that server — an empty `repo_path` is
skipped entirely.

> Note: this module ships **no config schema** for the `repo_path` key. The value rides on the
> `search_api.server.*` config object that Search API Solr owns.
