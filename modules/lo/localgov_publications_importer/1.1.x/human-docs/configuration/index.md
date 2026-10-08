# Configuration

There are two things to configure: the **settings form** (how and when imports are
processed) and the **import pipelines** (the recipes that turn a PDF into a
publication). If you use the AI submodule, there is also an **AI provider** to set
up.

## Open the settings form

1. Log in as a user with the **Administer imports** permission.
2. Go to **Configuration → System → LocalGov Publications Importer**, or navigate
   directly to `/admin/config/system/localgov-publications-importer`.

## Settings — background processing

The settings form controls how the pending‑import queue is worked through:

- **Process imports on cron** — when ticked, each cron run picks up pending imports
  and processes them. Leave it unticked if you would rather run imports only on
  demand with the Drush command (below).
- **Cron items limit** — the maximum number of imports processed per cron run
  (default **1**). PDF parsing and (especially) AI cleanup can be slow and
  memory‑hungry, so a low limit keeps a single cron run from running long; raise it
  cautiously if your cron has headroom.

Click **Save configuration** to store your choices.

### Running imports manually

Whether or not cron processing is on, you can process the queue immediately from
the command line:

```bash
drush localgov_publications_importer:import
# or the short alias
drush lpii
```

This is the way to run imports when cron processing is disabled, or to force a run
without waiting for cron.

## Import pipelines

A **pipeline** is a reusable recipe naming one Extract plugin, an ordered list of
Transform plugins, and one Save plugin. You need at least one before you can import.
Manage pipelines from the **Import Pipelines** link on the settings screen.

The default pipeline:

- **Extract** — `smalot_pdfparser` pulls text, images and hyperlinks out of the
  uploaded PDF.
- **Transform** — image handling, line‑break normalisation, and a **page limit**
  step that caps how many PDF pages are imported.
- **Save** — the `publication` plugin builds the LocalGov publication node and its
  child pages.

Create additional pipelines for different document styles, and choose the pipeline
to use when you upload each PDF. (The module is built to be extended: developers can
add their own Extract, Transform or Save plugins.)

## Optional: the AI provider (AI submodule)

If you enabled `localgov_publications_importer_ai`, an AI transform can clean up the
extracted text with a large language model. It uses whichever chat provider your
site's **AI** module has configured as the default. To set one up (OpenAI shown as
the example):

1. Install the Drupal **AI** module and an AI **provider** module (for example the
   OpenAI provider).
2. Obtain an API key from the provider.
3. Store the key with the **Key** module — go to the provider's authentication
   settings (for OpenAI: **Configuration → AI → Provider Settings → OpenAI
   Authentication**), create a new key, choose key type **Authentication**, and for
   a production site prefer a key provider that reads the value from an environment
   variable rather than storing it in configuration.
4. Select that key on the provider's authentication settings; it is verified on
   save, so an incorrect key is flagged immediately.
5. At **Configuration → AI → AI Default Settings**, set the default **chat**
   provider and model.
6. Import a PDF again through an AI‑enabled pipeline — the resulting HTML will carry
   richer structure (headings, lists).

> **Cost, egress and privacy.** With the AI submodule enabled, the extracted
> document text is sent to your configured AI provider — that is outbound network
> traffic to a third party, and most providers bill per token, so imports become
> slower and incur usage cost. Only enable it if you are comfortable sending the
> document content to that provider, and review the provider's data‑processing terms
> before importing sensitive material. Keep the API key out of version control by
> storing it in an environment variable via the Key module.
