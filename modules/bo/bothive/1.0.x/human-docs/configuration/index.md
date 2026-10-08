# Configuration

Bothive Chatbot connects your site to your Bothive account and embeds the chatbot
widget. Setup has three parts: the permission, the connection details, and safe
handling of any secret credential.

## Set the permission

Bothive defines the **`administer bothive configuration`** permission. Under
**People → Permissions** (`/admin/people/permissions`), grant it to the role that
should manage the chatbot — typically a site administrator. Only users with it can
open the settings form.

## Connect your Bothive account

Open the Bothive settings form and enter the account details the widget needs
(the identifier and any token Bothive provides for your account). Save, then load
a front-end page to confirm the widget appears and connects to your Bothive
assistant.

## Handle credentials safely — keep secrets out of committed config

If Bothive requires a secret API token or key, do **not** paste it into
configuration that gets exported and committed to version control. Store it in an
environment variable instead, and reference that variable from the site.

With DDEV, set the variable without ever committing it:

```bash
ddev dotenv set .ddev/.env --bothive-api-key=<your-token>
ddev restart
```

The flag `--bothive-api-key` becomes the environment variable `BOTHIVE_API_KEY`
inside the web container. Keep `.ddev/.env` out of version control. You can
confirm the variable is present **without printing its value**:

```bash
ddev exec 'test -n "$BOTHIVE_API_KEY"'   # exit status 0 means it is set
```

Then reference it from the site — for example via a **Key** entity using the
environment provider (if the module supports a Key), or from `settings.php` with
`getenv('BOTHIVE_API_KEY')`. This keeps the secret out of the database export and
out of Git.

## Review privacy before going live

The widget loads Bothive's third-party JavaScript, so visitor interactions leave
your site and go to Bothive. Review their privacy and data-flow terms and reflect
the integration in your own privacy notice before enabling it for real visitors.

## Verify

Load a front-end page as a normal visitor and confirm the Bothive chatbot widget
appears and responds. If it does not load, re-check the account details and, if
you used an environment variable, that it is set in the running container.
