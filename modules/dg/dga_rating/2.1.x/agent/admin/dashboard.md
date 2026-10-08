<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin dashboard, submissions & permissions

Source: `src/Controller/DgaRatingAdminController.php`, `src/Form/DgaRatingEditForm.php`,
`src/Form/DgaRatingDeleteForm.php`, `templates/rating-admin.html.twig`, `dga_rating.routing.yml`,
`dga_rating.permissions.yml`, `dga_rating.links.menu.yml` / `.links.task.yml`.

## Permissions (`dga_rating.permissions.yml`)

- `view dga rating dashboard` — view statistics and submissions read-only.
- `manage dga rating submissions` — edit, delete, bulk-delete submissions.
- `administer dga rating settings` — change configuration and translations.

## Routes

| Route | Path | Permission | Handler |
|---|---|---|---|
| `dga_rating.admin` | `/admin/content/dga-rating` | `view dga rating dashboard` | `DgaRatingAdminController::listSubmissions` |
| `dga_rating.admin.edit` | `/admin/content/dga-rating/{id}/edit` (`id: \d+`) | `manage dga rating submissions` | `DgaRatingAdminController::editSubmission` → `DgaRatingEditForm` |
| `dga_rating.admin.delete` | `/admin/content/dga-rating/{id}/delete` (`id: \d+`) | `manage dga rating submissions` | `DgaRatingDeleteForm` |
| `dga_rating.admin.bulk_delete` | `/admin/content/dga-rating/bulk-delete` (POST) | `manage dga rating submissions` | `DgaRatingAdminController::bulkDelete` |
| `dga_rating.admin.settings` | `/admin/content/dga-rating/settings` | `administer dga rating settings` | `DgaRatingSettingsForm` |
| `dga_rating.translations` | `/admin/content/dga-rating/translations` | `administer dga rating settings` | `RatingTranslationForm` |

Menu links (`.links.menu.yml`) build the section under `system.admin`: parent "DGA Rating" plus
Dashboard / Settings / Translations children, each with a custom `Plugin\Menu\*` class; local tasks
(`.links.task.yml`) render the same three as tabs (`hook_local_tasks_alter` hides the redundant
parent tab). `hook_menu_links_discovered_alter` + `toolbar_icon` library add the toolbar icon.

## listSubmissions()

Reads query params for pagination (`page`, fixed `limit = 50`), sorting (`sort`, `order`), filters
(`id`, `url`, `rating`, `feedback`, `user_id`, `date_from`/`date_to` via `strtotime`), and URL-stats
grouping options. Calls the service for: paged submissions + total count, overall stats, rating
distribution, per-URL statistics, unique URL count, top-rated / most-reviewed page, recent activity,
positive percentage, and user-type split. Builds a core pager and returns
`#theme => 'dga_rating_admin'` with `#cache max-age: 0`. `dga_rating_preprocess_dga_rating_admin()`
(in `dga_rating.module`) maps the `#`-prefixed render keys to plain template variables and defaults
any missing scalars/arrays.

## Rendering (`templates/rating-admin.html.twig`)

Stat cards render numeric aggregates. In the submissions table, user-supplied values are escaped:
`feedback` is printed with `|e` (and truncated with `|slice`), and each submission/URL link uses
`|e('html_attr')` on the `href`/`title` and `|e` on the visible text. Feedback is additionally
`Xss::filter()`-sanitized when stored, so the dashboard renders submitted text as escaped, inert
content.

## Edit / delete

- `DgaRatingEditForm` (`dga_rating_edit_form`) loads a row via `getSubmissionById()` (404 if
  missing), exposes a rating select (1-5) and a feedback textarea, and on submit calls
  `updateSubmission()` (which re-sanitizes/validates). Standard Form API → core CSRF token.
- `DgaRatingDeleteForm` is a confirm form deleting one row via `deleteSubmission()`.
- `bulkDelete()` reads `submissions[]` from the POST body and calls `bulkDeleteSubmissions()`
  (ids cast to positive ints), then redirects back to the dashboard with a status message.

## Config forms

- `DgaRatingSettingsForm` (`/admin/content/dga-rating/settings`) — edits `dga_rating.settings`
  front-end text and the numeric behavior/limit settings.
- `RatingTranslationForm` (`/admin/content/dga-rating/translations`) — a two-column EN/AR table that
  writes the `_en`/`_ar` text keys the widget/install actually read.

See [../config/settings.md](../config/settings.md) for the config object, schema and defaults.
