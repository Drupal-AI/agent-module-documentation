# ChatGPT Augmentor — manual setup guide

**ChatGPT Augmentor** (`augmentor_chatgpt`) is a provider plugin for the
[Augmentor](https://www.drupal.org/project/augmentor) framework. Augmentor is the
module that adds AI-powered "augment this text" actions to your content and fields
(summarize, rewrite, generate, classify, and so on); ChatGPT Augmentor is the piece
that lets those actions run against OpenAI's ChatGPT models. On its own it does
nothing — it plugs a ChatGPT backend into Augmentor and waits to be selected.

Once installed alongside Augmentor, you can create an Augmentor of type "ChatGPT"
and point your AI operations at it. Augmentor supplies the abstraction and the UI;
this module supplies the connection to the OpenAI API and the model settings.

Two things are worth understanding before you rely on it. First, any content you
run through it is **sent to OpenAI** for processing — that is fine for public
marketing copy, but think twice before sending private or regulated content off to
a third-party API. Second, it authenticates with an **OpenAI API key**, which is a
secret and must be treated as one (see below).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and Augmentor) with
   Composer, then enable it.

## How to use it

ChatGPT Augmentor has no settings page of its own. After you install and enable it,
you configure it from inside Augmentor:

1. Go to Augmentor's admin section and add a new Augmentor.
2. Choose **ChatGPT** as the type/provider.
3. Supply your OpenAI API key and pick the model you want to use.
4. Save, then use that Augmentor from the AI actions Augmentor exposes on your
   content and fields.

### Handling the OpenAI API key safely

Never paste the key into plain configuration that gets exported and committed.
Augmentor integrates the [Key](https://www.drupal.org/project/key) module for
provider credentials, so the recommended flow is to keep the key in an environment
variable and reference it through a Key entity:

1. Store the secret with DDEV's dotenv helper (this keeps it out of version
   control):

   ```bash
   ddev dotenv set .ddev/.env --openai-api-key=sk-your-key-here
   ddev restart
   ```

2. Enable the Key module if it isn't already, then create a Key that reads the
   environment variable rather than storing the value in the database:

   ```bash
   ddev drush en key -y
   ddev drush key:save openai_api_key --label='OpenAI API Key' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"OPENAI_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

3. Select that Key when configuring the ChatGPT Augmentor.
