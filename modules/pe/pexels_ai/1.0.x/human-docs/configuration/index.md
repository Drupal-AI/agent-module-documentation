# Configuration

Configuring Pexels AI is mostly about getting your **Pexels API key** stored
securely and pointing the module at it. Once that is done, the search/download
tools are available to your AI agents.

## 1. Get a Pexels API key

Sign in at the Pexels developer/API site and create an API key. You will paste
this value into a **Key** entity in Drupal (below), not directly into the
module's settings.

## 2. Store the key with the Key module (recommended)

The module uses the **Key** module so the API key is held as a managed secret
rather than sitting in plain configuration. The most secure approach is to keep
the key value in an environment variable and have Key read it from there.

With DDEV:

```bash
# Store the value in the environment (keep .ddev/.env out of version control)
ddev dotenv set .ddev/.env --pexels-api-key=<your-key>
ddev restart

# Confirm the variable is present in the container WITHOUT printing it
ddev exec 'test -n "$PEXELS_API_KEY"'   # exit status 0 means it is set
```

Then create a Key entity backed by that environment variable (enable the Key
module first if needed with `drush en key -y`):

```bash
drush key:save pexels_api_key \
  --label='Pexels API Key' \
  --key-type=authentication \
  --key-provider=env \
  --key-provider-settings='{"env_variable":"PEXELS_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

You can also create the Key through the UI at **Configuration → System → Keys**
(`/admin/config/system/keys`) — choose the *Environment* provider and point it at
your variable so the secret is never stored in the database or exported config.

## 3. Point the module at the key

1. Go to **`/admin/config/pexels_ai/settings`**.
2. Select the **Pexels API key** — choose the Key entity you created above.
3. Save the form.

## 4. Use the tools with an AI agent

With the key in place, the module's Pexels **search** and **download** function
calls are available to your AI agents. Configure an agent (in the AI Agents
module) that is allowed to use these tools, and it can search Pexels and import
matching photos/videos as Drupal **media** entities.

## Good practice

- **Keep the key secret.** Storing it via the Key module's environment provider —
  rather than in plain config — is the correct pattern; don't paste the raw key
  into exported configuration.
- **Scope your agents.** Because these tools call the Pexels API and create media,
  limit which agents may use them and be careful about letting untrusted input
  drive them — that guards against runaway API usage and cost.
- **Mind licensing.** Media imported from Pexels is third‑party stock; follow the
  Pexels license for how you use it.
