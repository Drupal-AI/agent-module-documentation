# Alt Text Generator — manual setup guide

**Alt Text Generator** (`alt_text_generator`) uses an **AI vision model** to write
descriptive **alternative text** for your images automatically. Instead of an
editor composing a description for every uploaded image by hand, the module can
look at the image and propose alt text the editor can accept into the field.

Under the hood it exposes an endpoint that takes an image's file ID and a language
and returns generated alt text. The generation call runs against your site's
configured AI provider using the site's API key, which has a practical
consequence: **every generation costs money** at your AI provider. The generate
endpoint is available to any role with basic content access, so keep an eye on who
can trigger it and monitor your provider spend. The module's own settings are
restricted to administrators.

It depends on core's **Image** module and supports Drupal 10 and 11. Because it
relies on an AI provider and an API key, there is a little more setup than a
typical small module — the [Configuration](configuration/index.md) page walks
through it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — connect an AI provider, provide the
   API key, and control who can generate alt text.

## Where it lives in the admin menu

Its settings form sits under **Configuration** and requires the **Administer site
configuration** permission. Generation itself happens from the image widget while
editors work. See [Configuration](configuration/index.md) for the setup.
