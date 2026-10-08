# Configuration

Everything the module does starts here. Until you pick a provider and enter its
details, no summary can be generated.

## Open the settings form

1. Log in as a user with the **Administer AI content summarizer** permission.
2. Go to **Configuration → Content authoring → AI Content Summarizer**, or navigate
   directly to `/admin/config/content/ai-summarizer`.

## Active provider

Choose the **active provider** — one of `openai`, `anthropic`, `gemini`, or
`ollama`. Only the active provider is used for summarization; the others' saved
settings are preserved so you can switch back without re-entering them.

## Per-provider settings

Each provider exposes its own small set of fields:

- **API key** — the credential for OpenAI, Anthropic, or Gemini (Ollama needs
  none). Stored in the module's configuration.
- **Model** — the model name to call (for example an OpenAI or Anthropic chat
  model).
- **Base URL** — for OpenAI and Ollama, the endpoint to send requests to. Point
  OpenAI at an Azure/OpenAI-compatible base URL, or Ollama at your local server.

Switching the active provider keeps every provider's saved settings, so you can
move between them freely.

## What gets summarized

- **Enabled content types** — tick the content types that are eligible for
  summarization. Only these show summarize actions.
- **Source fields** — a comma-separated list of the field machine names whose text
  feeds the summary (default `body`). List more than one to combine several fields
  as the summary source.

## Behavior

- **Auto-summarize on save** — when enabled, a summary is generated automatically
  every time a node of an enabled type is created or updated (via the node presave
  hook). Leave it off to summarize only on demand.
- **Generate title suggestions** — when enabled, the module also produces up to
  five alternative, SEO-friendly titles alongside the summary.
- **Summary max length** — a hard character cap on the stored summary, between 50
  and 2000 characters. The result is truncated to this length.

## Prompts

- **Summary prompt** — the template used to ask the model for a summary. The
  node's text is appended to it automatically, so write the instruction, not the
  content.
- **Title prompt** — the template used to ask for alternative titles, again with
  the node text appended automatically.

## Save and use

Save the form. Then generate summaries in one of these ways:

- **On demand, one node** — use the per-node summarize action (requires the **Use
  AI content summarizer** permission; the route is CSRF-protected).
- **In bulk** — go to **Content → AI Summarize** (`/admin/content/ai-summarize`)
  for a list of eligible nodes with Summarize/Regenerate links.
- **Automatically** — if you enabled *auto-summarize on save*, summaries appear
  whenever content is created or updated.

Stored summaries are shown on the node view, kept per language in the module's
`ai_content_summary` table, and deleted automatically when their node is deleted.
Remember that every generation against OpenAI, Anthropic, or Gemini is a billed
external call that sends the content off-site; Ollama runs locally instead.
