# Configuration

OpenAI Client needs your OpenAI API token before it can do anything. Setting the
token also tells the module which models your account can use, so it's the first
and most important step.

## Handle the API token as a secret

Your OpenAI token is a credential that can run up charges, so keep it out of
version control and out of exported configuration. Serve your site over HTTPS so
the token isn't sent in the clear. If you run DDEV, a clean pattern is to store
the value in the environment and never commit `.ddev/.env`:

```bash
ddev dotenv set .ddev/.env --openai-api-key=sk-...
ddev restart
```

You then paste the token into the settings form.

## OpenAI Client settings

Go to **Configuration → System → OpenAI Client**
(`/admin/config/system/openai-client`):

- **OpenAI API token** — paste your OpenAI API key here. As soon as a valid token
  is saved, the page displays the **available models** your account can access.
- **Default model** — choose which model the chat features (the *AI conversation*
  content type) use by default. Pick one of the models listed after the token is
  validated.

Save the form.

## Lock down who can invoke OpenAI

Because every call sends data to OpenAI and costs money, review the module's
permissions at **People → Permissions** and grant them only to trusted roles. In
particular, the *openai_client create image form* permission controls access to
the image‑creator form at `/openai-client/create-image`.

## Test it

Create an **AI conversation** node and send a message to confirm the model
responds. To test image generation, ensure your role has the create‑image
permission and visit `/openai-client/create-image`. If the model you selected
supports images in chat, you can also paste a Base64‑encoded image into a
conversation.
