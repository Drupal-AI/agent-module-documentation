# Lionbridge Translation Provider — manual setup guide

**Lionbridge Translation Provider** (project `lionbridge_translation_provider`,
module `tmgmt_contentapi`) connects Drupal's **Translation Management Tool
(TMGMT)** to Lionbridge's Content API. Translation jobs you create in Drupal are
sent to Lionbridge's professional translation services, and the completed
translations come back into the same TMGMT workflow for review and acceptance.

The single most important thing to know is the **naming mismatch**: the Composer
project is `lionbridge_translation_provider`, but the module it ships is
`tmgmt_contentapi`. So you `composer require drupal/lionbridge_translation_provider`
but enable it with `drush en tmgmt_contentapi` — `drush en
lionbridge_translation_provider` will fail.

This is **vendor integration, not machine translation**. Jobs go to *human*
translators under a commercial contract, which means you need a Lionbridge
account, credentials (username, password, and an API access token), and it carries
a per-word cost. That distinction matters if you're also looking at something like
`ai_tmgmt`, which drives an LLM through the same TMGMT workflow: one buys human
translation, the other runs a model, and they solve different problems at very
different price points and quality levels. They can even coexist, with different
languages routed to each.

TMGMT is the framework that does the orchestration — jobs, job items, review and
acceptance — with one translator plugin per service. This module supplies the
Lionbridge plugin, so it is configured through **TMGMT's translator ("provider")
collection** rather than a settings page of its own. Its only module dependency is
`tmgmt`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   `tmgmt_contentapi` module, and confirm TMGMT is present.
2. [Configuration](configuration/index.md) — add the Lionbridge translator in
   TMGMT and store its credentials safely.

## Where it lives in the admin menu

There is no dedicated settings page. You configure it by adding a **Lionbridge
translator** in TMGMT's provider collection under **Configuration → Regional and
language → Translation Management Translators**
(`/admin/tmgmt/translators`). See [Configuration](configuration/index.md).
