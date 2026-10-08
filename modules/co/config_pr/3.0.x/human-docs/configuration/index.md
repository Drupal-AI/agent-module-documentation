# Configuration

Configuring Config PR means connecting it to your Git host and giving each operator a Git
access token, then using the Pull Request tab to push configuration.

## Who can configure and use it

Config PR provides two permissions, both flagged as security-sensitive to grant:

- **Administer Config Pull Request** — access the settings page (choose the provider and repo).
- **Issue configuration pull requests** — use the Pull Request tab and enter a personal access
  token.

Because a pull request pushes your configuration to a repository using a privileged token,
grant these permissions **only to trusted operators**.

## Step 1 — create an API token on your Git host

On your Git host (GitHub or GitLab), create a personal access token that can create branches
and pull/merge requests on the target repository. **Scope it to the least privilege needed** —
ideally limited to the single repository Config PR will push to, rather than a broad
account-wide token. Copy the token; most hosts show it only once.

- GitHub: a fine-grained personal access token with **Contents** and **Pull requests**
  read/write on the repository.
- GitLab: a personal access token with the **`api`** scope.

## Step 2 — enter the token on your user profile

Each operator enters **their own** token, not a site-wide one. Go to your user account's
**Edit** page (`/user/{your-uid}/edit`) and fill in the **Repository Access Token** field, then
save. This field is only visible to users who hold the *Issue configuration pull requests*
permission. Config PR reads the token from the profile of whoever is issuing the pull request,
so different operators can use their own credentials, and revoking a person's access is a matter
of clearing their field (or the token on the host).

If you ever suspect a token has been exposed, **revoke and rotate it** on the Git host.

## Step 3 — connect the repository

On the settings page
(`/admin/config/development/configuration/pull_request/settings`), choose the **Repo provider**
(GitHub, GitHub Enterprise, GitLab, or GitLab self-managed), set the **Repo owner** and **Repo
name** (Config PR pre-fills these from the site's local `.git/config` when it can), and — for a
self-hosted GitHub Enterprise or GitLab instance — set the **Repository URL**. You can also
customise the commit-message templates used for created/updated/deleted/renamed files. Config
PR checks that the token can authenticate against the repository before it creates pull
requests.

## Step 4 — issue a pull request

1. Make your configuration changes through the Drupal admin UI as normal.
2. Go to the Configuration Management area and open the **Pull Request** tab.
3. **Select the configuration items** you want to keep in the pull request.
4. Pick a **source branch**, a new **branch name** (defaults to `YYYYMMDD-config`), and give
   the request a **title** and **description**.
5. Submit. Config PR authenticates, creates the branch, commits the selected configuration YAML
   files, and opens the pull/merge request on your Git host. You get a link to the new request,
   and the page lists the repo's currently open pull requests.
6. A reviewer reviews, comments, and merges or rejects the request on the host, exactly as with
   any other code change.

> You can create pull requests only after the repository already contains an initial commit of
> your configuration.

## A note on what you push

Depending on your site, **exported configuration can contain sensitive values**. Before
pushing, review the configuration you have selected, and push to a **private repository**.
Combined with careful token scoping, that keeps Config PR's convenience from becoming an
exposure.
