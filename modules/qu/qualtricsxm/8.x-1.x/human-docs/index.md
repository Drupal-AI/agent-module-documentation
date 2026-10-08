# QualtricsXM — manual setup guide

**QualtricsXM** (`qualtricsxm`) connects your Drupal site to
[Qualtrics](https://www.qualtrics.com/) Experience Management so content authors
can embed Qualtrics surveys directly in Drupal pages. You give the module a
Qualtrics API token and base URL; it then talks to the Qualtrics API to list and
fetch your surveys, and it renders a survey page that embeds a chosen survey in an
iframe that resizes automatically as visitors answer.

The point of the module is to let editors pick a survey from a drop‑down connected
to your Qualtrics account rather than rebuilding forms in Drupal — collecting
responses in Qualtrics makes them much easier to analyse than native Drupal form
submissions. Two optional submodules extend the base: **QualtricsXM Embed**
(`qualtricsxm_embed`) adds a survey *field type* with a drop‑down widget and an
iframe formatter so any entity can carry a survey, and **QualtricsXM Insights**
(`qualtricsxm_insights`) adds insight entities with their own admin forms for
tracking survey insight metadata.

You will need a Qualtrics account and an API token before this module is useful —
the token is what authorises Drupal to read your survey list. The module keeps the
token server‑side (sent in an `X-API-TOKEN` header, never written into the page),
and it only ever calls the Qualtrics endpoint you configure.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and choose the submodules you need.
2. [Configuration](configuration/index.md) — enter your Qualtrics API token and
   base URL, store the token safely, and grant survey‑viewing access.

## Where it lives in the admin menu

The settings form sits at **Configuration → Content authoring → QualtricsXM**
(`/admin/config/content/qualtricsxm`), and you browse the surveys pulled from your
account at `/admin/config/content/qualtricsxm/surveys`. Both require the restricted
**Administer QualtricsXM settings** permission. Embedded surveys are served to
visitors at `/qualtricsxm/survey/{survey_id}`, gated by the **Access QualtricsXM
survey** permission.
