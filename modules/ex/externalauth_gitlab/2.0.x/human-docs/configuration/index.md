# Configuration

Configuring GitLab login is a three-part job: register an OAuth application on
GitLab, enter its details on the module's settings form, and make sure matching
Drupal accounts exist.

## Step 1 — Register an OAuth application on GitLab

On your GitLab instance, create an OAuth application (for a self-hosted instance
this is typically under **Admin area / User settings → Applications**). You'll
need:

- A **redirect URI / callback URL** pointing back at your Drupal site. The module
  uses your site's own login path — `https://<your-site>/user/login/gitlab` — as
  the callback, so register that exact URL and make sure it's **HTTPS**.
- The **scopes** the module needs to read the user's identity (at minimum enough
  to read the account email, since users are matched by email).

GitLab then gives you an **Application ID** (the client ID) and a **Secret** (the
client secret). Keep both handy for the next step, and treat the secret as a
credential.

## Step 2 — Enter the module settings

Go to **Configuration → People → Gitlab OAuth settings**
(`/admin/config/people/externalauth-gitlab-settings`). The form has three fields:

- **Client ID** — the Application ID from GitLab.
- **Client secret** — the Secret from GitLab.
- **Domain** — the base URL of the GitLab instance you're authenticating against
  (for example `https://gitlab.example.com` or `https://gitlab.com`). Point this
  only at a **trusted** instance, over HTTPS.

Save the form.

> **Note on the client secret.** This module stores all three values, including
> the client secret, in Drupal's configuration for the `externalauth_gitlab`
> module — it does not read the secret from an environment variable or the Key
> module. Because the secret lives in config, keep it out of exported
> configuration you commit to version control (or scrub/override it in your
> deployment pipeline), and limit the *administer externalauth_gitlab settings*
> permission to trusted administrators, since anyone with that permission can view
> and change it on the form.

## Step 3 — Make sure matching accounts exist, then test

Because the module matches users **by email and does not create accounts**, make
sure a Drupal account exists whose email matches the GitLab account you'll test
with. Then go to `/user`, follow the GitLab login local task, authenticate on
GitLab, and confirm you're returned and logged in to Drupal.

## Operations checklist

- Use **HTTPS** for the redirect URI, the GitLab instance, and your own site.
- Point the module only at a **GitLab instance you trust** — it is the authority
  deciding who gets to log in.
- Restrict the *administer externalauth_gitlab settings* permission to trusted
  administrators.
- Keep the client secret out of any configuration you export and commit (see the
  note in Step 2).
