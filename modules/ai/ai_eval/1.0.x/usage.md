A Drupal evaluation framework that scores the quality of AI agents and providers against reusable datasets, using pluggable graders and LLM judges with trustworthy pass/fail quality gates.

---

AI Eval measures and improves the quality of your AI integrations in Drupal. You define evaluation datasets (in YAML files, config, or content entities, or author them in the browser) and point an "eval target" at either an ai_agents plugin (agent mode: the full tool-call/reasoning loop) or any AI provider such as Anthropic, OpenAI, or Ollama (chat mode: prompts sent directly, multi-turn supported). Running a target grades every question with a configurable set of graders: deterministic ones (format, tool-usage, rubric checks) that cost nothing, and LLM-as-judge graders (relevance, completeness, actionability, accuracy, fact-match, groundedness) that call a configured judge model. A scorer maps every grader's native scale onto a composite 0-5 scale, averages them, and applies quality-gate thresholds. Everything runs and reviews in the browser through an htmx-driven admin UI (portfolio landing, live run progress, results dashboard with trend sparklines, per-question breakdowns) or from Drush. Beyond running datasets, it imports real production traces for human labeling and promotion into datasets, validates LLM judges against human-labeled gold examples (with agreement statistics and per-grader trust state), and optimizes system prompts by proposing and A/B-testing candidate prompts. Extension points are graders (AiEvalGrader plugins), dataset sources (AiEvalDatasetSource plugins), and rubric check executors (tagged services). All screens are gated behind four dedicated permissions, and the module delegates all model access and credentials to the drupal/ai provider layer. An optional submodule, ai_eval_droost, adds a deterministic grader that scores the actual Drupal state an agent built.

---

- Score how well an AI agent completes tasks, end-to-end including its tool calls (agent mode).
- Evaluate a raw AI provider/model on system prompts, RAG, Q&A, or classification (chat mode).
- Compare two models or two prompt versions on the same dataset (A/B evaluation).
- Author evaluation questions in the browser via the dataset question editor.
- Define datasets in YAML files validated against the module's public JSON Schemas.
- Store datasets as content entities and manage them through the admin UI.
- Set a pass/fail quality gate threshold per target and get trustworthy pass rates.
- Grade responses with deterministic, zero-cost graders (format, tool usage, rubric checks).
- Grade responses with LLM-as-judge graders (relevance, completeness, accuracy, groundedness, fact match).
- Add your own grader as an AiEvalGrader plugin in any module.
- Add a new dataset source (e.g. a custom store) as an AiEvalDatasetSource plugin.
- Contribute new rubric check kinds via a tagged check-executor service (with its own JSON Schema).
- Launch an evaluation run from the UI and watch live progress, or cancel it mid-run.
- Run evaluations headless from Drush (`ai-eval:run`) for CI pipelines.
- Review a results dashboard with run summaries, week-over-week trends, and target health meters.
- Drill into a run's per-question breakdown with grader scores and judge reasoning tooltips.
- Annotate individual question outcomes (pass/fail/defer + notes) for error analysis.
- Promote annotated examples into a dataset to grow your test set.
- Import real production traces (OTLP/JSON) and review them in a grouped queue.
- Label traces by verdict and dimension, then promote good ones into datasets.
- Rely on a promotion integrity guard that refuses truncated or uncaptured traces.
- Validate an LLM judge against human-labeled gold examples and view agreement statistics.
- Edit a judge's prompt and track per-grader trust state before relying on its scores.
- Optimize a target's system prompt by generating and A/B-testing candidate prompts (`ai-eval:optimize`).
- Define named failure modes and compute failure-rate breakdowns across runs.
- Export a run as a portable result envelope and import envelopes from other sites.
- Score the actual Drupal state an agent built with the optional ai_eval_droost grader.
