# Configuration

openAI Images needs your OpenAI API key before it can generate anything. That's
the whole of the required setup.

## Handle the API key as a secret

Your OpenAI API key is a credential that can run up charges, so keep it out of
version control and serve your site over HTTPS. If you run DDEV, a clean pattern
is to store the value in the environment and never commit `.ddev/.env`:

```bash
ddev dotenv set .ddev/.env --openai-api-key=sk-...
ddev restart
```

You then paste the key into the settings form.

## openAI Images settings

Go to **Configuration → Media → openAI Images settings**
(`/admin/config/media/openai_images_settings`):

- **OpenAI API key** — paste your OpenAI API key here. This authenticates the
  image‑generation requests the module makes to OpenAI.

To obtain a key: sign in to your OpenAI account, open the API keys section at
`platform.openai.com/account/api-keys`, click **Create new secret key**, and copy
the value. Review OpenAI's usage limits and pricing before you rely on it.

Save the form.

## Test it

Use the module's create‑image form to enter a short description and generate an
image. Confirm the result is saved as a media entity in your media library at
**Content → Media**. Because each generation is a paid call, keep an eye on usage.
