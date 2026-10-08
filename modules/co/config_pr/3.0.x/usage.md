<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config PR allows administrators to issue pull requests of configuration changes.

---

Config PR lets administrators **open pull requests of configuration changes** to a Git host — diffing the
changed config and creating a PR/MR on GitHub or GitLab (via provider submodules), pushed directly through the
host's REST API, so config changes made in the UI can flow into a code-review/deployment workflow. It depends
on core Config and Field, provides its own permissions, in the Administration package.

Use it to push config changes to Git as PRs. It is a DevOps/administration feature. Each operator authenticates
with a **Git host API token**, which they enter on their own user-profile edit page (the "Repository Access
Token" field); scope that token to the least privilege needed. Note **exported configuration can contain
sensitive values** depending on your setup, so review what config is pushed and prefer a **private repository**.
Gate its permissions to trusted operators. Configure the Git provider and repo on the settings page.

---

- Open config-change PRs to Git.
- Support GitHub and GitLab (Bitbucket is an inert stub).
- Flow UI config into code review.
- Depend on core Config and Field.
- Provide its own permissions.
- Push selected config to a branch via the host API.
- Enter the Git token on your user profile.
- Scope the token to least privilege.
- Review sensitive config before pushing.
- Push to a private repository.
- Gate the permissions to trusted operators.
- Configure the Git provider and repo.
- Handle config PRs.
- Create pull requests.
- Configure the provider.
- Push config.
- Handle the integration.
- Issue PRs.
- Secure the token.
- Provide config pull requests.
