# Phrase TMS Translator — manual setup guide

**Phrase TMS Translator** (`tmgmt_memsource`, formerly "Memsource") connects
your Drupal site to the **Phrase TMS** cloud translation platform (phrase.com) so
you can send content out for professional or machine translation and pull the
finished translations back in automatically. It plugs into the
[Translation Management Tool (TMGMT)](https://www.drupal.org/project/tmgmt)
framework, so you use TMGMT's familiar workflow — create a job, add content,
submit to a provider — with Phrase TMS as the provider behind the scenes.

When you submit a TMGMT job to this provider, the module logs in to Phrase TMS,
creates a project (optionally from one of your Phrase project templates, and
optionally grouping several jobs into one project), exports each item to the
XLIFF interchange format, and uploads it as a Phrase "job part". Completed
translations come back in one of three ways: automatically on **cron** (within an
active-hours window you configure), on demand via a **Pull translations** button,
or pushed to Drupal by a **webhook** that Phrase calls whenever a job's status
changes. It can also translate attached Office documents (DOCX, XLSX, PPTX and
their older formats) alongside your text content.

You configure it as a TMGMT **Provider** — there's no standalone settings page.
The provider form holds your Phrase TMS home URL, user name, and password, plus
options for file translation, cron pulling, and a preview connector.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside TMGMT.
2. [Configuration](configuration/index.md) — create the Phrase TMS provider,
   enter credentials, and set up file translation, cron pulling, and the webhook.

## Where it lives in the admin menu

You manage the provider under **Configuration → Regional and language →
Translation Management → Providers**
(the `entity.tmgmt_translator.collection` route). Add a translator there, choose
the Phrase plugin, and fill in your Phrase TMS connection details. Day-to-day
translation happens on the normal TMGMT job screens.
