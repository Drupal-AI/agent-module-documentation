OpenAI Error Log Analyzer augments Drupal's database log so that, when you view a watchdog event of a
selected severity, it adds an "Explanation (powered by OpenAI)" row describing what the error likely
means and how to fix it. Answers are cached per unique message so common errors are only sent to
OpenAI once.

---

The module overrides the core `dblog.event` route controller (via a `RouteSubscriber`) with
`OpenAIDbLogController`, which extends core's `DbLogController`. On the event detail page it checks
the event severity against the enabled `levels` in `openai_dblog.settings`; for enabled levels it
truncates the message, hashes it (sha256), and looks the hash up in its `openai_dblog` table. Cached
explanations are shown immediately; otherwise it prompts OpenAI (`chat()` for `gpt*` models,
`completions()` for `text*` models) asking for a Drupal-expert explanation and fix, stores the
tag-stripped answer, and renders it. Configuration is a small settings form
(`/admin/config/openai/openai-dblog/settings`, `administer site configuration`) choosing the log
levels to analyze and the model to use. It depends on core `dblog` and the parent OpenAI module for
the API key/service, and analysis is reached through the standard log report (which requires
`access site reports`).

---

- Get a plain-language explanation of a fatal PHP error in the log.
- Suggest likely fixes for a recurring Drupal error without leaving the admin.
- Help junior developers interpret cryptic watchdog messages.
- Triage production errors faster during an incident.
- Limit AI analysis to only Error/Critical/Alert/Emergency levels.
- Avoid noise/cost by excluding notice and debug levels.
- Reuse cached explanations for repeated identical errors.
- Choose a cheaper or more capable model per site budget.
- Onboard new team members to a site's common error patterns.
- Turn opaque stack traces into actionable next steps.
- Speed up debugging of contrib module errors.
- Provide first-pass guidance before opening a support ticket.
- Document common site errors from cached explanations.
- Analyze errors after a deployment or update.
- Explain database or configuration errors surfaced in logs.
- Give site owners self-service help for frequent warnings.
- Reduce time spent searching for error meanings online.
- Keep explanations local/cached for audit and review.
- Prioritize which logged errors to fix first.
- Switch models to compare explanation quality.
