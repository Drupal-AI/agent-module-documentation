# Environment Indicator — manual setup guide

**Environment Indicator** (`environment_indicator`) adds a coloured strip to the
top of your Drupal site — and, optionally, a tinted favicon — that tells you at a
glance which environment you are looking at: **Development**, **Staging**,
**Production**, and so on. When you work across several copies of the same site,
this visual cue is what stops you editing content or running a destructive
operation on production when you thought you were on local.

Each environment can be given its own colour and label, so production might show
a bold red bar while your local copy shows a calm green one. The indicator can
also display a **version identifier** (a release number, deployment identifier,
or git SHA) next to the environment name, so you know exactly which build you are
looking at.

This guide is written for a **human** clicking through the admin UI. It walks you,
step by step, from installing the module to configuring the colours and the
version identifier. If you are looking for terse, token-cheap references for an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

![The Environment Indicator Settings page](images/settings.png)

## Where it lives in the admin menu

Everything in this guide sits under **Configuration → Development → Environment
Indicator** (`/admin/config/development/environment-indicator`). That page has two
tabs:

- **Settings** — the global options covered in this guide: the version-identifier
  source, the favicon, and the (deprecated) toolbar option.
- **Environment Switcher** — where you define switcher entries that link between
  your environments (see [Configuration](configuration/index.md)).

## Contents

1. [Installation](installation/index.md) — install Environment Indicator with
   Composer, enable it, and grant the permission that makes the bar visible.
2. [Configuration](configuration/index.md) — set the version-identifier source and
   favicon, then give each environment its own colour and name via `settings.php`.
