<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Annotations Tool API exposes annotation context as Tool API plugins so function-calling AI agents can retrieve site documentation on demand.

---

Annotations Tool API bridges the Annotations suite to the drupal/tool framework, letting an AI agent pull a site's editorial documentation as a callable tool rather than being pre-fed a full context payload. It ships two read-only tools built on `annotations_context`'s assembler: `annotations_read` ("Get Annotations") returns the markdown annotation documentation for a given target (e.g. `node__article`), or for all configured targets when no target is passed; and a list tool that enumerates the configured annotation targets. Both share `AnnotationsToolAccessTrait`, which allows execution for `view annotations context` or `administer annotations` and declares the appropriate cache contexts. Requires `tool`, `tool_ai_connector`, and `annotations_context`.

---

- Expose annotations to function-calling AI agents as Tool API plugins.
- Let an agent fetch a target's documentation on demand as markdown.
- Scope a retrieval to one target (e.g. `node__article`) or return all targets.
- List the configured annotation targets from an agent.
- Reuse the annotations_context assembler for tool output.
- Gate tool execution on `view annotations context` or `administer annotations`.
- Declare correct cache contexts (permissions, language) per tool.
- Integrate with tool_ai_connector for AI provider function calling.
- Provide read-only tools (no mutation surface).
- Return site-specific field guidance and rules to an agent.
- Support multilingual context via language cache contexts.
- Complement the MCP endpoint (annotations_context) with a Tool-framework path.
- Give agents an accurate map of content types and fields.
- Avoid over-stuffing prompts by retrieving only the needed target.
- Describe each tool with input/output definitions for the connector.
- Serve as the function-calling counterpart to annotations_docs' batch generation.
