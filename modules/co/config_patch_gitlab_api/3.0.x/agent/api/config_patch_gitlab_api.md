<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — GitLab client service

The module wraps `m4tthumphrey/php-gitlab-api` (`Gitlab\Client`) in a thin Drupal service.

## Services (`config_patch_gitlab_api.services.yml`)
- `config_patch_gitlab_api.client_factory` →
  `Drupal\config_patch_gitlab_api\Gitlab\ConfigPatchGitlabClientFactory`, args `['@state']`.
- `config_patch_gitlab_api.client` → built by the factory's `create` method (a
  `ConfigPatchGitlabClient`). In practice callers inject the **factory** and call `create()`
  themselves (so unconfigured credentials surface as an exception at call time).

## Factory — `ConfigPatchGitlabClientFactory::create(array $settings = [])`
- With no `$settings`, reads State key `config_patch_gitlab_api.credentials` (`{url, token}`)
  and validates both are present, else throws `MissingCredentialsException`.
- Builds a `Gitlab\Client`, `setUrl($settings['url'])`, and
  `authenticate($settings['token'], Client::AUTH_HTTP_TOKEN)` (GitLab `PRIVATE-TOKEN`-style
  header auth). Returns a `ConfigPatchGitlabClient`.
- Pass explicit `['url' => ..., 'token' => ...]` to test arbitrary credentials (the credentials
  form does this before saving).

## `ConfigPatchGitlabClient` methods (`src/Gitlab/ConfigPatchGitlabClient.php`)
| Method | GitLab call |
|---|---|
| `getProjects(array $parameters = [])` | `projects()->all($parameters)` (used with `search`) |
| `getProjectById($id)` | `projects()->show($id)` |
| `getBranches(int $project_id)` | paged `repositories()->branches` (per_page 100) |
| `getBranch(int $project_id, $name)` | first branch whose `name` matches, else `NULL` |
| `getCommits(int $project_id, string $branch)` | `repositories()->commits(..., ['ref_name' => $branch])` |
| `diff(int $project_id, string $branch)` | diff of the latest commit on the branch |
| `createCommit(int $project_id, $start_branch, $branch_name, array $actions, $message='')` | `repositories()->createCommit(...)`; adds `start_branch` only when `$branch_name` doesn't exist; author "Drupal Config Patch module," |
| `createMergeRequest(int $project_id, $target_branch, $branch_name, $title)` | `mergeRequests()->create(...)` |
| `getOpenMergeRequest($project_id, $target_branch, $branch_name)` | `mergeRequests()->all(..., state=opened)` for that source/target pair |
| `getTree(int $project_id, string $branch, $path)` | paged `repositories()->tree` (ref+path, per_page 100) |
| `version()` | `version()->show()` — used as a cheap credential check |

## Exception
`Drupal\config_patch_gitlab_api\Exception\MissingCredentialsException` (extends `\Exception`) —
thrown by the factory when the URL or token is missing; callers catch it and link the operator
to the credentials form.

## Autocomplete controller
`ProjectsAutoCompleteController::handleAutocomplete(Request $request)` — reads `q`, `Xss::filter`s
it, calls `getProjects(['search' => $q])`, returns JSON `[{value: "name_with_namespace (id)",
label: name_with_namespace}]`.
