# Configuration

Setting up Config Patch GitLab API has two parts: telling it how to authenticate with
GitLab (the credentials), and choosing which project and branch a pushed patch should land
on. **Please read the security section before you enter your token.**

## Who can configure it

The credentials form is gated by the **Administer config patch GitLab API**
(`administer config_patch_gitlab_api`) permission, which is marked *restrict access* —
meaning it grants a genuinely sensitive capability and should be given only to trusted
operators. Anyone with it can reach the token, so keep the list short.

## Step 1 — create a GitLab project access token

In GitLab, on the project you want configuration pushed to, create a **project access
token** with the **`api`** and **`write_repository`** scopes. That token can push branches
to the repository, so treat it like a password. Copy it once — GitLab shows it only at
creation time.

## Step 2 — store the token safely (do this first)

**Important security note.** The credentials form collects the token in a plain text field,
stores it in configuration, and renders it back as the field's default value every time the
form is opened. In practice that means:

- The live token appears in the page HTML for anyone who can open the credentials form.
- The token is written into **configuration exports** and **database dumps**.

To reduce the exposure:

- **Prefer a [Key](https://www.drupal.org/project/key) entity backed by an environment
  variable** where your setup allows it, so the secret value lives in the environment rather
  than in exported configuration. On DDEV, store the value out of version control with
  `ddev dotenv set .ddev/.env --gitlab-token=<value>` and then `ddev restart` so the
  container picks it up; confirm it is present without printing it using
  `ddev exec 'test -n "$GITLAB_TOKEN"'` (exit status 0 means it is set). Never commit
  `.ddev/.env` and never paste the token into a commit, chat, or ticket.
- If you must enter the token directly into the form, **exclude the credentials
  configuration object from your configuration exports** (for example with
  [Config Ignore](https://www.drupal.org/project/config_ignore)) so it does not travel into
  Git, and **rotate the token** immediately on any suspicion that it has been seen.

## Step 3 — enter the GitLab connection

On the credentials form (`config_patch_gitlab_api.credentials`), provide the GitLab
connection details — the GitLab instance/base URL and the project access token from Step 1
— and save.

## Step 4 — choose the project and branch

When you push a patch, the plugin lets you:

- **Select the target project** — start typing and pick it from the autocomplete list.
- **Choose the source branch** to branch from.
- **Set a custom name for the new branch**, so it follows your project's naming conventions.

## Using it

Once configured, the day‑to‑day flow lives in Config Patch: make your configuration changes
in the admin UI, generate a patch with Config Patch, and choose the **GitLab API** output
plugin. The plugin creates the branch, commits and pushes the patch with your commit
message, and then hands you a direct link to open the merge request in GitLab, where a
reviewer takes over.

## A final reminder

This is release **3.0.0‑alpha3** — an alpha, on a feature that writes to your repository.
Point it at a **scratch GitLab project** and confirm the whole branch/push/merge‑request
flow behaves before you use it against a repository that matters.
