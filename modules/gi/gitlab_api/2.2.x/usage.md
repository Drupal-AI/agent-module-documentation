<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GitLab API integrates your Drupal site into GitLab using the GitLab API.

---

GitLab API integrates Drupal with GitLab — using the GitLab API to interact with GitLab (projects,
issues, pipelines, etc.) from Drupal, configured via `gitlab_server` config entities. It provides its own
permissions, in the Web services package.

Use it to connect Drupal to GitLab. Security note: it authenticates to GitLab with an access token —
**store that token as a secret** (Key entity / environment variable), not in exported config, and grant the
token the **minimum scopes** needed (GitLab tokens can be powerful — a broad token is a big blast radius);
operate over HTTPS. It has no access-control role beyond its permission. Configure the GitLab server
connection.

---

- Integrate Drupal with GitLab.
- Use the GitLab API.
- Interact with projects/issues/pipelines.
- Configure gitlab_server entities.
- Provide its own permissions.
- Store the GitLab token as a secret.
- Grant the token minimum scopes.
- Mind the token's blast radius.
- Operate over HTTPS.
- Have no access-control role beyond permission.
- Configure the GitLab connection.
- Connect to GitLab.
- Handle credentials securely.
- Configure the server.
- Interact with GitLab.
- Use GitLab data.
- Handle the API token.
- Configure credentials.
- Integrate GitLab.
- Connect the API.
