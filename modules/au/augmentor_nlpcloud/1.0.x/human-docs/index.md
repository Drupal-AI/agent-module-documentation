# Augmentor: NLP Cloud — manual setup guide

**Augmentor: NLP Cloud** (`augmentor_nlpcloud`) is a provider plugin for the
[Augmentor](https://www.drupal.org/project/augmentor) framework. Augmentor adds
AI-powered actions to your content and fields — summarize, classify, generate, and so
on — and this module lets those actions run against the
[NLP Cloud](https://nlpcloud.com/) API and its models. By itself it does nothing; it
registers NLP Cloud as an Augmentor provider and waits to be selected.

After you install it alongside Augmentor, you create an Augmentor that uses NLP Cloud
and point your AI operations at it. Augmentor supplies the abstraction and the UI;
this module supplies the connection to the NLP Cloud API.

Two things matter before you rely on it. First, content you augment is **sent to the
NLP Cloud API** for processing — confirm that off-site data egress is acceptable for
the content. Second, it authenticates with an **NLP Cloud API key** over HTTPS, which
is a secret and must be handled as one (see below). The module has no access-control
role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and Augmentor) with
   Composer, then enable it.

## How to use it

This provider has no settings page of its own. After installing and enabling it,
configure it from inside Augmentor:

1. Go to Augmentor's admin section and add a new Augmentor.
2. Choose the **NLP Cloud** provider.
3. Supply your NLP Cloud API key and choose the model/task.
4. Save, then use that Augmentor from the AI actions Augmentor exposes on content and
   fields.

### Handling the NLP Cloud API key safely

Never paste the key into plain configuration that gets exported and committed.
Augmentor integrates the [Key](https://www.drupal.org/project/key) module for
provider credentials, so keep the key in an environment variable and reference it
through a Key entity:

1. Store the secret with DDEV's dotenv helper (keeps it out of version control):

   ```bash
   ddev dotenv set .ddev/.env --nlpcloud-api-key=your-key-here
   ddev restart
   ```

2. Enable the Key module if needed and create a Key that reads the environment
   variable rather than storing the value in the database:

   ```bash
   ddev drush en key -y
   ddev drush key:save nlpcloud_api_key --label='NLP Cloud API Key' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"NLPCLOUD_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

3. Select that Key when configuring the NLP Cloud Augmentor.
