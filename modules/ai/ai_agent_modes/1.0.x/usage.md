AI Agent Modes adds a "Mode" dropdown to an AI chat that scopes the agent to a curated subset of its sub-agents by prepending a scoped system-prompt directive.

---

AI Agent Modes lets site builders define "modes" — config entities that each name a parent AI agent, a curated set of that agent's sub-agents, and an optional short directive. When a user picks a mode in the chat, the module prepends that directive to the agent's system prompt so the orchestrator routes the task to the chosen sub-agents, keeping the assistant on-topic without removing any of its abilities. A mode can steer with the prompt alone (the default "guide" strength) or, with "restrict" strength, also withhold the parent agent's sub-agent tools it does not name from the request; a site-wide "Enforce tool scope" switch can flip all withholding back to steering. Selections are remembered per user in the private tempstore. The dropdown is offered in the Drupal Canvas AI panel and the AI Chatbot (DeepChat) panel, and a placeable "AI Agent Mode selector" block adds it beside any other AI chat. The module also surfaces the browser's own Web Speech dictation and read-aloud in the DeepChat panel (both off by default, no external service or key). It depends on the AI module and AI Agents (>=1.3), and integrates optionally with AI Assistant API, AI Chatbot, and Canvas AI.

---

- Add a "Mode" dropdown to an AI chat so users pick the kind of task before typing.
- Steer a general-purpose orchestrator toward the sub-agents relevant to one job.
- Define a "Page Builder Only" mode that routes work to page-building sub-agents.
- Define a "Content Types & Fields" mode for structural work on the content model.
- Ship modes as configuration so they travel in recipes and between sites.
- Create, rename, weight, enable/disable and delete modes at Configuration > AI > AI Agent Modes.
- Attach a scoped directive (system prompt addition) to a mode to bias the orchestrator.
- Use "guide" strength to steer with the prompt only, leaving every tool in place.
- Use "restrict" strength to also withhold the sub-agent tools a mode does not name.
- Flip the site-wide "Enforce tool scope" switch to turn all withholding back into steering.
- Offer a mode only for selected AI Assistants rather than every assistant on one agent.
- Limit a mode to specific chat surfaces (e.g. Canvas, assistant chat).
- Place the "AI Agent Mode selector" block next to a custom AI chat surface.
- Choose where the dropdown sits in the Canvas AI panel (top, above/below input, toolbar).
- Choose where the dropdown sits in the AI Chatbot panel (above chat, below input, header).
- Let one AI Assistant override the dropdown position, microphone and read-aloud for itself.
- Hide the dropdown site-wide while still scoping the assistant by configuration.
- Remember each user's mode choice for the rest of their conversation via private tempstore.
- Offer a microphone in the DeepChat panel so users dictate instead of typing (browser Web Speech).
- Read each assistant reply aloud in the DeepChat panel (browser speech synthesis).
- Keep speech features off until explicitly switched on, with no external service or API key.
- Add a mode selector to a custom form with the `ai_agent_mode_select` render element.
- Read a parent agent's live sub-agents dynamically from its enabled tools, not a hardcoded list.
