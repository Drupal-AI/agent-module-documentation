# LocalGov Publications Importer Copilot — manual setup guide

**LocalGov Publications Importer Copilot** (`localgov_publications_importer_copilot`)
adds an AI‑powered formatting step to the **LocalGov Publications Importer**
pipeline. When a PDF is imported, this module hands the extracted text and HTML to a
**Microsoft Copilot Studio** agent (over the **Direct Line** API) and uses the
agent's reply to split and format the content into cleanly paginated pages — each a
JSON object with a title and body — which are then saved as a LocalGov publication.

It contributes one Transform plugin, **Copilot (all‑in‑one)**
(`transform_copilot_aio`), and a ready‑made import pipeline, **`copilot_pipeline`**,
that chains PDF extraction, image and line‑break transforms, the Copilot transform,
and the publication save step. The module also bundles a **Copilot Studio Agent
Solution** package — the companion bot definition you import into Copilot Studio so
it knows how to respond.

Because this module sends your extracted document content to an external Microsoft
endpoint, treat it as a third‑party data‑processing choice: review the privacy and
cost implications before importing sensitive publications (see
[Configuration](configuration/index.md)).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set up the Copilot Studio bot, the
   Direct Line token URL, the prompt, and the privacy/cost considerations.

## Where it lives in the admin menu

This module adds **no admin page of its own**. It provides a transform plugin and a
pipeline that live inside **LocalGov Publications Importer**. You use it by choosing
the **`copilot_pipeline`** (or a pipeline that includes the Copilot transform) when
you upload a PDF at **Content → Imports**, and you configure the transform's
settings — token URL, prompt and so on — on that pipeline's Copilot transform (see
[Configuration](configuration/index.md)).

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Import the bundled **Copilot Studio Agent Solution** into Microsoft Copilot
   Studio to provision the matching bot, and get a **Direct Line token URL** for it.
3. Configure the Copilot transform with that token URL (and adjust the prompt,
   trigger phrase and polling timeout if needed) — see
   [Configuration](configuration/index.md).
4. Upload a PDF at **Content → Imports**, choosing the **Copilot** pipeline.
5. Process the import (on cron or with `drush lpii`); the AI‑formatted, paginated
   pages are saved as a LocalGov publication.

Requires **LocalGov Publications Importer** (and, through it, LocalGov Publications);
it is part of the LocalGov Drupal ecosystem.
