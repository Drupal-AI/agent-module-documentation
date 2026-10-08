# ConvertKit — The Creator Marketing Platform — manual setup guide

**ConvertKit** (`convertkit_esp`) integrates the ConvertKit (now **Kit**) v3
marketing API with your Drupal site, so you can subscribe visitors to forms and
sequences, tag subscribers, and embed ConvertKit signup forms. Under the hood it
talks to `https://api.convertkit.com/` over HTTPS using an API key (for public
reads and subscribes) and an API secret (for account and subscriber lookups),
wrapped in a small service and API client.

It gives you several ways to connect a Drupal site to ConvertKit: **blocks** for
embedding a single signup form or several forms, a **field type/widget/formatter**
so a content author can pick a form per entity, and a **Webform handler** that
subscribes Webform submissions to a chosen ConvertKit tag. Access to its settings
is gated by the `administer convertkit configuration` permission.

You will need ConvertKit API credentials (an API key, an API secret, and at least
one tag ID) from ConvertKit's developer portal. The module can read them from the
admin settings form or, as recommended, from your `settings.php`. Because those are
secrets, store them in an environment variable rather than committing them — see
[Configuration](configuration/index.md).

Two honest caveats from the code are worth knowing. This module is **not** covered
by Drupal's security advisory policy, so review it before production use. And its
optional **debug logging** references an undefined `Logger` class, so turning debug
logging on can cause a fatal error unless that is resolved — leave it off unless
you know what you are doing.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the permission, store your API
   credentials safely, and wire up blocks or the Webform handler.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Web services →
ConvertKit** (`/admin/config/services/convertkit`), reachable by users with the
*administer convertkit configuration* permission.

## How to use it

After you have entered credentials (see [Configuration](configuration/index.md)),
you can surface ConvertKit in a few ways:

- **Blocks** — at **Structure → Block layout**, place the ConvertKit signup form
  block (single form) or the multi‑form block to embed signup forms on the site.
- **Field** — add the ConvertKit field to a content type so an author can choose a
  form per node.
- **Webform handler** — on a Webform, add the ConvertKit handler to subscribe form
  submissions to a ConvertKit tag.
