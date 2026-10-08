# Configuration

All settings live on one form.

## Open the settings form

1. Log in as a user with the **Administer AI RAG search chat** permission.
2. Go to **Configuration → AI → AI RAG Search Chat**, or navigate directly to
   `/admin/config/ai/ai-rag-search-chat`.

The form is grouped into sections. The most important ones are below.

## Which content to search (RAG)

- **Search indices** — the Search API index IDs the chat retrieves from (only
  indices using the AI Search backend are listed). This is the single most
  important setting: choose the index(es) built over the content you want the
  chat to answer from.
- **Retrieval tuning** — how many chunks to pull (`top_k`, default 5), how many
  sources to aim for, the minimum relevance score to accept (`min_score`,
  default 0.3), and the **context token budget** (default 4000) that caps how
  much retrieved text is packed into the prompt. The highest-scoring chunks are
  packed up to that budget, so prompt size stays bounded regardless of how long
  the matched documents are.
- **Filter by language** (on by default) and an optional **supplementary keyword
  search** alongside the semantic retrieval, with its own stop-word list.

## The AI model (LLM)

- **Provider and model** — choose which AI provider and model answers questions.
  You can set a separate **title model** used to name conversations (a smaller,
  faster model is recommended for that).
- **No API keys are entered here.** Provider credentials come from the AI module
  and the Key module — this form only selects which configured provider/model to
  use.

## Prompt and wording

- **System instructions** — the system prompt that frames how the assistant
  answers.
- **Term map** — a `term|expansion` mapping (one per line) that expands
  abbreviations in the question before retrieval and the model see it.
- **Empty-response message** — what visitors see when nothing relevant is found.
- **AI disclosure** — a short line shown under the search/chat UI reminding
  visitors that answers are AI-generated. Leave it blank to hide it.

## History retention

- **Max messages** kept per conversation (default 10), and how long sessions are
  retained: **30 days** for authenticated users and **2 days** for anonymous
  visitors by default. Cron prunes older sessions automatically.

## Rate limits

Rate limiting is **on by default** and protects the LLM-calling endpoints from
abuse. You can tune:

- **Message limits** — 30/hour for authenticated users, 10/hour for anonymous,
  over a configurable window (default one hour).
- **Session-creation limits** — the same 30/10 split over its own window.

> Leave **rate limiting enabled**. Turning it off removes throttling from the
> endpoints that call (and are billed by) your AI provider — a cost-abuse risk,
> especially if you have granted *Access AI RAG search chat* to anonymous users.

## Search / chat / UI

Page titles, how sources are displayed (`source_display_mode`, default teaser),
how many sources per page, a maximum chat message length, an optional typewriter
effect, and a toggle for loading a Tailwind stylesheet.

## Save

Click **Save configuration**. Then test `/ai-search` and `/ai-search/chat` with a
question whose answer is in your indexed content.

## Access reminder

Grant **Access AI RAG search chat** to the roles that should use the feature.
Retrieved content and rendered sources respect each user's view access to the
underlying entities, so users see citations only for content they are allowed to
view. Keep rate limiting enabled to bound AI-provider cost.
