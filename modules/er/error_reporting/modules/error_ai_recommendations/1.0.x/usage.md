Adds an AI-powered "Suggest AI Fix" button to the Error Reporting error page that asks a configured AI provider for a suggested fix to the failing code.

---

This submodule of Error Reporting integrates the `drupal/ai` provider abstraction into the enhanced error page. When enabled it makes the parent module render a "Suggest AI Fix" button; clicking it posts the top stack frame (the source excerpt, file and line) together with the error message to the `/ai-suggestion/response` endpoint. `AiSuggestionController` sends those as a chat prompt to the site's default AI chat provider/model and returns the model's answer, which is shown in a modal with code snippets and step-by-step guidance. It also alters the Error Reporting settings form to add an AI-provider selector (stored as `provider` in `error_reporting.settings`). It ships no config schema, no permissions of its own, and no fix logic beyond calling the AI provider.

---

- Get an AI-suggested fix for the exact code that threw, directly from the error page.
- Send the failing source excerpt, file path, line number and error message to an LLM for analysis.
- Read the suggestion, including code snippets, in a modal on the error page.
- Use whichever AI provider the `drupal/ai` module has configured as the default chat provider.
- Pick the AI provider from the Error Reporting settings form's added "Select AI Provider" field.
- Store the chosen provider in `error_reporting.settings` (`provider` key).
- Speed up debugging by turning a raw stack trace into an actionable suggested fix.
- Give junior developers guided, context-aware help on unfamiliar errors.
- Reuse an existing `drupal/ai` provider setup (OpenAI, Anthropic, etc. as configured in the ai module) for error triage.
- Only surface the AI button when both `error_reporting` and this submodule are enabled.
- Present the AI answer with syntax highlighting and Markdown rendering.
- Fall back to a generic "Failed to get AI suggestion" message if the provider call fails.
- Return a JSON error when the request body is empty or invalid JSON.
- Keep the feature entirely optional — uninstall it to remove the AI button without affecting base error reporting.
- Combine enhanced error display with AI recommendations for a single-screen debugging workflow.
- Enable per-environment (e.g. dev only) so AI calls are never made from production.
- Route error-fix prompts through your organisation's approved AI provider via the ai module's provider selection.
