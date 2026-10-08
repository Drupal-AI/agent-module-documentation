# Configuration

There are three steps: connect an AI provider, tell Metatag AI what to generate,
then run the bulk update. The first two are prerequisites provided by the modules
this one depends on; the third is the form this module adds.

## 1. Configure an AI provider (AI Core)

Install and configure the **AI Core** module with your preferred provider, then add
your API key at **/admin/config/ai/providers**.

> **Keep the API key a secret.** Provider keys are sensitive and should never be
> committed to Git. Store the value in an environment variable and reference it
> through a Key entity. With DDEV:
>
> ```bash
> ddev dotenv set .ddev/.env --openai-api-key=<value>
> ddev restart
> ```
>
> Then create a Key with the env provider and select it in the AI provider
> settings. Never commit `.ddev/.env`.

Bear in mind that generating tags sends node content to this provider (external
egress), and large runs can incur real cost.

## 2. Configure Metatag AI

Go to **/admin/config/content/metatag-ai** and set:

- the **content types** to generate meta tags for,
- the **metatag field name** to write into, and
- the **AI provider / model** to use.

## 3. Run the bulk update

Go to **Administration → Configuration → Content → Metatag AI → Bulk Metatags
Update Using AI** (`/admin/metatag-ai-bulk-update`) and set the run options:

- **Content types** — which of your Metatag-AI-configured types to process.
- **Language** — on multilingual sites, target one language or process all.
- **Node limit** — optionally cap how many nodes are processed in this run.
- **Require human approval before applying changes** — *on by default*. Suggestions
  are stored for review rather than applied immediately. Leave this on unless you
  are confident in unattended generation.
- **Validate metatags by AI** — available in auto-apply mode; runs a second AI pass
  to quality-check generated tags before saving.

Only nodes that are **missing** meta tag values are processed, so already-tagged
content is skipped. Click **Start Bulk Metatag AI Batch** to begin; Drupal's Batch
API processes the content in chunks and a results dashboard shows successes and
errors with live status.

## 4. Review AI suggestions (recommended)

With approval required (the default), a review table appears on the same page after
the batch finishes. There you can **Approve**, **Reject**, **Edit**, or **Delete**
each suggestion — individually or in bulk. You can also **download a CSV** report of
the generated meta tags and any validation results.

To apply tags without review, uncheck **Require human approval** (auto-apply mode);
optionally enable **Validate metatags by AI** for an extra quality check before
saving.

## Cleanup

Deleting a node automatically removes its stored suggestions and batch results, so
the review data stays tidy over time.
