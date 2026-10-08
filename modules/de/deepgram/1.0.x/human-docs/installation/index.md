# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2||^11`).
- The **AI** module (`ai`) — Deepgram is a provider plugin for it.
- The **Key** module (`key`) — used to store the Deepgram API key securely.
- A **Deepgram account** and API key (free trials are available at deepgram.com).

There are no additional PHP or front‑end library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/deepgram -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the AI and Key
modules and update any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/deepgram -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en deepgram -y
```

Enabling it pulls in the AI and Key modules automatically if they are not already
on.

## Next step

Deepgram needs your API key before it can do anything. Head to
[Configuration](../configuration/index.md) to store the key securely with the Key
module and connect it to the AI provider.

## Verify it worked

Once you have completed the configuration steps, run a small test through whatever
AI feature you set up — for example, an AI Automator that transcribes an uploaded
MP3 into a text field. A successful transcription (or a generated audio file for
text‑to‑speech) confirms the provider, the Key, and your Deepgram account are all
wired up correctly.
