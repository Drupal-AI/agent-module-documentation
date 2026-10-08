<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Watchdog Analyst adds an AI-powered "Analyze" button to Drupal's Watchdog (dblog) log viewer that returns a suggested root-cause and fix for a selected log entry.

---

AI Watchdog Analyst extends core's Database Logging (dblog) reports so that Warning-and-worse log entries can be sent to a chat model — through the AI module's provider plugin system — for analysis. From the log overview a "🤖 Analyze" button opens a modal with an AI-generated solution; from a single log-event page an "Analyze with AI" button renders the analysis under the log-details table. The prompt is built from the log row (type, severity, the message with its serialized variables substituted, location and referer); if the log's type matches an installed contrib module the prompt is enriched with the module's drupal.org project URL so the model can reference the issue queue. Answers come back as markdown, are converted to HTML with league/commonmark, and are cached for 24 hours keyed on the log type + message. Provider, model and the system prompt are configurable at `/admin/config/ai/watchdog-analyst`. Requires core `dblog` and the `ai` module (^1.0) with at least one configured chat provider; supports Drupal 10 and 11. Note that log entries — which can contain sensitive data — are sent to whichever AI provider you configure, so choose the provider with your data-egress and cost constraints in mind.

---

- Triage Drupal errors faster by getting an AI explanation of a Watchdog entry.
- Click "🤖 Analyze" on a Warning/Error row in `/admin/reports/dblog` to open a modal with a suggested fix.
- Generate an analysis on a single log-event page (`/admin/reports/dblog/event/{id}`) with "Analyze with AI".
- Receive structured output: Root Cause, Context, Contrib Module Check, Solution, Prevention, References.
- Automatically include a contrib module's drupal.org project URL in the prompt when the log type matches an installed contrib module.
- Reuse a cached analysis for 24 hours instead of re-calling (and re-paying for) the model on the same error.
- Pick which AI provider handles analysis (e.g. OpenAI, Azure OpenAI, Ollama) via the settings form.
- Pin a specific chat model, or let the module fall back to the provider's first configured chat model.
- Customize the AI expert persona and answer structure by editing the system prompt.
- Get answers in the site's current interface language (a "respond in <language>" instruction is appended to the prompt).
- Render AI markdown responses (headers, code blocks, lists) as formatted HTML in the admin UI.
- Restrict AI analysis to actionable severities only (Emergency, Alert, Critical, Error, Warning) — Notice/Info/Debug show no button.
- Debug PHP errors, database errors, and module exceptions recorded in dblog with model-suggested code fixes.
- Point operators to likely patches or newer module versions when the error comes from contrib.
- Use it purely as an operator aid — no content types, fields, or text formats are added.
- Run it self-hosted end-to-end by pairing it with a local provider such as Ollama.
- Keep costs predictable — analysis fires only on explicit button click, never automatically on log write.
- Reset or tune answer quality by swapping the provider/model when results are weak.
