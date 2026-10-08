# Smartling Translator — manual setup guide

**Smartling Translator** (`tmgmt_smartling`) connects Drupal to the
[Smartling](https://www.smartling.com/) translation platform. It is a provider
plugin for the Translation Management Tool (TMGMT) module: you build translation
jobs in TMGMT as usual, and this module exports the content, uploads it to your
Smartling project, and downloads the finished translations back into Drupal.

Under the hood it exports translatable content as XML or XLIFF, sends it through
the official Smartling PHP SDK using your project credentials, and can optionally
upload **visual context** — a rendered version of the page — so translators see
strings in place. Completed translations come back three ways: automatically on
cron, on demand through admin actions, or when Smartling calls the module's
callback URL.

Because it authenticates to an external service, it needs three Smartling
credentials — a **Project Id**, a **User Id**, and a **Token Secret**. Keep the
token secret out of version control: set it via an environment variable or a
`settings.php` override rather than committing it to exported configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including its
   several TMGMT dependencies), enable the module, and note the optional
   submodules.
2. [Configuration](configuration/index.md) — create a Smartling provider and set
   its credentials, formats, callbacks, and context options, field by field.

## Where it lives in the admin menu

Smartling is configured as a **TMGMT provider**, not through a settings page of
its own. Create or edit providers at
**Administration → Translation → Providers** (`/admin/tmgmt/translators`) and
choose **Smartling** as the plugin. General TMGMT administration (setting up
providers, running jobs) is governed by the **Administer tmgmt** permission from
the TMGMT module.

The Smartling callback routes (`/tmgmt-smartling-callback/{job}`) *schedule* a
translation download for an existing job, and are only registered when you enable
callbacks per provider.
