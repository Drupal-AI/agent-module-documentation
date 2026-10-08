# Configuration

Getting a GitLab source to appear in Project Browser is a two-step dance: first
you **define** the source here, then you **enable** it in Project Browser itself.

## Step 1 — Define a GitLab source

1. Log in as a user who can administer the module and go to **Configuration →
   Development → Project Browser Gitlab**
   (`/admin/config/development/project_browser_gitlab`).
2. Add a new GitLab source. You will point it at your GitLab instance — its
   endpoint/URL — and, for a private or self-hosted instance, provide an access
   token so the module can read your projects. A public GitLab source may not
   need one.

### Handling the GitLab token safely

If your GitLab instance is private, the source needs a **personal / project
access token** with read access to the projects you want to browse. Treat that
token as a secret:

- **Never commit it** to your repository or paste it into exported configuration
  in plain text.
- With **DDEV**, store it as an environment variable rather than in a file that
  gets committed:

  ```bash
  ddev dotenv set .ddev/.env --gitlab-token=<your-token>
  ddev restart
  ```

  Keep `.ddev/.env` out of version control.
- Where the module (or a companion) supports a **Key** entity, prefer storing the
  token via the [Key](https://www.drupal.org/project/key) module using its
  environment provider, so the secret is read from the environment variable at
  runtime and never lives in config.
- Scope the token to the **least access** it needs (read-only on the relevant
  projects) so a leak has limited blast radius.

Also remember this creates **outbound network access** from your Drupal server to
your GitLab instance — make sure that egress is allowed in whatever environment
you deploy to.

## Step 2 — Enable the source in Project Browser

1. Go to **Configuration → Development → Project Browser**
   (`/admin/config/development/project_browser`).
2. Enable your newly defined GitLab source there.

## Verify

Open **Extend → Browse** (`/admin/modules/browse`). Your GitLab source should now
be one of the sources you can browse, listing the modules from your GitLab
instance.
