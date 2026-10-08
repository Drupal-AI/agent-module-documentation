<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commit History (commit_history) — agent index

info.yml name: **Commit History**. Admin report page that lists the commit history of a
**GitLab** or **GitHub** repository, fetched over HTTP via the `spiriitlabs/commit-history`
PHP library (Composer `require`). Version 1.0.1. Core `^10 || ^11`. No Drupal module
dependencies.

What it provides:

- Two routes (both `_admin_route`):
  - `commit_history.list` → `/admin/reports/commit-history`, permission `view commit history`.
    Controller `CommitHistoryController::page` (`src/Controller/`). Reads `?year=` (cast to
    int, defaults to current year), fetches commits for that year via `FeedFetcher`, optionally
    filters by the configured `commit_filter` substring, renders `#theme` `commit_history_page`
    (max-age 3600). Fetch errors are caught and shown as a message on the page.
  - `commit_history.settings` → `/admin/config/services/commit-history`, permission
    `administer commit history` (`restrict access: TRUE`). Form
    `CommitHistorySettingsForm` (`src/Form/`).
- Permissions (`commit_history.permissions.yml`): `view commit history`,
  `administer commit history` (restricted).
- Service `ProviderFactory` (`src/Service/`, autowired) builds a `GitlabProvider` or
  `GithubProvider` from state config; `DrupalHttpClient` (`src/HttpClient/`) adapts the core
  `http_client` (Guzzle) to the library's `HttpClientInterface`.
- Theme hook `commit_history_page` via `CommitHistoryThemeHooks` (`src/Hook/`, `#[Hook('theme')]`
  + legacy shim in `.module`); template `templates/commit-history-page.html.twig`; CSS library
  `commit_history/commit-history`.
- Menu links (`.links.menu.yml`): report under **Reports**, settings under **Configuration**.

Configuration is stored in **Drupal state** under key `commit_history.settings` (NOT config
entities — no config schema despite data.json; nothing is exported). Tokens are sent as request
headers (`PRIVATE-TOKEN` for GitLab, `Authorization: Bearer` for GitHub) by the library.

- Settings form, state keys, provider construction, token handling → [config/settings.md](config/settings.md)
