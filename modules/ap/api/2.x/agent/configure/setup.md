<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API module — setup

1. **Enable** the module (pulls in views, block, comment, link, options, pathauto).
2. **Configure** at `/admin/config/development/api` (`api.settings`, perm `administer API reference`): parsing options, comment settings, file paths.
3. **Quick wizard** at `/admin/config/development/api/wizard` bootstraps a Project + Branch in one step.
4. **Branches** (parsed sources):
   - *Branch* — a local directory of PHP to document.
   - *PhpBranch* — references to functions/constants (for cross-linking to PHP).
   - *ExternalBranch* — pulls reference data from an admin-set URL via `@http_client`.
5. **Parse** a branch: `/admin/config/development/api/branch/{branch}/parse` or Drush. Parsing is queue-backed (`ParseQueueWorker`, `DeleteRelatedQueueWorker`) so run cron / queue workers.
6. **Grant `access API reference`** to the roles that should read the docs (anonymous for a public portal).
7. **Comments import**: `/admin/config/development/api/comments`; the `apidrupalorg` sub-project adds a D7 comments importer.

Display routes live under `/api/{project}/...` with stable URLs (function dump, full lists, namespace, file references, detail pages). Search: `/api/search/...`, `/api/opensearch`, autocomplete.
