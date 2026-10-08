<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Overlay attachment, JS behavior, and statistics endpoints

## How the overlay is attached (server side)

`EventSubscriber\AgeGateSubscriber` (service `ab_age_gate.request.event`, args: `request_stack`,
`config.factory`, `ab_age_gate.statistics`, `url_generator`) subscribes to
`KernelEvents::RESPONSE` at priority **1000** via `getSubscribedEvents()`.

`onResponse(ResponseEvent $event)`:

1. Only the main request is processed (`isMainRequest()`).
2. Loads `ab_age_gate.settings`, reads `ignore_pages`, splits on `PHP_EOL`; returns early if the
   current URI matches an ignore entry (`<front>` exact, else `str_contains`).
3. Returns early if the URI contains `admin`, `node/add`, or `translations/add`.
4. If the response implements `AttachmentsInterface`, it merges into `drupalSettings`:
   `drupalSettings['ageGateSettings'] = $config->getRawData()` plus `default_language`, and appends
   library `ab_age_gate/age_gate`.

So the **entire `ab_age_gate.settings` config is exposed in `drupalSettings`** on every gated page
(this is presentation config — locale text, colors, image URLs, node ids — no secrets), and the
gating happens purely in the browser.

## JS behavior (assets/js/age-gate.js)

`Drupal.behaviors.ageGate` (deps `jquery`, `drupal`, `js-cookie`, `once`):

- If cookie `agegate` is set → return immediately (no overlay).
- Otherwise builds an HTML string from `drupalSettings.ageGateSettings` and `.prependTo(document.body)`
  a full-screen `#age-overlay`. Inline styles come from the color/font config; header/subheader/
  error/footer copy come from `language_texts.languages[currentLang]` (falls back to `en`).
- Mode `1` renders day/month/year number inputs; mode `2` renders Yes/No buttons; mode `3` renders a
  year input that progressively reveals month/day near the boundary.
- Age math: `isDate18orMoreYearsOld(day,month,year)` compares `new Date(year+18, month-1, day) <= now`
  (the `+18` is literal, not `age_restriction`); `_calculateAge()` supports the dynamic-year mode.
- On success it sets the `agegate` cookie (persistent if "remember" is checked, else default) and
  hides/redirects; on failure it shows the too-young/invalid errors. Optional GTM `dataLayer.push`
  GAEvents fire when `use_datalayer` is on.
- Language preselect: after choosing a language it calls `setRedirectToLanguage()`, which rebuilds a
  **same-site** path (`'/' + selectedLang + '/' + path`) from `window.location.pathname` and the
  chosen locale key, then sets `window.location.href`.

## Statistics: routes, controller, service, table

Three routes in `ab_age_gate.routing.yml`, all with `_permission: 'access content'`:

| Route | Path | Controller method | Effect |
|---|---|---|---|
| `ab_age_gate.select_statistics` | `/ab_age_gate/select` | `StatisticsController::select` | Returns current day's counters row as JSON. |
| `ab_age_gate.insert_statistics` | `/ab_age_gate/insert` | `StatisticsController::insert` | Inserts today's row (`load`, `isMobile` from POST). |
| `ab_age_gate.update_statistics` | `/ab_age_gate/update` | `StatisticsController::update` | Increments a counter (`type`, `isMobile` from POST). |

`Controller\StatisticsController` (services `ab_age_gate.statistics`, `request_stack`) reads
`request->request->all()` and delegates to `AgeGateStatistics`. The JS calls `/select` on load, then
`/insert` (first hit of the day) or `/update` with `type` in `load|success|under18|fail`.

`AgeGateStatistics` (arg `@database`) over table **`ab_age_gate_statistics`**:

- `selectCurrentData()` — `SELECT *` where `day_id = date('dWY')` (fetchAssoc).
- `insertCurrentData($load, $isMobile)` — inserts a row keyed by `day_id` (PK), `week_id = date('WY')`,
  setting desktop/mobile from `$isMobile`.
- `updateData($type, $isMobile)` — re-selects the day row, then `UPDATE … WHERE day_id = today`
  incrementing `load` and the matching `type` counter (and desktop/mobile).

All DB access uses the query builder (`->fields()`, `->condition()`); `type` is compared in PHP, so
there is no SQL string concatenation.

### Schema, Views, hooks (ab_age_gate.module)

- `hook_schema()` defines `ab_age_gate_statistics` — all columns `varchar(255)`; primary key `day_id`
  (format `date('dWY')`, i.e. day+ISO-week+year). `hook_uninstall()` drops the table and deletes both
  `ab_age_gate.settings` and `views.view.custom_ab_agegate_statistics`.
- `hook_views_data()` exposes every column as standard field/sort/filter/argument under group
  *Ab AgeGate*, base table `ab_age_gate_statistics` (id field `day_id`).
- `config/install/views.view.custom_ab_agegate_statistics.yml` provides the dashboard View (with a
  CSV data-export display, hence the `views_data_export` / `rest` / `serialization` / `csv_serialization`
  deps).
- `hook_form_alter()` wraps the exposed filter form of
  `views-exposed-form-custom-ab-agegate-statistics-embed-1` in a `<div class="hidden">`.

## Operating notes

- Because the counters routes are the module's telemetry, they are reachable by the same anonymous
  visitors who see the gate. `insert` uses `day_id` as the primary key, so a duplicate insert for a
  day that already has a row raises a DB exception (uncaught).
- The overlay never blocks server-side delivery — treat statistics as best-effort UX telemetry, not
  audited access logs.
