<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commit History — settings, state keys & provider construction

## Install / enable

```bash
composer require drupal/commit_history      # pulls spiriitlabs/commit-history 1.*
drush en commit_history -y
```

No module dependencies. The library is a Composer dependency, not a `/libraries` asset.

## Settings form

`CommitHistorySettingsForm` (`src/Form/CommitHistorySettingsForm.php`, form id
`commit_history_settings`, route `commit_history.settings` at
`/admin/config/services/commit-history`, permission `administer commit history`). It does NOT
extend `ConfigFormBase` — it reads and writes **Drupal state**, not config, so nothing is
exported to sync.

Fields (labels are partly French in source):

- `provider` — select, `gitlab` | `github` (default `gitlab`).
- GitLab fieldset (shown when provider = gitlab): `gitlab_base_url` (default
  `https://gitlab.com`), `gitlab_project_id` (numeric id or `group/project`), `gitlab_token`
  (password), `gitlab_ref` (branch/tag, default `main`).
- GitHub fieldset (shown when provider = github): `github_base_url` (default
  `https://api.github.com`), `github_owner`, `github_repo`, `github_token` (password),
  `github_ref` (default `main`).
- `commit_filter` — substring filter applied to commit title/message on the report page.

`validateForm()` requires base URL + project id (GitLab) or base URL + owner + repo (GitHub) for
the selected provider. `submitForm()` writes everything to state key `commit_history.settings`.

Token handling: the token fields are `#type => password` with no `#default_value`, so an existing
token is never rendered back to the browser. On save, an empty token field **preserves** the
previously stored token (`!empty($token) ? $token : ($existing[...] ?? '')`). Tokens live only in
state, never in exported config.

## State key: `commit_history.settings`

A flat array with keys: `provider`, `gitlab_base_url`, `gitlab_project_id`, `gitlab_token`,
`gitlab_ref`, `github_base_url`, `github_owner`, `github_repo`, `github_token`, `github_ref`,
`commit_filter`. Seed it without the UI, e.g.:

```bash
drush state:set commit_history.settings \
  '{"provider":"gitlab","gitlab_base_url":"https://gitlab.com","gitlab_project_id":"411","gitlab_token":"TOKEN","gitlab_ref":"main"}' \
  --input-format=json
```

## Provider construction

`ProviderFactory::create()` (`src/Service/ProviderFactory.php`) reads the state array and returns:

- `github` → `Spiriit\CommitHistory\Provider\Github\GithubProvider` (headers
  `Accept: application/vnd.github+json`, `Authorization: Bearer <token>`; paginates via the
  `Link` header).
- otherwise → `Spiriit\CommitHistory\Provider\Gitlab\GitlabProvider` (header
  `PRIVATE-TOKEN: <token>`; paginates `page`/`per_page`).

Both wrap the core `http_client` (Guzzle) through `DrupalHttpClient`
(`src/HttpClient/DrupalHttpClient.php`), so requests use Drupal's standard HTTP stack (default
TLS verification). `token`/`ref` are passed as `null` when empty.

## Report page behaviour

`CommitHistoryController::page` builds a `FeedFetcher` for the current provider, calls
`fetch($year)` (year range Jan 1–Dec 31), then applies `commit_filter` with a case-insensitive
`str_contains` over each commit's `title`/`message`. `getAvailableYears()` returns the current
year plus the previous five. Any exception during fetch is caught and its message passed to the
template as `error`. Output is a `commit_history_page` render array cached for 3600s.
