<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ai_empathy — settings & scheduled evaluation

Config object **`ai_empathy.settings`** (`config/schema/ai_empathy.schema.yml`,
install defaults `config/install/ai_empathy.settings.yml`), edited by
`AiEmpathySettingsForm` at **`/admin/config/ai/empathy/settings`**
(route `ai_empathy.settings_form`, permission `administer ai empathy`).

## Keys

Provider/model selections are opaque "simple option" strings from the `ai` module
(`AiProviderPluginManager::getSimpleProviderModelOptions('chat')`); this module stores **no API
keys** — credentials live in the `ai` provider configuration (Key module).

- `evaluation_provider_model` (string, required) — model that **generates** the response under test.
- `scoring_provider_model` (string, required) — model that **grades** the response (can be stronger).
- `generation_provider_model` (string) — model for the AI scenario builder; empty = reuse evaluation.
- `decision_accuracy_threshold` (float, %, default 70), `empathy_alignment_threshold` (float 1–5,
  default 3.0), `explanation_quality_threshold` (float 1–5, default 3.0),
  `consistency_threshold` (float %, default 75), `tone_alignment_threshold` (float 1–5, default 3.0 —
  only shown/saved when the `ai_empathy_ccc` submodule has added the `tone_alignment` field, gated by
  `AiEmpathySettingsForm::hasToneAlignment()`).
- `default_runs` (int 1–10, default 3) — runs per scenario; ≥2 enables consistency scoring.
- Scheduled block: `scheduled_enabled` (bool), `scheduled_frequency` (`6h|12h|24h|48h|weekly`,
  default `24h`), `scheduled_scenarios` (sequence of scenario ids; empty = all),
  `scheduled_provider_model` (string; empty = use evaluation model),
  `scheduled_alert_email` (string, email).

## Scheduled evaluation (cron)

`ai_empathy_cron()` (in `ai_empathy.module`) calls
`ai_empathy.scheduled_evaluator` → `EmpathyScheduledEvaluator::runIfDue()`
(`src/Service/EmpathyScheduledEvaluator.php`):

- Runs when `scheduled_enabled` is on **and** either the interval has elapsed (`isDue()`, intervals in
  `FREQUENCIES`) **or** the provider/model changed since the last run (`providerChanged()`, tracked in
  State keys `ai_empathy.scheduled.last_run` / `…last_provider`).
- Evaluates each selected scenario **once** via `EmpathyEvaluator::evaluateScenario()`, collects
  metric values below threshold (`collectBreaches()`, consistency skipped — a single run can't measure
  it), logs a summary to the `ai_empathy` logger channel, and on any breach or provider change sends an
  email.
- `sendAlert()` → `MailManagerInterface::mail('ai_empathy', 'threshold_alert', $to, …)`; the body is
  built by `ai_empathy_mail()` (subject + a plain-text breach list). `$to` is the admin-configured
  `scheduled_alert_email`.

## Enabling

`drush en ai_empathy -y` (pulls `ai`). Then set both provider/model selects on the settings form before
running any evaluation — services throw `RuntimeException('… not configured.')` if `scoring_provider_model`
is empty. Menu lives under *Configuration → AI → AI Empathy Evaluation* (`ai_empathy.links.menu.yml`).
