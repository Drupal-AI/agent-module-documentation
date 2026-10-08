<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Workspace gives every authenticated user a private, persistent ChatGPT-style chat workspace inside Drupal, streaming responses over SSE from any provider configured in the Drupal AI module.

---

AI Workspace mounts a React (assistant-ui) single-page app on one Drupal route (default `/ai_workspace`) backed by a JSON + Server-Sent-Events REST API under `/api/ai-workspace`. Conversations are stored as two content entity types — `ai_workspace_thread` (owned per user) and its child `ai_workspace_message` — so history survives reloads, is scoped to its owner, and can be deleted at will. Model and provider selection is agnostic: any chat-capable provider registered with the `ai` module can be chosen per thread, optionally restricted by an admin allow-list. After the first exchange the AI auto-generates a short thread title. An admin settings form (`/admin/ai/workspace`) controls the default model, provider allow-list, a global system prompt, starter suggestions, appearance strings, a per-user thread cap, tool calling and audit logging; the workspace URL path is itself configurable. Optional `ai_assistant_api` integration lets a thread run a full AI Assistant (`assistant__<id>` keys) through that module's runner. A pluggable `AiWorkspaceTool` plugin type provides a tool-calling scaffold, but no tools ship active in this release. Requires core `user`, `system`, and `drupal/ai` `^1.2`; supports Drupal 10.4+ and 11. The project is not covered by the Drupal security advisory policy and is described upstream as under active development — evaluate carefully before production use.

---

- Give staff/members a private, self-hosted ChatGPT-style chat UI inside Drupal.
- Persist each user's conversation threads as Drupal entities that survive reloads.
- Let users open, name, switch between and delete multiple conversation threads.
- Stream AI responses token-by-token in the browser via Server-Sent Events.
- Offer provider-agnostic chat over any `ai`-module provider (OpenAI, Anthropic, Mistral, Ollama, …).
- Let users pick a different model per thread from a configured list.
- Restrict selectable providers to an admin allow-list (`allowed_providers`).
- Set a site-wide default model for new threads (`default_model_key`).
- Apply a global system prompt to shape AI behaviour across all conversations.
- Auto-generate a short descriptive title for each thread after its first exchange.
- Show configurable clickable starter suggestions on the empty-state screen.
- Rebrand the workspace name, welcome title and welcome subtitle without code.
- Relocate the workspace page path (e.g. `/ai_workspace` → `/ai/chat`) from settings.
- Run a thread against a configured AI Assistant via optional `ai_assistant_api`.
- Cap the number of threads per user (config key present; `0` = unlimited).
- Toggle audit logging of AI provider calls to Drupal's logger.
- Gate access to the SPA with the `use ai workspace` permission.
- Give admins a full bypass over all users' threads via `administer ai workspace`.
- Build an internal knowledge or support assistant for logged-in users.
- Provide a content-drafting or developer-helper chat environment for editors.
- Extend the workspace with custom callable tools via the `AiWorkspaceTool` plugin type.
- Expose a JSON/SSE API (`/api/ai-workspace/*`) for a custom front-end or automation.
