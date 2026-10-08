<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring build_hooks_circleci

Grounded in `build_hooks_circleci.routing.yml`, `config/{install,schema}/build_hooks_circleci.*`,
`src/Form/BuildHooksCircleCiConfigForm.php`, `src/CircleCiManager.php`, and
`src/Plugin/FrontendEnvironment/{CircleCiFrontendEnvironment,CircleV2}.php`.

Two plugins ship: **`circleci`** (API v1.1) and **`circleciv2`** (API v2). Prefer v2 for new sites.

## Settings form (V1 key only)

`/admin/config/build_hooks_circleci/buildhookscircleciconfig`
(route `build_hooks_circleci.build_hooks_circle_ci_config_form`, permission
`administer site configuration`). Stores `build_hooks_circleci.settings`:

```yaml
circleci_api_key: ''   # site-wide, used by the V1 'circleci' plugin only
```

The field is a textfield whose `#default_value` is the current key. A `settings.php` override also works
(README's recommendation):

```php
$config['build_hooks_circleci.circleCiConfig']['circleci_api_key'] = getenv('CIRCLECI_API_KEY');
# (the module reads build_hooks_circleci.settings:circleci_api_key)
$config['build_hooks_circleci.settings']['circleci_api_key'] = getenv('CIRCLECI_API_KEY');
```

The **v2** plugin does NOT use this key — its token is stored per environment (see below).

## Plugin `circleci` (V1) environment fields

Schema `frontend_environment.settings.circleci`: `project` (`org/repo`) and `branch`.
`CircleCiManager::getBuildHookDetailsForPluginConfiguration()` builds:

```
POST https://circleci.com/api/v1.1/project/github/{project}/build?circle-token={circleci_api_key}
options: { json: { branch } }
```

## Plugin `circleciv2` (V2) environment fields

Schema `frontend_environment.settings.circleciv2`:

| Field | Config path | Notes |
|---|---|---|
| Token | `token` | **per-environment** CircleCI token; used as HTTP Basic auth |
| Project | `project` | `organisation/repository` |
| Reference type | `type` | `branch` or `tag` |
| Branch / Tag | `reference` | the ref to build |
| Parameters | `parameters[]` | rows of `{name, type: string\|boolean\|integer, value}` |

`CircleV2::getBuildHookDetails()` builds:

```
POST https://circleci.com/api/v2/project/gh/{project}/pipeline
options: {
  json: { <type>: <reference>, parameters: { name: castValue, ... } },
  auth: [token, '']            // HTTP Basic (token as username)
}
```

Booleans/integers are cast from the row `value` (`(bool)`, `(int)`); enter `0` for a false boolean.
`deploymentWasTriggered()` accepts any HTTP 2xx. The deploy form lists the **last 5** pipelines/workflows
for the reference (GET `…/pipeline/mine` then `…/pipeline/{id}/workflow`) with an AJAX **Refresh** button.
The token is entered in a textfield (`#default_value` = stored token).
