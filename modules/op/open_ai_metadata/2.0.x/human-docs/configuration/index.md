# Configuration

Setting up Open AI Metadata is two forms: one to connect your OpenAI account, and
one to choose which content types get the generation buttons.

> **Before you start:** the admin routes reference custom permissions the module
> doesn't define, so you may need to be logged in as user 1 (the superuser) to
> reach these pages.

## Handle the API token as a secret

Your OpenAI access token is a credential that can run up charges on your account,
so keep it out of anything you commit to version control. This module already
stores the token in Drupal's `state` store (not in exported configuration), so it
won't end up in your config sync directory. If you run DDEV, a clean way to get
the value into the environment is to store it with DDEV's dotenv helper and never
commit `.ddev/.env`:

```bash
ddev dotenv set .ddev/.env --openai-api-key=sk-...
ddev restart
```

You then paste the token into the form below.

## Open AI API settings

Go to **Configuration → Open AI Metadata → Open AI API settings**
(`/admin/config/open_ai_metadata/open-ai-api-settings`). This form (the
`MetadataConfigForm`) is where the OpenAI connection is defined:

- **API Endpoint** — the OpenAI chat‑completions URL. The default is
  `https://api.openai.com/v1/chat/completions`. Leave it as the default unless you
  are pointing at an OpenAI‑compatible endpoint of your own.
- **Open AI Access Token** — paste your OpenAI API key here. This is the secret
  described above; it is saved to Drupal `state`, not to config.
- **Open AI API Model Name** — the model to call, for example `gpt-3.5-turbo`.
  Enter the model your OpenAI account has access to.
- **Open AI API Max Token** — a ceiling on the length of the generated output.
  Lower it to keep meta descriptions short; raise it for longer body content.
- **Open AI Temperature** — controls how random/creative the output is. A lower
  value gives steadier, more predictable text; a higher value gives more varied
  wording.

Save the form.

## Content type settings

Go to **Configuration → Open AI Metadata content settings**
(`/admin/config/metadata-content-settings`). Here you select the **content
type(s)** that should get the AI generation features. Only nodes of the types you
tick will show the **Generate Metadata** button and **Generate Content** link on
their edit forms. Save the form.

## Test it

Edit a node of one of the content types you selected. Enter (or confirm) the
title, then click **Generate Metadata** — OpenAI should return a draft meta
description into the Summary field. Try **Generate Content** too: enter a prompt
in the modal, review the result, and click **Use Content** to place it in the
body. Always review and edit generated text before publishing.
