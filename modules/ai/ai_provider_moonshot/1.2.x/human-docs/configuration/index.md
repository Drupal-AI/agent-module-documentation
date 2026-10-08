# Configuration

Moonshot AI Provider has its own settings form, reachable under **Configuration →
AI** (`/admin/config/ai`) or via the **Configure** link beside the module on the
**Extend** page. You need the **Administer site configuration** / AI provider
administration permission (an administrator by default).

## 1. Store the API key as a secret

Do not paste the key into a plain configuration field. Keep it in an environment
variable exposed through a **Key** entity.

1. Save the value with DDEV (never commit `.ddev/.env`):

   ```bash
   ddev dotenv set .ddev/.env --moonshot-api-key=<your-key>
   ddev restart
   ```

2. Confirm the container sees it *without* printing it:

   ```bash
   ddev exec 'test -n "$MOONSHOT_API_KEY" && echo set'
   ```

3. Create a Key entity backed by that variable at **Configuration → System →
   Keys → Add key** (`/admin/config/system/keys`) using the **Environment** key
   provider pointing at `MOONSHOT_API_KEY`, or with Drush:

   ```bash
   drush key:save moonshot_api_key --label='Moonshot API Key' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"MOONSHOT_API_KEY"}' \
     --key-input=none -y
   ```

## 2. Configure the Moonshot connection

Open the provider's settings form and supply the **API key** (select the Key
entity you created) to authenticate the connection to the Moonshot API. Save.

## 3. Choose Moonshot for AI operations

In the AI module's settings, set Moonshot (and a specific model) as the provider
for whichever operations you want it to power. Pin a specific model rather than
relying on a default so behaviour does not drift.

## Security notes

- **Store the API key as a secret** (Key entity / environment variable), never in
  plain configuration or version control.
- **Prompts sent leave the site.** Treat content going to Moonshot — especially
  unpublished content or personal data — as an external data transfer.
- Use **HTTPS** endpoints; the key is a spending credential, so consider a spend
  limit at the provider.
