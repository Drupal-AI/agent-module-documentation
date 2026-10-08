A submodule of AI Agents that provides an interactive admin screen to run an AI agent against a prompt and watch/debug what it does, storing each run's decisions as `ai_agent_decision` entities.

---

The Agent Explorer gives developers and site builders a hands-on way to try agents without writing code. From `/admin/config/ai/agents/explore` you pick an agent, give it a task, and start a run; the module polls the running agent and shows progress and results live (via `ai_agents.agent_status_poller`). Every run's reasoning and tool calls are recorded as an `ai_agent_decision` content entity so you can review what the agent did after the fact. It depends on `ai_agents` (and core `options`) and adds two permissions: `use the agent explorer` to run agents and `administer ai_agent_decision` to manage the stored decision records. It is the fastest way to validate a new agent, tool, or prompt change. Because it runs real agents, AI Core must have a working provider/API key.

---

- Run a shipped triage agent against a test prompt from the UI.
- Try a newly created custom agent before wiring it into a workflow.
- Debug why an agent picks (or skips) a particular tool.
- Watch an agent's progress live during a long run.
- Review the recorded decisions of a past agent run.
- Compare two prompt variants by running each in the Explorer.
- Validate a new `AiFunctionCall` tool by having an agent call it.
- Check an agent's output against your expectations before production use.
- Reproduce a reported agent misbehaviour interactively.
- Demo AI agent capabilities to stakeholders.
- Confirm your AI provider/API key is configured correctly.
- Iterate on an agent's system prompt quickly.
- Inspect tool call arguments the model generated.
- Audit stored `ai_agent_decision` records for compliance.
- Grant non-developers a safe sandbox to experiment with agents.
