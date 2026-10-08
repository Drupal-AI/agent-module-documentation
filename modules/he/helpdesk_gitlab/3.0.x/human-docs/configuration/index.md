# Configuration

You configure GitLab for Helpdesk Integration as a **GitLab integration inside the
Helpdesk Integration framework** — there is no separate settings page for this
module. The two things you must supply are the GitLab connection details and a GitLab
access token, and the token needs careful handling.

## 1. Create a GitLab access token

In GitLab, create an access token (a project, group, or personal access token,
depending on how you scope your setup) that can **create and comment on issues** in
the project you want tickets to land in. Grant it the **least privilege** required —
avoid broad admin scopes it does not need. Copy the token value; you will not be able
to see it again in GitLab.

## 2. Store the token securely

The access token is a powerful secret. **Never type it into configuration that gets
exported to Git, and never commit it.** Store it in an environment variable instead.
With DDEV:

```bash
ddev dotenv set .ddev/.env --gitlab-helpdesk-token=<the-token>
ddev restart
```

The flag `--gitlab-helpdesk-token` becomes the environment variable
`GITLAB_HELPDESK_TOKEN` inside the web container. Keep `.ddev/.env` out of version
control, and confirm the variable is present **without printing it**:

```bash
ddev exec 'test -n "$GITLAB_HELPDESK_TOKEN"' && echo "set"
```

Where the integration supports referencing a **Key** entity for the token, create one
backed by that environment variable (install the Key module first with
`ddev composer require drupal/key && ddev drush en key -y`) so Drupal reads the secret
at runtime rather than storing it in configuration.

## 3. Create the GitLab integration in Drupal

1. Log in as an administrator.
2. Go to **Configuration → Web services → Helpdesk**
   (`/admin/config/services/helpdesk`).
3. Create a new integration and choose **GitLab** as the platform.
4. Enter the connection settings:
   - The **GitLab instance URL** (for example `https://gitlab.com` or your
     self‑hosted address).
   - The **target project** where issues should be created (as required by the form).
   - The **access token** — point it at the Key you created, or otherwise populate it
     from the environment variable rather than pasting the literal value.
5. Save the integration.

## 4. Grant permissions and expose the helpdesk

Permissions and the user‑facing `/helpdesk` page are provided by the Helpdesk
Integration framework, not by this module. Grant the framework's helpdesk permission
to the appropriate roles at **People → Permissions**
(`/admin/people/permissions`), and add a menu link to `/helpdesk` — see the
[Helpdesk Integration configuration guide](../../../../helpdesk_integration/3.0.x/human-docs/configuration/index.md)
for details.

## 5. Test the sync

Create a test issue from the `/helpdesk` page as a permitted user and confirm it
appears as an **issue in the configured GitLab project**, and that comments made in
Drupal show up as comments on the GitLab issue. If nothing syncs, re‑check the token
value loaded into the container and that the token's scope allows creating issues in
that project.

## Security recap

- The **GitLab access token is a powerful secret** — scope it to least privilege,
  store it in an environment variable (and a Key entity where supported), and never
  commit it.
- All traffic to GitLab is **outbound HTTPS API calls**; keep the GitLab URL on
  HTTPS.
- Restrict who can edit helpdesk integrations, since the connection settings govern
  where your users' ticket data is sent.
