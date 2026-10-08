# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- The **Metatag** module (`drupal/metatag`, `^2 || ^1.2`) — supplies the Metatag
  field this module writes into.
- The **AI** module (`drupal/ai`, `^1.3@beta`) — supplies the chat provider that
  actually generates the text.

Both are Composer dependencies and are pulled in automatically. You will also
need at least one **working AI chat provider** configured in the AI module
(under **Configuration → AI**, `/admin/config/ai`) with a valid API key —
without an active provider the "Generate Metatag" button does not appear.

## Install with Composer

From the project root:

```bash
composer require drupal/metatag_ai -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Metatag, AI, and
any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/metatag_ai -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en metatag_ai -y
```

Drupal enables Metatag and AI at the same time as dependencies. There are no
submodules of its own.

## After enabling

Three things need to be in place before the button will work:

1. **A Metatag field** on the content type(s) you want to use — by default the
   module looks for a field named `field_metatag`. Add the field via
   **Structure → Content types → *(type)* → Manage fields** if it isn't there.
2. **An AI provider** configured and active at **Configuration → AI**, with its
   API key supplied through an environment variable / Key entity (never
   hard‑coded).
3. The module's own settings — see [Configuration](../configuration/index.md).

> **API keys and secrets.** Store the AI provider's key in an environment
> variable and reference it via a Key entity or `getenv()`. Do not commit secrets
> to version control.
