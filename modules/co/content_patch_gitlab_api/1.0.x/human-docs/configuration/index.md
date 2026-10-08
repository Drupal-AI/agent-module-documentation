# Configuration

Before you can export content, you need to tell the module which GitLab
repository to target, give it an access token, and decide which roles may trigger
exports. The token is a secret — the sections below cover both the settings form
and how the module expects that token to be stored.

## Open the settings form

Log in as a user with the **Administer site configuration** permission and open
the module's settings page at
**Administration → Configuration → Web services → Content Patch GitLab API
Settings** (`/admin/config/services/content-patch-gitlab-api`). There you
configure:

- **Recipe Directory** — the top-level directory name for the generated recipe
  (default `demo_content`).
- **GitLab URL** — your GitLab instance, e.g. `https://gitlab.com` for
  GitLab.com or your self-hosted URL.
- **Project ID** — the numeric project ID or the URL-encoded path
  (e.g. `12345` or `namespace/project`). The module URL-encodes it for you.
- **Export Path** — the path inside the repository where the exported recipe is
  written (e.g. `recipes/exported-content`).
- **Default Branch** — the branch to branch off from and target the merge request
  against (e.g. `main` or `master`).

The **GitLab Private Token** is **not** entered on this form (see the next
section).

Two permissions govern the module: **Administer site configuration** (core) gates
the settings page, and **Export content to GitLab API**
(`export content to gitlab api`) controls who may run the export from the content
overview. Grant the export permission to the editor/administrator roles that
should be allowed to contribute content, under **People → Permissions**.

## Store the GitLab token in settings.php

This module reads the GitLab access token **only** from your site's
`settings.php` file — it is intentionally never stored in Drupal's configuration
or database, so it stays out of config exports and version control. Add this line
to `settings.php` (or, better, to an untracked `settings.local.php`):

```php
$settings['content_patch_gitlab_api.gitlab_token'] = 'your-private-token';
```

The settings form will show a warning until this value is present.

The token must be a GitLab **personal or project access token** with the scopes
`api` and `write_repository`. Per the module's README, the token's **Role** should
be **Maintainer** — Developer may work in some setups, but Maintainer is usually
required to create branches and push commits when branch protection is active.

Because this token grants write access to your repository, treat it as a secret:
keep it in an environment-specific `settings.php`/`settings.local.php` that is not
committed, and rotate it in GitLab if it is ever exposed.

## Save

Save the settings form. You can now run the export from **Content**
(`/admin/content`) using the per-row **Export to GitLab** operation, as described
in the main guide's [How to use it](../index.md#how-to-use-it) section.
