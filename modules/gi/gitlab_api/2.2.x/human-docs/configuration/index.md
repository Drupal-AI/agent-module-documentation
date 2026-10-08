# Configuration

Configuring GitLab API means creating one or more **GitLab server profiles** —
each describes a GitLab instance and holds the access token the module uses to
authenticate. You can create as many as you need to talk to different GitLab
instances.

## Create an access token in GitLab

In your GitLab instance, create a **personal access token** (or a project/group
access token) with only the **scopes you actually need** — for read‑only work,
`read_api` is usually enough; grant `api` only if you must write. A narrowly
scoped token limits the damage if it is ever exposed.

## Store the token as a secret

The access token is a credential — **do not paste it into configuration that gets
exported to your repository, and never commit it.** Store it in an environment
variable and reference it, ideally through a **Key** entity.

With DDEV, save the token into the project's dotenv file and restart:

```bash
ddev dotenv set .ddev/.env --gitlab-api-token=<your-token>
ddev restart
```

That makes it available as `GITLAB_API_TOKEN` in the container. Then, if the Key
module is available, create a Key backed by that environment variable and point
the server profile at the Key rather than at the raw token value. Keep
`.ddev/.env` out of version control.

> **Egress note:** the module makes outbound HTTPS calls to your GitLab instance.
> If your environment restricts outbound traffic, allow egress to that GitLab
> host, and always use an `https://` base URL so the token is never sent in the
> clear.

## Add a GitLab server profile

1. Go to the **GitLab server** collection page — from the module's *Configure*
   link on **Extend**, or under **Configuration → Web services**.
2. Add a new server and fill in its details:
   - A **label** (and machine name) to identify this instance.
   - The GitLab instance's **base URL** (over HTTPS).
   - The **access token** to authenticate with — referencing the environment
     variable or Key you set up above rather than pasting the secret directly.
3. Save the profile. Repeat for each GitLab instance you need to reach.

## A note on git.drupalcode.org

If you configure a server for Drupal's own GitLab at `git.drupalcode.org`, be
aware that access may be limited by that instance's permission policy — some API
resources may not be available to your token.

## Using it

Once a server profile exists, the `gitlab_api.api` service and its client can make
calls against that instance. The bundled **webform handler** can create a new
GitLab project from a webform submission, and the optional ECA integration lets
ECA models call the API — both use the server profiles you configure here.
