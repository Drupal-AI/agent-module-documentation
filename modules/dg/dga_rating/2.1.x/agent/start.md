<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DGA Rating (dga_rating) — agent index

An accessible 1-5 star **rating widget block** with optional feedback and live average/count
statistics, implementing the Saudi **DGA Design System** Rating Section. Works for anonymous and
authenticated users. Package `Custom`. Core `^10 || ^11`, PHP `>=8.1`. License GPL-2.0-or-later.
Installed version 2.1.2. **No module dependencies** and no external services (uses `node` entity
classes opportunistically for context).

- **AJAX endpoints (submit/stats/refresh) + `DgaRatingService` data API** → [api/endpoints.md](api/endpoints.md)
- **The block, widget template & theming, bilingual text** → [blocks/widget.md](blocks/widget.md)
- **Admin dashboard, submissions list, edit/delete/bulk-delete, permissions** → [admin/dashboard.md](admin/dashboard.md)
- **Config object, schema, install defaults, Settings & Translations forms** → [config/settings.md](config/settings.md)

## What it actually is (from source)

- **Storage:** a custom `{dga_rating}` table (`dga_rating_schema()` in `dga_rating.install`) — NOT a
  content entity. Fields: `id`, `entity_type`, `entity_id`, `rating` (1-5), `feedback` (big text),
  `url`, `user_id` (NULL for anon), `ip_address`, `created`. Dropped on uninstall.
- **One block plugin:** `DgaRatingBlock` (id `dga_rating_block`, label "DGA Rating Widget",
  category Custom) in `src/Plugin/Block/`. Computes the current URL (alias, language-prefix
  stripped) and node context, fetches stats, renders `#theme => 'dga_rating_widget'`.
- **One service:** `dga_rating.service` → `Service\DgaRatingService` (args `@database`,
  `@config.factory`, `@cache_tags.invalidator`, `@logger.factory`). All DB reads/writes and stats
  math live here. Uses the DB query builder throughout (parameterized; `escapeLike` on LIKE).
- **Two controllers:** `DgaRatingController` (front-end JSON: `submitRating`, `getStats`,
  `refreshBlock`) and `DgaRatingAdminController` (`listSubmissions`, `editSubmission`, `bulkDelete`).
- **Forms:** `DgaRatingSettingsForm`, `RatingTranslationForm`, `DgaRatingEditForm`,
  `DgaRatingDeleteForm` (all in `src/Form/`).
- **Routes** (`dga_rating.routing.yml`): `dga_rating.submit` (POST `/dga-rating/submit`),
  `dga_rating.stats` (GET `/dga-rating/stats`), `dga_rating.refresh_block` (GET
  `/dga-rating/refresh-block`), `dga_rating.admin` (`/admin/content/dga-rating`), `.admin.edit`,
  `.admin.delete`, `.admin.bulk_delete` (POST), `.admin.settings`, `.translations`.
- **Permissions** (`dga_rating.permissions.yml`): `view dga rating dashboard`,
  `manage dga rating submissions`, `administer dga rating settings`. The public front-end routes
  use `_permission: 'access content'` (submit/refresh) or `_access: 'TRUE'` (stats).
- **Config:** one config object `dga_rating.settings` (schema + install defaults; most values are
  set in `hook_install()`). Bilingual EN/AR text, validation messages, and numeric behavior/limit
  settings (`rate_limit_max_submissions`, `rate_limit_time_window`, `feedback_max_length`,
  `refresh_delay`).
- **Libraries** (`dga_rating.libraries.yml`): `rating_widget` (js/rating.js + bootstrap/rating css,
  core jquery/drupal/once/drupalSettings), `admin` (js/admin.js + dropbutton), `toolbar_icon` (css).
- **Hooks** (`dga_rating.module`): `hook_theme` (two templates), preprocess for the admin template,
  `hook_page_attachments` (publishes `drupalSettings.csrfToken` for client use + attaches
  toolbar icon css), menu-link/local-task alters for the toolbar icon and tab layout.
- **Menu/tasks:** `dga_rating.links.menu.yml` + `.links.task.yml` build the admin section
  (Dashboard / Settings / Translations) with custom Menu/LocalTask plugin classes under
  `src/Plugin/Menu/`.

## Enable

`drush en dga_rating -y && drush cr`, then place the "DGA Rating Widget" block. See the linked docs.
