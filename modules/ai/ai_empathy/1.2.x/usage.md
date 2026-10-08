<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Empathy Evaluation scores and benchmarks how AI models handle ethical-dilemma scenarios, measuring decision accuracy, empathy alignment, explanation quality and consistency through the Drupal AI provider layer.

---

AI Empathy Evaluation is a testing and quality-assurance framework for empathetic AI decision-making. It ships a library of ethical-dilemma scenarios (Military, Medical, Emotion, Cultural, Organizational), sends each to a configured AI provider/model via the `ai` module, then uses a second "scoring" model to grade the response on four research-backed metrics. Around that core it adds a Chart.js dashboard, multi-provider benchmarking with CSV export and historical trends, a training mode, a human rating system with inter-rater reliability (Cohen's / Fleiss' kappa) and blind comparison, difficulty calibration, and scheduled cron evaluation with email alerts on threshold breaches. Eight optional submodules extend it with an AI guardrail, a governance (Trust · Accountability) triad, OpenTelemetry observability, a text-field "Check Empathy" action with an optional publish gate, Context-Control-Centre tone scoring, and Finance/Healthcare/HR scenario packs.

All UI lives under `/admin/config/ai/empathy` and every route is gated by one of four permissions (`administer ai empathy`, `run ai empathy evaluation`, `view ai empathy results`, `rate ai empathy results`). Evaluation and scoring consume the AI provider (token cost). Requires `drupal/ai ^1.3`; supports Drupal 10.4+, 11 and 12.

---

- Benchmark how OpenAI, Anthropic and other providers handle the same ethical dilemmas side by side.
- Score an AI response on decision accuracy, empathy alignment, explanation quality and consistency.
- Regression-test an AI feature's empathy over time and catch model-version drift.
- Run the 20 bundled dilemma scenarios across Military, Medical, Emotion, Cultural and Organizational categories.
- Author custom scenarios with a reference decision, context details and a 1–5 difficulty level.
- Generate new scenarios with the AI-assisted scenario builder.
- Use a separate, more capable "scoring" model than the "evaluation" model.
- View metric gauges, provider comparison, category performance and trend charts on the dashboard.
- Export a benchmark run to CSV for spreadsheet analysis.
- Run training mode with cumulative feedback across a session.
- Collect human ratings on AI responses and compute inter-rater reliability.
- Run blind A/B comparison of two responses without provider labels.
- Calibrate scenario difficulty from accumulated results.
- Schedule automatic evaluation on cron and email alerts when a metric drops below threshold.
- Alert when the evaluation provider/model changes.
- Add an Empathy Score Check guardrail that blocks low-empathy AI output (ai_empathy_guardrail).
- Add Accountability and Trust scores and a governance triad view (ai_empathy_governance).
- Ship evaluation metrics to Grafana/Tempo/Jaeger as OpenTelemetry spans (ai_empathy_observability).
- Add a one-click "Check Empathy" button to text-field widgets (ai_empathy_field_action).
- Block publishing moderated content whose empathy score is below threshold (ai_empathy_field_action gate).
- Score tone alignment against brand/organisational context (ai_empathy_ccc).
- Evaluate finance, healthcare or HR dilemmas with domain scenario packs and compliance scoring.
- Gate access with four dedicated permissions for admin, run, view and rate.
