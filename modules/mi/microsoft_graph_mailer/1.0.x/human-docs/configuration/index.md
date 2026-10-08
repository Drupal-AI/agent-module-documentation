# Configuration

Microsoft Graph Mailer needs configuration before it will send anything. There
are two parts: creating an **Azure AD app registration** in the Microsoft side,
and entering those credentials on the module's **settings form** in Drupal. This
page also explains how to keep the client secret out of version control.

## 1. Create an Azure AD app registration

In the Azure / Entra admin centre:

1. Register a new **application** for your Microsoft 365 tenant.
2. Note the **Directory (tenant) ID** and the **Application (client) ID** — you
   will paste both into Drupal.
3. Create a **client secret** for the app and copy its value immediately (Azure
   only shows it once).
4. Grant the app the **least Graph Mail permissions it actually needs**. If you
   only send mail, grant send-only permissions; add mail-read permissions only if
   you rely on the receive side. Have an administrator grant admin consent for
   the permissions if your tenant requires it.

## 2. Enter the credentials in Drupal

On the Microsoft Graph Mailer settings form, provide:

- **Tenant ID** — the Directory (tenant) ID from the app registration.
- **Client ID** — the Application (client) ID.
- **Client secret** — the secret value you created in Azure.
- The **sending mailbox / from address** the app is authorised to send as.

Save the form. Depending on your site's mail setup, you may also need to tell
Drupal to use this mailer — for example by selecting it as the mail plugin for
the relevant mail keys (core's Symfony Mailer / Mail System configuration is
where the site decides which plugin sends which message). Once selected, outgoing
mail — including attachments — is delivered through Microsoft Graph.

## Keep the client secret out of version control

This is the most important operational point for this module. The client secret
is stored in the `microsoft_graph_mailer.settings` configuration, which is part
of Drupal's **config export/sync** — the files most teams commit to Git. A
committed secret is a leaked secret.

Follow the project's standard secret-handling practice instead of typing the
secret into config that gets exported:

1. **Store the secret in an environment variable**, never in committed code or
   config. With DDEV, set it via the built‑in dotenv helper (this writes
   `.ddev/.env`, which must stay out of version control):

   ```bash
   ddev dotenv set .ddev/.env --graph-client-secret=<value>
   ddev restart
   ```

   The flag `--graph-client-secret` becomes the environment variable
   `GRAPH_CLIENT_SECRET` inside the web container.

2. **Prefer a Key entity** to feed the secret to Drupal where possible. Install
   the [Key](https://www.drupal.org/project/key) module if it is not already
   enabled, confirm the variable is present in the container **without printing
   its value**, then create a Key backed by the environment provider:

   ```bash
   ddev composer require drupal/key
   ddev drush en key -y
   ddev exec 'test -n "$GRAPH_CLIENT_SECRET"'   # exit status 0 means it is set
   ddev drush key:save graph_client_secret \
     --label='MS Graph client secret' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"GRAPH_CLIENT_SECRET","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

3. If you must place the secret directly in the exported config for a quick test,
   **do not commit that config**, and restrict who can view configuration on the
   site (config access effectively exposes the secret to anyone who can read it).

4. Always send over **HTTPS**, and rotate the secret if it is ever exposed.

## Test it

Send a test email from the site (for example via a contact form or a Drush mail
command) and confirm it arrives. Check the site logs if delivery fails —
authentication and permission problems from Graph are reported there.
