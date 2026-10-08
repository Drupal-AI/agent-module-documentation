<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DGA Feedback (dga_feedback) — agent index

Accessible bilingual (EN/AR) "Was this page useful?" Yes/No feedback widget with reasons,
optional comment, optional gender, live per-URL/per-entity statistics, and a full admin
submissions dashboard. Data lives in a custom `dga_feedback` DB table (no entity API).
Targets the Saudi DGA Design System.

- **Machine name:** `dga_feedback` · **Package:** Custom · **Namespace:** `drupal/dga_feedback`
- **Core:** `^10 || ^11 || ^12` · **PHP:** `>=8.1` · **Dependencies:** none (core only)
- **License:** GPL-2.0-or-later · **Security advisory coverage:** not-covered

## What it provides

- **Block plugin** `dga_feedback_block` ("DGA Feedback Widget", category Custom) —
  `src/Plugin/Block/DgaFeedbackBlock.php`. Renders the `dga_feedback_widget` theme
  (template `templates/dga-feedback-widget.html.twig`) with all strings resolved
  from config in the active language.
- **Service** `dga_feedback.service` (`src/Service/DgaFeedbackService.php`) — all DB
  reads/writes and statistics: `saveFeedback`, `getStatistics`, `getStatisticsByUrl`,
  `getStatisticsByEntity`, `getOverallStatistics`, `getAllSubmissions`,
  `getSubmissionById`, `deleteSubmission`, `bulkDeleteSubmissions`, `updateSubmission`,
  `purgeExpiredSubmissions`, plus dashboard aggregates (usefulness distribution,
  grouped-by-URL, recent activity, by-user-type).
- **Hooks** in `src/Hook/DgaFeedbackHooks.php` (OOP `#[Hook]`, bridged by
  `dga_feedback.module` `#[LegacyHook]`): `theme`, `preprocess_dga_feedback_admin`,
  `page_attachments`, `menu_links_discovered_alter`, `preprocess_menu`,
  `local_tasks_alter`, `cron` (retention purge).
- **DB table** `dga_feedback` (`dga_feedback.install`): id, entity_type, entity_id,
  is_useful, reasons (JSON), feedback, gender, url, user_id (NULL=anon), ip_address, created.
- **Config** single object `dga_feedback.settings` (schema in `config/schema/`, defaults
  in `config/install/` and re-seeded in `hook_install`): ~70 EN/AR string pairs plus
  numeric behavior/limit settings.
- **Permissions** (`dga_feedback.permissions.yml`): `view dga feedback dashboard`,
  `manage dga feedback submissions`, `administer dga feedback settings`.

## Routes (dga_feedback.routing.yml)

- `POST /dga-feedback/submit` → `DgaFeedbackController::submitFeedback` (JSON; POST-only,
  requires `X-Requested-With: XMLHttpRequest`; per-IP/user rate limiting).
- `GET /dga-feedback/stats` → `DgaFeedbackController::getStats` (JSON).
- `GET /dga-feedback/refresh-block` → `DgaFeedbackController::refreshBlock` (JSON).
- `/admin/content/dga-feedback` → dashboard (`DgaFeedbackAdminController::listSubmissions`).
- `/admin/content/dga-feedback/{id}/edit` → `DgaFeedbackEditForm`.
- `/admin/content/dga-feedback/{id}/delete` → `DgaFeedbackDeleteForm` (confirm form).
- `POST /admin/content/dga-feedback/bulk-delete` → `bulkDelete` (`_csrf_token: TRUE`).
- `/admin/config/dga-feedback/settings` → `DgaFeedbackSettingsForm`.
- `/admin/content/dga-feedback/translations` → `FeedbackTranslationForm`.

## Solution docs

- [Install, block placement & operation](operation/install.md)
- [Configuration, translations & config keys](config/settings.md)
- [Submit/stats endpoints & the feedback service API](api/endpoints.md)
- [Admin dashboard, edit/delete & permissions](admin/dashboard.md)
