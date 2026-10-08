<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Patch GitLab API is an output plugin for the Config Patch module: it takes the configuration diff Config Patch produces and pushes it to a GitLab project over the GitLab REST API, committing the changed `.yml` files to a new branch and opening (or updating) a merge request.

---

Drupal configuration is code, but it is edited through admin forms, so it drifts out of the repository unless someone remembers to export and commit it. Config Patch closes that gap by turning the live configuration changes into a patch; this add-on is the delivery mechanism that lands the patch in GitLab. It registers a `config_patch` output plugin (`id: config_patch_gitlab_api`, label "Merge requestion in Gitlab with API") that, on export, builds a GitLab "create a commit with multiple files and actions" request — one create/update/delete/move action per changed config object — commits it onto a freshly named source branch (default `config-patch-<timestamp>`) created from a start branch, and then either opens a new merge request against the target branch or reports the already-open one. The GitLab connection is set up in two admin screens: a credentials form for the instance URL and a GitLab project access token (needs `api` and `write_repository` scopes), and a project/branch form that uses an autocomplete against the GitLab projects API to pick the target project and its default merge target branch. Under the hood a thin `ConfigPatchGitlabClient` wraps the `m4tthumphrey/php-gitlab-api` library (projects, branches, commits, diff, tree, merge-requests endpoints); a client factory reads the saved credentials from Drupal's State API and authenticates with an HTTP token header. Both a UI export (at `/admin/config/development/configuration/patch/config_patch_gitlab_api`) and a Drush export (`drush config:patch config_patch_gitlab_api --message=...`) are supported, the latter adding `--start-branch`, `--source-branch` and `--target-branch` options to Config Patch's `config:patch` command. The credentials screen is gated by `administer site configuration`; the project/branch screen and the project autocomplete by the module's own `administer config_patch_gitlab_api` permission (`restrict access: true`). The release is `3.0.0-alpha3` — an alpha that writes to your repository, so exercise it against a scratch project first.

---

- Push a Drupal configuration change to GitLab as a new branch and commit.
- Turn an admin-UI config edit into a GitLab merge request automatically.
- Review configuration changes as code in GitLab's MR workflow.
- Capture production config drift back into the repository.
- Let site builders change configuration without losing it at the next deploy.
- Target a specific GitLab project and default branch for config MRs.
- Pick the target GitLab project with a type-ahead autocomplete.
- Work against a self-hosted or SaaS GitLab instance (any URL).
- Commit multiple changed config objects in one GitLab commit (create/update/delete/move actions).
- Name the source branch per export, or accept the `config-patch-<timestamp>` default.
- Choose the start branch a new source branch is cut from.
- Update the existing open merge request instead of opening a duplicate.
- Export config to GitLab from the command line with `drush config:patch config_patch_gitlab_api`.
- Pass a commit message and branch names as Drush options in CI.
- Stage a batch of configuration changes for a release branch.
- Keep configuration deployment inside your existing GitLab review process.
- Avoid manual `drush config:export` + git commit steps.
- Support non-default config collections by mirroring collection paths under the config base path.
- Restrict who may configure the GitLab connection via a dedicated permission.
- Validate GitLab credentials up front (the forms make a version call before saving).
- Detect config changed on production but not in code, then open an MR to reconcile.
