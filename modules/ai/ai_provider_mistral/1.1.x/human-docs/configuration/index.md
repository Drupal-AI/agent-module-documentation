# Configuration

Configuration is two steps: store the Mistral API key as a **Key** entity backed
by an environment variable, then select that Key on Mistral's provider settings.
You need the access‑restricted **Administer AI providers** permission (an
administrator by default).

## 1. Store the API key as a secret

Do not paste the key into a plain configuration field. Follow the project
convention and keep it in an environment variable exposed through a Key entity.

1. Save the value with DDEV (never commit `.ddev/.env`):

   ```bash
   ddev dotenv set .ddev/.env --mistral-api-key=<your-key>
   ddev restart
   ```

2. Confirm the container sees it *without* printing it:

   ```bash
   ddev exec 'test -n "$MISTRAL_API_KEY" && echo set'
   ```

3. Create a Key entity backed by that variable (enable the Key module first if
   needed) at **Configuration → System → Keys → Add key**
   (`/admin/config/system/keys`). Choose the **Environment** key provider and
   point it at `MISTRAL_API_KEY`. You can also do it with Drush:

   ```bash
   drush key:save mistral_api_key --label='Mistral API Key' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"MISTRAL_API_KEY"}' \
     --key-input=none -y
   ```

## 2. Register Mistral as a provider

1. Go to **Configuration → AI → Providers** (`/admin/config/ai/providers`) and
   open the **Mistral** provider settings.
2. Select the **Key** you created above as the API key. The provider now
   authenticates to the Mistral API on your behalf.
3. Save.

## 3. Choose Mistral for AI operations

In the AI module's settings, set Mistral (and a specific model) as the provider
for whichever operations you want it to power — chat, summarisation, embeddings,
and so on. **Pin a specific model** rather than relying on a default so behaviour
does not shift under you.

## Things to keep in mind

- **The key is a spending credential.** A Mistral key can incur real cost
  quickly — set a spend limit at the provider and have someone watch it.
- **A prompt is a disclosure.** Whatever you send leaves the site. Unpublished
  content, personal data and internal notes in a prompt need the same
  consideration as any other transfer — though with Mistral that transfer stays
  in the **EU**, which is the point of choosing it.
- **Model availability changes.** Know what the site does when a pinned model is
  withdrawn or its behaviour shifts under the same name.
