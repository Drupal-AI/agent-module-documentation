# OpenAI Content Editing Tools (openai_content) — agent index

Adds AI-assist actions (analyze/moderate, adjust tone, summarize, suggest title, suggest
taxonomy) to the node edit form, over the parent `openai.api` service. No config page, no
plugins. Parent: [../../../../1.0.x/agent/start.md](../../../../1.0.x/agent/start.md).

- **The five node-form tools, their AJAX callbacks and API calls** → [configure/tools.md](configure/tools.md)

Key facts:
- `hook_form_node_form_alter()` in `openai_content.module` injects the tools; permission
  **`access openai content tools`**.
- No routes/config/schema/plugins of its own. Requires the parent's API key.
