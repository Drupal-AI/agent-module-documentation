AI Metering records the token count and USD cost of every AI operation that runs through Drupal's `ai` module — for any provider and any operation — and adds per-user monthly quotas, a cost dashboard, and multi-currency display.

---

Whenever code calls an AI provider through the `ai` module, AI Metering's event subscribers intercept the request: before the call it can estimate cost and enforce a per-user monthly token quota (optionally rerouting to a cheaper/local model when the quota is exceeded), and after the call it logs input/output/cached tokens plus the computed cost into its own database tables. Per-model pricing is pulled from pluggable sources (LiteLLM and models.dev) and can be synced on demand, while costs are shown in any currency using live Frankfurter exchange rates. Administrators get a settings hub, a per-editor cost dashboard, and a raw usage log — all exportable to CSV/JSON via Views. Five Drush commands cover quota resets, budgets, pricing sync, and LiteLLM proxy reporting. It stores nothing as config or content entities; usage lives in the `ai_metering_usage` table and budgets in `ai_metering_quota`. Two alter/react hooks let other modules adjust each usage record or respond when a quota is exceeded. It is provider-agnostic — OpenAI, Anthropic, Ollama, and others are all metered the same way — with provider-native token counting for Anthropic and Ollama for accuracy. It optionally integrates with `ai_usage_limits` (a system ceiling banner) and `ai_translate` (a pre-call cost badge). This makes it the accounting and cost-control layer for any Drupal site running AI.

---

- Track exactly how many tokens each AI feature consumes across a site.
- See the USD cost of every AI call, per user and per model.
- Enforce a monthly token budget per user to cap spend.
- Automatically fall back to a cheaper/local model when a user hits their quota.
- Show AI costs to editors in their local currency (EUR, GBP, …).
- Give an editor a pre-call cost estimate before they run an expensive AI action.
- Build a management dashboard of AI spend by editor.
- Break down AI usage and cost by user role.
- Export the raw per-call usage log to CSV for finance/reporting.
- Export usage as JSON for an external billing pipeline.
- Sync current model prices from LiteLLM or models.dev.
- Configure custom per-model pricing when using a private/self-hosted model.
- Route short prompts to a fast/cheap model and long ones to a high-quality model.
- Reset a specific user's monthly quota via Drush after an overage.
- Set a user's monthly token budget from the command line.
- Alert users (or admins) by email when a quota threshold is crossed.
- Meter usage uniformly across OpenAI, Anthropic, Ollama and other providers.
- Get accurate token counts using Anthropic's and Ollama's native counting APIs.
- Report global spend from a LiteLLM proxy.
- Attribute AI cost of a translation workflow (with ai_translate) per string.
- Audit which models and operations dominate AI spend.
- Add a read-only provider ceiling banner (with ai_usage_limits).
- Alter a usage record before it is written (add custom metadata).
- React programmatically when any user exceeds their quota.
- Provide chargeback data for internal teams using AI features.
- Prevent runaway AI costs on a public-facing site with user quotas.
