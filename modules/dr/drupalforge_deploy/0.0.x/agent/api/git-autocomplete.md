<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Git-reference autocomplete controller & route

Class `GitReferenceAutocompleteController` (`src/Controller/GitReferenceAutocompleteController.php`),
implements `ContainerInjectionInterface`. Injects only `drupalforge_deploy.git_repository_inspector`
(typed as `object` and read via `create()`).

## Route

`drupalforge_deploy.git_reference_autocomplete` →
`/admin/config/development/drupalforge-deploy/git-reference-autocomplete`, requirement
`_permission: 'administer drupalforge deploy'` (the same restricted permission as the deploy form —
**not** anonymous or weakly gated). Wired to the form field `selected_branch` via
`#autocomplete_route_name` in `DrupalForgeDeployForm`.

## `autocomplete(Request $request): JsonResponse`

1. Calls `resolveInspection()` → `gitRepositoryInspector->inspect(getcwd())`; if that is not a git
   repo, retries with the `DRUPAL_ROOT` constant. The inspected path is **server-derived
   (`getcwd()` / `DRUPAL_ROOT`), never taken from the request** — the request cannot point the
   inspector at an arbitrary path or URL.
2. Reads the query param `q` (`$request->query->getString('q','')`), lowercased/trimmed. `q` is used
   **only** for a case-insensitive `str_contains` substring match against the already-computed
   `remote_branches` list — it is not passed to git, the shell, or any HTTP fetch.
3. Builds up to **10** matches from `inspection['remote_branches']`, promoting
   `tracked_remote_branch` to the front when it matches, and returns them as
   `[{ "value": <ref>, "label": <ref> }, …]` JSON.

So this endpoint only enumerates the local repo's remote branch names (e.g. `origin/main`) to a
holder of the restricted deploy permission; it performs no repository fetch of its own.
