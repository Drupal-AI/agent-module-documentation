# Auphonic — manual setup guide

**Auphonic** (`auphonic`) connects Drupal to
[Auphonic](https://auphonic.com/), a hosted audio-post-production service. Auphonic
does the kind of processing a podcast or video producer would otherwise do by hand:
loudness/level normalization, noise and hum reduction, and speech-to-text
transcription. This module lets your site call that service through Drupal's
[AI](https://www.drupal.org/project/ai) module abstraction, so audio-processing
becomes just another AI operation available on the site.

It is a provider for the AI module rather than a standalone tool — it depends on the
`ai` module and slots in as an audio-focused backend. On its own it does nothing until
you configure it with your Auphonic credentials and drive it from an AI workflow.

Two things matter before you rely on it. First, audio you process is **sent to the
Auphonic API** — audio recordings can be sensitive, so confirm that off-site egress is
acceptable for your material. Second, it authenticates with an **Auphonic API key**
over HTTPS, which is a secret and must be handled as one (see below). The module has
no access-control role of its own. Note that this is an early **beta** release.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and the AI module) with
   Composer, then enable it.

## How to use it

Auphonic is configured as a provider within the AI module rather than through a
settings page of its own:

1. Install and enable the AI module and Auphonic.
2. In the AI module's provider configuration, supply your Auphonic credentials
   (API key).
3. Drive audio processing (leveling, noise reduction, transcription) through the AI
   operations that use the Auphonic provider.

### Handling the Auphonic API key safely

Never paste the key into plain configuration that gets exported and committed. Keep it
in an environment variable and reference it through a
[Key](https://www.drupal.org/project/key) entity:

1. Store the secret with DDEV's dotenv helper (keeps it out of version control):

   ```bash
   ddev dotenv set .ddev/.env --auphonic-api-key=your-key-here
   ddev restart
   ```

2. Enable the Key module if needed and create a Key that reads the environment
   variable rather than storing the value in the database:

   ```bash
   ddev drush en key -y
   ddev drush key:save auphonic_api_key --label='Auphonic API Key' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"AUPHONIC_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

3. Select that Key when configuring the Auphonic provider in the AI module.
