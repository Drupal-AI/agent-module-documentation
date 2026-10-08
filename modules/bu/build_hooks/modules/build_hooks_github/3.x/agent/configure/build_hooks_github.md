<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring build_hooks_github

Grounded in `build_hooks_github.routing.yml`, `config/{install,schema}/build_hooks_github.*`,
`src/Form/BuildHooksGithubConfigForm.php`, and
`src/Plugin/FrontendEnvironment/GithubFrontendEnvironment.php`.

## Site-wide token

Form: `/admin/config/build_hooks_github/buildhooksGithubconfig`
(route `build_hooks_github.build_hooks_github_ci_config_form`, permission
`administer site configuration`). Stores `build_hooks_github.settings`:

```yaml
github_access_token: ''   # GitHub personal access token (PAT)
```

The field is a textfield with `#default_value` = the stored token. A `settings.php` override also works:

```php
$config['build_hooks_github.settings']['github_access_token'] = getenv('GITHUB_TOKEN');
```

## Environment fields (plugin `github`)

Schema `frontend_environment.settings.github`:

| Field | Config path | Notes |
|---|---|---|
| Build hook url | `build_hook_url` | the GitHub dispatch/build-hook endpoint to POST to |
| Git branch | `branch` | sent as `ref` in the JSON body |

## The deploy request

`GithubFrontendEnvironment::getBuildHookDetails()` builds:

```
POST {build_hook_url}
options: {
  headers: { Content-Type: application/json, Authorization: 'token {github_access_token}' },
  body: '{"ref":"{branch}"}'
}
```

The token is sent as an `Authorization` header (not in the URL). No recent-builds table is shown on the
deploy form (`getAdditionalDeployFormElements()` returns `[]`). Success detection uses the base class
default: `deploymentWasTriggered()` = TRUE for HTTP 200 or 201.
