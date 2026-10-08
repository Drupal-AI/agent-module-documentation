<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GitLab API — agent index

Integrates a Drupal site with **GitLab via the GitLab API** (projects/issues/pipelines; `gitlab_server`
config entities). Provides permissions. Config at `entity.gitlab_server.collection`. Version **2.2.0**. Core
`^10||^11`.

**Security:** store the GitLab access token as a **secret** (Key/env), **minimum scopes** (broad token =
big blast radius); HTTPS. No access role beyond permission.
