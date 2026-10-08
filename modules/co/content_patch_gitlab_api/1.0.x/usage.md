<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Exports content to a GitLab repository via the GitLab API (commits / merge requests).

---

Content Patch GitLab API provides content export via the GitLab API — serialising content entities to YAML and pushing them to a GitLab project (creating commits and merge requests through the GitLab REST API), so content changes can be captured as patches in version control for review/deployment.

The GitLab URL, project id, export path and default branch are admin-configured on the settings form; the access token is read from `settings.php` via `$settings['content_patch_gitlab_api.gitlab_token']` (kept out of config/database — there is no token field on the form). The settings page is gated by `administer site configuration`; running an export is gated by `export content to gitlab api`. Trigger it from the per-row **Export to GitLab** operation on a node/media/term, or with the `drush content-patch:export` command to write the package to a local directory. Depends on core `serialization`; supports Drupal 10.5+ and 11.2+.

---

- Export content via the GitLab API.
- Serialise content to YAML.
- Create GitLab commits.
- Open merge requests.
- Capture content as patches.
- Support review/deployment.
- Gate export by permissions.
- Read the token from settings.php.
- Depend on core `serialization`.
- Support Drupal 10.5+ and 11.2+.
- Configure the GitLab connection.
- Push content to GitLab
- Handle content export
- Version content
- Support Drupal.
