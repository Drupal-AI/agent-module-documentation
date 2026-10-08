<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring build_hooks_netlify

Grounded in `build_hooks_netlify.routing.yml`, `config/{install,schema}/build_hooks_netlify.*`,
`src/Form/BuildHooksNetlifyConfigForm.php`, `src/NetlifyManager.php`, and
`src/Plugin/FrontendEnvironment/NetlifyFrontendEnvironment.php`.

## Site-wide token (for listing deploys only)

Form: `/admin/config/build_hooks_netlify/buildhooksNetlifyconfig`
(route `build_hooks_netlify.build_hooks_netlify_ci_config_form`, permission
`administer site configuration`). Stores `build_hooks_netlify.settings`:

```yaml
netlify_api_key: ''   # Netlify personal access token
```

Rendered with `#type => textfield` + `#default_value` = stored token. This token is used **only** to fetch the recent-deploys table; it is NOT used to
trigger the build. Prefer a `settings.php` override:

```php
$config['build_hooks_netlify.settings']['netlify_api_key'] = getenv('NETLIFY_API_KEY');
```

## Environment fields (plugin `netlify`)

Schema `frontend_environment.settings.netlify`:

| Field | Config path | Notes |
|---|---|---|
| Build hook url | `build_hook_url` | Netlify build-hook endpoint; POSTed to on deploy (this URL is itself the trigger secret) |
| API id | `api_id` | Netlify site id, used to list deploys |
| Git branch | `branch` | filters the recent-deploys list |

## Deploy request

`NetlifyFrontendEnvironment::getBuildHookDetails()`:

```
POST {build_hook_url}          # no auth, no body — Netlify build hooks need none
```

Success detection = base class default (`deploymentWasTriggered()` TRUE for HTTP 200/201).

## Recent deploys (deploy form)

`getAdditionalDeployFormElements()` renders a "Recent deployments" table (state / started / finished /
error message) with an AJAX **Refresh** button. `NetlifyManager::retrieveLatestBuildsFromNetlifyForEnvironment()`
calls:

```
GET https://api.netlify.com/api/v1//sites/{api_id}/deploys?access_token={netlify_api_key}
```

then filters results to `branch` client-side.
