<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI AutoEvals — dashboard, results, and operations

All routes live under `/admin/content/ai-autoevals` (local tasks in `ai_autoevals.links.task.yml`)
and are permission-gated (see config/settings.md).

## Dashboard — `Controller\DashboardController::content()` (`ai_autoevals.dashboard`, `view ai autoevals results`)

`#theme => 'ai_autoevals_dashboard'` (template `templates/dashboard.html.twig`). Pulls
`EvaluationManager::getStatistics()` (total, per-status counts, average score, per-set count/avg)
and `getRecentEvaluations(10)`, plus a score distribution computed by five bounded
`database->select(...->countQuery())` calls. Stats are also attached as `drupalSettings.aiAutoevals`
for `ai_autoevals/dashboard` JS. Twig autoescapes all values.

## Results list — `Controller\EvaluationResultsController::listing(Request)` (`ai_autoevals.results`, `view ai autoevals results`)

Reads `status` / `evaluation_set` / `provider` from the query string and `page` for the pager, then
`EvaluationManager::getEvaluationHistory($filters, 25, $offset)` (bound entity-query conditions).
Renders a `#type => 'table'` with core `#type => operations` links (View / Requeue when
failed-or-pending / Delete) and a filter `details` element. Status is shown via a small
`getStatusBadge()` span from a fixed status→class map.

## Result detail — `Controller\EvaluationResultDetailController::view($result)` (`ai_autoevals.result_view`, `view ai autoevals results`)

Route param upcasts to `entity:ai_autoevals_evaluation_result` (entity access handler enforces
`view`). Builds action buttons (Requeue when failed/pending, Re-evaluate), a details table
(id/status/score/choice/set/provider/model/operation type/request id/created/changed, and a link to
the parent result when `re_evaluation_of` is set), and detail panels:

- **User Input**, **AI Output**, **LLM Analysis** → `#type => html_tag`, `#tag => pre`, value run
  through `htmlspecialchars()` (so stored input/output/analysis is escaped).
- **Extracted Facts** and **Tags** → `#theme => item_list` (auto-escaped); tags are stringified
  scalars.
- **Metadata** → `json_encode(..., JSON_PRETTY_PRINT)` in a `<pre>`.

## Operations

- **Requeue** — `ai_autoevals.result_requeue` (`Form\EvaluationRequeueForm`, `requeue ai autoevals`);
  a confirm form → `EvaluationManager::requeueEvaluation()`.
- **Re-evaluate with different config** — `ai_autoevals.result_reevaluate`
  (`Form\EvaluationReEvaluateForm`, `edit ai autoevals results`); re-runs the pipeline under a chosen
  evaluation set via `Service\EvaluationBatchProcessor`, storing a new result linked by
  `re_evaluation_of`.
- **Batch operations** — `ai_autoevals.batch` (`Form\BatchOperationsForm`, `batch ai autoevals`);
  batch re-evaluations / comparisons across many results via `EvaluationBatchProcessor`.
- **Delete** — `ai_autoevals.result_delete` (core `ContentEntityDeleteForm`, `delete ai autoevals
  results`).

All operation forms are standard Drupal `FormBase`/entity forms (POST + form/CSRF token) and each
requires its own permission, so evaluations (which incur provider cost) can only be triggered by
suitably-permissioned users or by the server-side event/queue path.

## Entity — `Entity\EvaluationResult` (base table `ai_autoevals_evaluation_result`)

Status constants pending/processing/completed/failed; typed getters/setters for
evaluation_set_id, request_id (+parent), provider_id, model_id, operation_type, input, output,
facts (JSON), score (decimal 5,4), choice (A–E), analysis, tags/metadata (map, scalar-filtered),
re_evaluation_of, created/changed. `EvaluationResultListBuilder` provides the core entity listing;
`views_data` = core `EntityViewsData`.
