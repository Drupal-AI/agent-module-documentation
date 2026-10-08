# Configuration

Setting up Atlassian Crowd has two parts: securely storing the Crowd **application
credentials** (the account your Drupal site uses to talk to Crowd), and then telling
the module about your Crowd server and how you want login to behave.

## Step 1 — Store the Crowd credentials securely (Key + environment variable)

Crowd application credentials are secrets, so they should never be typed into plain
configuration or committed to your repository. The module uses the **Key** module so
you can back the credential with an environment variable.

On DDEV, save the secret into DDEV's dotenv file and restart so the container picks
it up:

```bash
ddev dotenv set .ddev/.env --crowd-app-password=<value>
ddev restart
```

The flag `--crowd-app-password` becomes the environment variable
`CROWD_APP_PASSWORD`. **Never commit `.ddev/.env`** — keep it out of version control.

Confirm the variable is present in the container *without printing its value*:

```bash
ddev exec 'test -n "$CROWD_APP_PASSWORD"'   # exit status 0 means it is set
```

Then create a **Key** entity that reads from that environment variable (enable the
Key module first if needed with `ddev drush en key -y`):

```bash
ddev drush key:save crowd_app_password --label='Crowd application password' \
  --key-type=authentication --key-provider=env \
  --key-provider-settings='{"env_variable":"CROWD_APP_PASSWORD","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

> **Egress caveat:** this module reaches out to your Crowd server over the network.
> Make sure your environment actually allows that outbound (egress) connection —
> firewalls or locked-down hosting can block it — and that there is an open HTTP(S)
> link between the Drupal and Crowd servers.

## Step 2 — Configure the connection and behavior

1. Log in as an administrator and open the module's settings form (via the
   **Configure** link next to Atlassian Crowd on the **Extend** page).
2. Point Drupal at your **Crowd server** and supply the **application name** and the
   **application password** (selecting the Key you created in Step 1 rather than
   typing the secret).
3. Configure the login behavior you want:
   - **Crowd SSO cookie detection** — automatically log in users who are already
     authenticated via Crowd.
   - **Automatic account creation** — create a matching Drupal account the first time
     a Crowd user logs in (via External Authentication; a random local password is
     set).
   - **Group-to-role mapping** — associate Crowd groups with Drupal roles so
     permissions follow the user's Crowd group membership.
   - **Self-service form redirects** — send Drupal's self-service user forms (for
     example password reset) to their Crowd equivalents, so users manage their
     accounts in Crowd.
4. Save the form.

## Verify

Log out and sign in with a Crowd account. You should be authenticated against Crowd,
a Drupal account should be present (created automatically if it's the first login),
and any configured group-to-role mapping should apply.
