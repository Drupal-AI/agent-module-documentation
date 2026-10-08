<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring build_hooks_bitbucket

Grounded in `build_hooks_bitbucket.routing.yml`, `config/{install,schema}/build_hooks_bitbucket.*`,
`src/Form/SettingsForm.php`, `src/BitbucketManager.php`, and
`src/Plugin/FrontendEnvironment/BitbucketFrontendEnvironment.php`.

## 1. Site-wide credentials

Form: `/admin/config/system/build-hooks-bitbucket` (route `build_hooks_bitbucket.settings_form`,
permission `administer site configuration`). Stored in `build_hooks_bitbucket.settings`:

```yaml
username: ''   # Bitbucket account/workspace username
password: ''   # Bitbucket APP PASSWORD (not the account password)
```

Used together as Guzzle HTTP Basic `auth` for every Bitbucket environment. The form shows `username`
as a plain textfield and `password` as a write-only `#type => password` widget (leave blank to keep the
current value). The password is persisted in config; a `settings.php` override also works:

```php
$config['build_hooks_bitbucket.settings']['username'] = getenv('BITBUCKET_USER');
$config['build_hooks_bitbucket.settings']['password'] = getenv('BITBUCKET_APP_PASSWORD');
```

Set via drush:

```bash
drush cset build_hooks_bitbucket.settings username my-user -y
drush cset build_hooks_bitbucket.settings password 'app-password' -y
```

## 2. Environment fields (plugin `bitbucket`)

When adding a frontend environment of type **Bitbucket Pipelines Build**, the plugin form
(`frontEndEnvironmentForm`) collects, stored under the environment's `settings`
(schema `frontend_environment.settings.bitbucket`):

| Field | Config path | Notes |
|---|---|---|
| Repo workspace | `repo.workspace` | from `bitbucket.org/{workspace}/{slug}` |
| Repo slug | `repo.slug` | the repository slug |
| Reference type | `ref.type` | `branch` or `tag` |
| Reference name | `ref.name` | branch/tag to build |
| Pipeline type | `selector.type` | `custom` or `pull-requests` |
| Pipeline name | `selector.name` | pattern/name of the pipeline to trigger |

## 3. The deploy request

`BitbucketManager::getBuildHookDetailsForPluginConfiguration()` builds:

```
POST https://api.bitbucket.org/2.0/repositories/{workspace}/{slug}/pipelines/
options: {
  json: { target: { type: "pipeline_ref_target", ref_name, ref_type,
                     selector: { type, pattern } } },
  auth: [username, password]   // HTTP Basic
}
```

`deploymentWasTriggered()` returns TRUE only for **HTTP 201**. The deploy form also renders a "Recent
deployments" table via `retrieveLatestBuilds()` (GET `…/pipelines/?sort=-created_on&pagelen=15` filtered
by branch/tag) with an AJAX **Refresh** button.
