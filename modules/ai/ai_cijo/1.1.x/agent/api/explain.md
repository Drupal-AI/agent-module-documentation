<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI-CIJO — explainability page and URL simulation

Both surfaces require `administer ai cijo` and read/write the current user's **private** tempstore
collection `ai_cijo` (per-user; cleared on uninstall by `ai_cijo_uninstall()`).

## Explain page — `Controller\ExplainController::page()` (route `ai_cijo.explain`, `/admin/ai-cijo/explain`)

- If `ai_cijo.settings:explain` is false, renders a short "Explainability is disabled" notice with a
  link to settings.
- Otherwise builds three sections:
  1. **Last real request** — `tempstore->get('last_explain')` (written by `RequestSubscriber` on
     each evaluated live request); rendered via `buildReport($stored, FALSE)`.
  2. **Explain by URL** — embeds `Form\ExplainUrlForm`.
  3. **Simulated explain** — shown only when `tempstore->get('simulated_explain')` exists;
     rendered via `buildReport($stored, TRUE)`.
- `buildReport()` returns a `#theme => 'ai_cijo_explain'` render array with `#intent`, `#stage`,
  `#confidence`, `#explanations`, `#path`, `#timestamp`, `#outcome` (the stored state),
  `#simulated`, `#excluded_from_simulation`, and a pre-encoded `#json_payload`
  (`json_encode(..., JSON_PRETTY_PRINT|JSON_UNESCAPED_SLASHES)`) for the copy panel. The template
  `templates/ai-cijo-explain.html.twig` renders intent/stage badges, a confidence bar, the
  explanation list, the orchestration outcome (hidden/shown blocks, view filters, layout variant,
  CTA), an exclusions notice for simulations, and the JSON export textarea. Library
  `ai_cijo/explain` supplies the CSS/JS (including the copy button).

## Simulation — `Form\ExplainUrlForm` (form id `ai_cijo_explain_url_form`)

- Single `url` textfield (an **internal path**, e.g. `/node/2`).
- `validateForm()`: requires a non-empty value beginning with `/`; rejects any value containing
  `://` or matching `#^//[^/]#` (no scheme/host — internal only); rejects paths under
  `/admin/ai-cijo`, `/admin/config/ai/ai-cijo`, `/admin/structure/ai-cijo`; then resolves the path
  with `router.no_access_checks->match($path)` (catching `ResourceNotFoundException`) and caches the
  route info. It only **matches** the path to a route — it does not render the page or issue any
  HTTP request.
- `submitForm()`: `collector->collect(['path'=>$path, 'route_name'=>$route, 'simulated'=>TRUE,
  'referrer'=>NULL])`, runs the configured detector (fallback if missing), builds the state, and
  writes `simulated_explain` to the `ai_cijo` private tempstore (including
  `excluded_from_simulation`), then redirects back to `ai_cijo.explain`.

## Notes

- Detector `explanation` strings, `intent`, `stage`, and `path` are all rendered through Twig
  autoescaping (or as `<code>`), so remote/detector text is escaped in the report.
- The signals are request-scoped and anonymous (path, referrer, roles, language, timestamp); the
  simulation deliberately clears the referrer and lists cookies/session/headers as excluded.
