Exposes Document Loader to AI agents as a set of derived Tool plugins (load_file, load_website, load_api, …) gated by a dedicated permission.

---

Document Loader: Tool integrates Document Loader with the Tool module so AI agents can read documents. A deriver (`DocumentLoaderToolDeriver`) groups all registered Document Loader source categories and creates one tool derivative per category — `document_loader:load_file`, `document_loader:load_website`, `document_loader:load_api`, and any new category a third-party input class introduces (e.g. `load_notion`). Each derivative advertises only the input definitions its source needs, contributed by the input class's `getToolInputSchema()`, plus shared `output_format` and `max_length`, and it also folds in loader-declared options (scoped per loader). At execution the `DocumentLoaderTool` plugin delegates to `DocumentLoaderManager::loadFromData()` with `caller: 'tool'`, returning `content`, `format`, `loader`, and a JSON `metadata` string. Access is checked against the `use document_loader tool` permission. A `form_alter` hook makes options marked `hide_from_llm_by_default` default to "Force value" + "Hide property" on the AI Agent, modeler_api, and AI API Explorer forms.

---

- Give an AI agent a tool to read an uploaded PDF/Word/spreadsheet file (`document_loader:load_file`).
- Let an agent fetch and convert a web page (`document_loader:load_website`).
- Let an agent call a REST API and convert the response (`document_loader:load_api`).
- Automatically expose a new source category as a tool when a third-party input class is added.
- Cap tool output length via `max_length` to protect the LLM context window.
- Choose the output format (text, markdown, html, json, …) per tool call.
- Restrict document-loading to roles/agents holding `use document_loader tool`.
- Present each source as a focused, separate tool rather than one overloaded tool.
- Pre-hide sensitive/verbose loader options from the LLM by default on the AI Agent form.
- Pre-fill forced default values for hidden loader options on agent/modeler/explorer forms.
- Return document metadata to the agent as a JSON-encoded string alongside the content.
- Surface per-loader tunable options (scoped `{loader}__{option}`) to the agent where appropriate.
- Build agent workflows that ingest documents into a RAG or summarization pipeline.
- Test document-loading tools interactively via the AI API Explorer.
