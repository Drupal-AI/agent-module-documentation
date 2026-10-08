# Configuration

AI Model Registry is configured entirely through its **entity UI** — a standard
Drupal list-with-add/edit/delete for model records. There is no separate settings
form; the catalogue *is* the configuration.

## Open the catalogue

1. Log in as a user with the **Administer AI Model Registry** permission
   (`administer ai_model_registry`) — a restricted permission, so grant it only
   to trusted administrators.
2. Go to **Configuration → AI → AI Model Registry**.

You'll see the list of model records. On a fresh install this already contains
four seeded examples (OpenAI, two Ollama, and LM Studio) that you can edit,
delete, or use as templates.

## Add or edit a model record

Each record describes one **provider/model pair** and is keyed by a compound
`provider_id__model_id` (for example `openai__gpt-4o`). The form groups the
fields into a few areas:

- **Capabilities** — flags for what the model can do: chat, embeddings,
  structured output, tool use, and vision. Governance and routing modules use
  these to decide whether a model is suitable for a given operation.
- **Cost** — `cost_prompt_1k` and `cost_completion_1k`, the price per 1,000
  prompt and completion tokens. Budget modules use these to estimate spend.
- **Governance** — `data_residency` (where the model runs / stores data),
  `uses_input_for_training` (whether your prompts may be used to train the
  model), and `risk_level`.
- **Lifecycle** — `eol`, an end-of-life marker so health and monitoring tooling
  can flag models that are being retired.
- **Deployment** — a `local` flag to mark self-hosted models (for example
  Ollama or LM Studio).
- **Metadata** — a free-form key/value map for any provider-specific attribute
  the fixed fields don't cover.

Fill in what you know; fields you leave blank simply aren't asserted.

## How other modules use these records

A repository service normalises every record into a predictable shape and merges
in entries contributed by **ModelMetadataAdapter** plugins (external sources such
as a remote gateway or a spreadsheet). Consumers like **AI Policy Gateway** then
read this catalogue to make routing, budget, and governance decisions — so
keeping the records accurate directly affects how those modules behave.

## Deploying the catalogue

Because model records are configuration entities, they are captured by Drupal's
configuration export/import. Curate the catalogue on one environment, export
configuration, and deploy the same set of models everywhere.
