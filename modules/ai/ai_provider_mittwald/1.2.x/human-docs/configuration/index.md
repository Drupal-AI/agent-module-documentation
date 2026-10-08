# Configuration

Configuration is two steps: store the mittwald credential as a **Key** entity
backed by an environment variable, then select that Key on mittwald's provider
settings. You need the **Administer AI providers** permission (an administrator by
default).

## 1. Store the credential as a secret

Keep the credential in an environment variable exposed through a Key entity — not
in a plain configuration field.

1. Save the value with DDEV (never commit `.ddev/.env`):

   ```bash
   ddev dotenv set .ddev/.env --mittwald-api-key=<your-key>
   ddev restart
   ```

2. Confirm the container sees it *without* printing it:

   ```bash
   ddev exec 'test -n "$MITTWALD_API_KEY" && echo set'
   ```

3. Create a Key entity backed by that variable at **Configuration → System →
   Keys → Add key** (`/admin/config/system/keys`) — choose the **Environment**
   key provider pointing at `MITTWALD_API_KEY` — or with Drush:

   ```bash
   drush key:save mittwald_api_key --label='mittwald API Key' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"MITTWALD_API_KEY"}' \
     --key-input=none -y
   ```

## 2. Register mittwald as a provider

1. Go to **Configuration → AI → Providers** (`/admin/config/ai/providers`) and
   open the **mittwald** provider settings.
2. Select the **Key** you created above.
3. Save.

## 3. Choose mittwald for AI operations

In the AI module's settings, set mittwald (and a specific model) as the provider
for the operations you want it to power, or select it wherever an individual
feature lets you pick a provider. Pin a specific model rather than relying on a
default.

## Things to keep in mind

- **Cost and data egress.** Every request sends prompt content to mittwald's API —
  it incurs cost and the content leaves your site. Treat prompts containing
  personal data or unpublished content accordingly.
- **Keep the secret in env/Key**, never in exported configuration or version
  control.
