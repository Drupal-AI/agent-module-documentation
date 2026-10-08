# Configuration

Writing Assistant needs your **Conductor API credentials** before it can do anything. Conductor
authenticates with **two values** — an **`api_key`** and a **`shared_secret`** — which the module reads
as a single **JSON** value: `{"api_key": "…", "shared_secret": "…"}`. The module uses the **Key**
module to hold that JSON securely, so the recommended flow is: put the JSON in an environment variable,
create a Key entity that reads it, then point the module at that Key.

## 1. Get your Conductor API credentials

In Conductor, generate an **API key and shared secret** from **Integrations / API** in the dashboard
menu (see also <https://www.conductor.com/lp/content-insights-drupal/>). You will end up with a small
JSON document:

```json
{
  "api_key": "{api_key}",
  "shared_secret": "{shared_secret}"
}
```

Keep it handy but do not paste it into any file you commit to version control.

## 2. Store the credentials as an environment variable (recommended)

Never hard-code or commit the secret. Store the whole JSON string in one environment variable. With
DDEV:

```bash
ddev dotenv set .ddev/.env --conductor-credentials='{"api_key":"…","shared_secret":"…"}'
ddev restart
```

The flag `--conductor-credentials` becomes the environment variable `CONDUCTOR_CREDENTIALS`. Keep
`.ddev/.env` out of version control. Confirm it's set **without printing its value**:

```bash
ddev exec 'test -n "$CONDUCTOR_CREDENTIALS"'   # exit status 0 means it is set
```

## 3. Create a Key entity backed by that variable

The Key module is installed as a dependency. Create a Key that reads the environment variable using
Key's built-in `env` provider. The module json-decodes the value, so the README recommends key type
**Authentication (Multivalue)**:

```bash
ddev drush key:save conductor_credentials \
  --label='Conductor API Credentials' \
  --key-type=authentication_multivalue \
  --key-provider=env \
  --key-provider-settings='{"env_variable":"CONDUCTOR_CREDENTIALS","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

You can also create the Key through the UI at **Configuration → System → Keys → Add key**
(`/admin/config/system/keys/add`) if you prefer — set the key type to **Authentication (Multivalue)**
and paste the JSON `{"api_key": "…", "shared_secret": "…"}` as the value (or select the environment
provider). See the [Key module documentation](https://www.drupal.org/docs/contributed-modules/key) for
provider options.

## 4. Connect the module to the Key

1. Open the Writing Assistant settings page at
   **Configuration → System → Services → Writing Assistant settings**
   (`/admin/config/services/conductor`), as a user with the *Conductor SEO* (`administer conductor`)
   permission.
2. In **API Credentials**, select the **Conductor API Credentials** key you just created.
3. Save. The form tests the connection and reports whether it reached the Conductor API.

The same page has an **Orphaned Draft Cleanup** section — an opt-in checkbox that lets cron delete
untracked "Untitled Canvas draft:" drafts from your Conductor account. It is **off by default**; leave
it off if several environments share one Conductor account.

## Verify and mind the data-flow

Open a content item in **Canvas** and use the **Writing Assistant** extension from the left-hand
sidebar — Conductor's writing/SEO guidance should now appear. Remember that content or topic data you
work on is sent to Conductor's service for analysis; review that against your organisation's
data-handling and privacy policies.
