# Augmentor OpenAI GPT — manual setup guide

**Augmentor OpenAI GPT** (`augmentor_openai_gpt3`) is a provider plugin for the
[Augmentor](https://www.drupal.org/project/augmentor) framework. Augmentor adds
AI-powered actions to your content and fields — summarize, rewrite, classify, and so
on — and this module lets those actions run against OpenAI's GPT models. By itself it
does nothing; it registers OpenAI as an Augmentor provider and waits to be picked.

After you install it alongside Augmentor, you create an Augmentor that uses OpenAI
and point your AI operations at it. Augmentor supplies the abstraction and the UI;
this module supplies the connection to the OpenAI API and the model selection.

Two things matter before you rely on it. First, content you augment is **sent to
OpenAI** for processing — confirm that off-site data egress is acceptable for the
content in question. Second, it authenticates with an **OpenAI API key** over HTTPS,
which is a secret and must be handled as one (see below). The module has no
access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and Augmentor) with
   Composer, then enable it.

## How to use it

Augmentor OpenAI GPT has no settings page of its own. After installing and enabling
it, configure it from inside Augmentor:

1. Go to Augmentor's admin section and add a new Augmentor.
2. Choose the **OpenAI GPT** provider.
3. Supply your OpenAI API key and choose the model.
4. Save, then use that Augmentor from the AI actions Augmentor exposes on content and
   fields.

### Handling the OpenAI API key safely

Never paste the key into plain configuration that gets exported and committed.
Augmentor integrates the [Key](https://www.drupal.org/project/key) module for
provider credentials, so keep the key in an environment variable and reference it
through a Key entity:

1. Store the secret with DDEV's dotenv helper (keeps it out of version control):

   ```bash
   ddev dotenv set .ddev/.env --openai-api-key=sk-your-key-here
   ddev restart
   ```

2. Enable the Key module if needed and create a Key that reads the environment
   variable rather than storing the value in the database:

   ```bash
   ddev drush en key -y
   ddev drush key:save openai_api_key --label='OpenAI API Key' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"OPENAI_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

3. Select that Key when configuring the OpenAI Augmentor.
