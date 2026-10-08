# Microsoft Translator — manual setup guide

**Microsoft Translator** (`tmgmt_microsoft`) is a translator plugin for the
[Translation Management Tool](https://www.drupal.org/project/tmgmt) (TMGMT). It lets
you submit TMGMT translation jobs to the **Microsoft Azure Cognitive Services
Translator Text API** and get machine translations back for your Drupal content —
nodes, taxonomy, or anything else TMGMT can handle. It slots in as one more
translation provider alongside any others you use, so you can compare output or
switch providers per job.

You configure it as a TMGMT **translator (provider)** entity under *Translation →
Providers*. Its settings are minimal: a single **Azure API key** and TMGMT's
standard "auto accept" toggle. A **Connect** button validates the key before you
rely on it. Behind the scenes, at translation time the plugin exchanges your
subscription key for a short-lived token and posts each translatable text segment to
the Azure Translator v3 endpoint, sending content as HTML so markup is preserved and
protecting non-translatable snippets with special "notranslate" spans. It maps
Drupal language codes to Azure's (for example Simplified and Traditional Chinese) and
enforces Azure's per-request character limit.

Because it talks to a paid Azure service, you need an **Azure Cognitive Services
Translator subscription** and its key. The Azure endpoints are built into the plugin;
the only thing you supply is the key. The module depends on the **TMGMT** module and
adds no permissions of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create the Microsoft translator
   provider, enter and validate the Azure API key, and keep the key out of version
   control.

## Where it lives in the admin menu

TMGMT translators are managed at **Translation → Providers**
(`/admin/tmgmt/translators`). You add a translator there and choose the
**Microsoft** plugin. Once saved, it becomes selectable when creating TMGMT
translation jobs.

## How to use it

1. Get an Azure Cognitive Services Translator subscription key.
2. Add a TMGMT provider (Translation → Providers) using the **Microsoft** plugin and
   enter the key.
3. Click **Connect** to validate it.
4. Create TMGMT translation jobs as usual and select the Microsoft provider — content
   is sent to Azure and the machine translation comes back into TMGMT for review (or
   auto-acceptance, if you enabled it).
