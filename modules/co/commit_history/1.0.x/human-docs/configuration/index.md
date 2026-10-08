# Configuration

Commit History needs two things: a repository connection (so it knows where to
read commits from) and the right permissions (so the correct people can view or
manage it).

## Configure the repository connection

1. Log in as a user with **administer commit history**.
2. Go to **Configuration → Web services → Commit history**
   (`/admin/config/services/commit-history`).
3. Fill in the connection form:
   - **Provider** — choose **GitLab** or **GitHub**.
   - **Repository** — the repository (and any host/URL details) whose commits you
     want to list.
   - **Access token** — a token that can read the repository's commits. This is
     stored in **Drupal state**, not exported to configuration.
4. Save.

> **Token handling.** The token is never written to exported config. When you edit
> the form later, leave the token/password field **empty** to keep the existing
> token — you only need to re‑enter it if you want to change it.

## Set who can access it

Under **People → Permissions**, grant:

- **view commit history** — to roles that should be able to see the report at
  `/admin/reports/commit-history`.
- **administer commit history** — to roles that should be able to change the
  repository connection. Keep this restricted to trusted administrators.

## The history report

Once configured, **Reports → Commit history**
(`/admin/reports/commit-history`) lists the repository's commits and can be
**filtered by year**.

## Handle the token safely

The access token is a secret. The module stores it in **Drupal state** (not exported
config), and the settings form never displays a saved token back to the browser —
leave the token field blank on later edits to keep the existing value.

The module reads the token only from state, so if you would rather not type it into a
shared UI you can seed state from the command line instead of the form (for example in
CI or after a fresh install):

```bash
drush state:set commit_history.settings \
  '{"provider":"gitlab","gitlab_base_url":"https://gitlab.com","gitlab_project_id":"411","gitlab_token":"<value>","gitlab_ref":"main"}' \
  --input-format=json
```

Grant **administer commit history** only to trusted administrators, and always serve
the admin over **HTTPS**.
