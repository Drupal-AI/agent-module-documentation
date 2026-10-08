# Eval catalog + dashboard site — design

**Date:** 2026-07-10
**Status:** approved

## Goal

A static, GitHub-Pages-hosted site (previewable locally via npm) with two pages:

1. **Catalog** — browse all documented modules, search/filter, see metadata and which
   modules have evals/results.
2. **Dashboard** — pick a module from a dropdown and see each eval question graphed for
   every metric, compared across arms (vanilla/skill/memory) and models (opus/haiku…).

## Stack

- **Vite** (dev server + multi-page build), **vanilla JS**, **Chart.js** for graphs.
- No UI framework. Clean, responsive, light/dark-aware vanilla CSS.

## Layout

```
agent-module-documentation/
  site/
    index.html            # Catalog
    dashboard.html         # Graphs
    src/{catalog.js, dashboard.js, charts.js, style.css}
    scripts/build-data.mjs # aggregates modules/** -> public/data/*.json
    public/data/           # generated (git-ignored)
    vite.config.js
    package.json
  .github/workflows/pages.yml
```

## Data pipeline (`build-data.mjs`, Node, no deps)

Walks `../../modules/**` for `<version>/data.json`; for each, checks sibling
`eval/evals.json` and `eval/results.json`. Emits into `public/data/`:

- `catalog.json` — array of records keyed by `data_name`:
  `{ key, name, description, version, docPath, list_position, active_installs,
     categories, subcategories, keywords, part_of, provides (flags), hasEvals,
     hasResults, evalCount }`.
- `eval-results.json` — object keyed by `data_name`, only modules with `results.json`:
  the full `results.json` `cases` (question + `results[arm][model:effort]` metrics).

Runs before `dev` and `build` so the site always reflects the repo.

## Page 1 — Catalog (`index.html` / `catalog.js`)

- Loads `catalog.json`. Card/grid of all modules.
- Live text search (name / description / keyword / data_name).
- Filters: category (select), has-evals, has-results (checkboxes), popularity tier
  (all / top-100 / top-250 / top-500 by `list_position`).
- Sort by `list_position` asc (nulls last). Result count shown.
- Each card: name, machine name, description, version, list_position, active installs,
  category tags, `provides_*` chips, and an **evals ✓ / results 📊** badge. Cards with
  results link to `dashboard.html?module=<key>`.

## Page 2 — Dashboard (`dashboard.html` / `dashboard.js` + `charts.js`)

- Module dropdown = keys of `eval-results.json` (modules with results). Honors
  `?module=<key>`.
- For the selected module, one **grouped bar chart per metric**: pass-rate
  (`correct/runs`), `in_tokens`, `cache_reads`, `out_tokens`, `time`, `cost`.
- X-axis = eval questions (case ids; full prompt in tooltip). One **series per
  `arm · model:effort`** (e.g. `skill · opus-4-8:medium`); legend toggles series.
- `cache_reads` may be null (older runs) → rendered as gaps.

## npm jobs

- `npm run dev` — build data, start Vite dev server (local preview).
- `npm run build` — build data, `vite build` → `dist/`.
- `npm run preview` — serve built `dist/`.
- `npm run build:data` — regenerate `public/data/*` only.

## Deploy

`.github/workflows/pages.yml`: on push touching `site/**` or `modules/**`, run
`npm ci && npm run build` in `site/`, deploy `dist/` to GitHub Pages. Vite `base: './'`
(relative) so it works under a project-pages path without hard-coding the repo name.
User enables Pages (source: GitHub Actions) once.

## Non-goals (YAGNI)

- No inline rendering of usage.md / agent docs (metadata + search only).
- No server/DB — fully static, data baked at build time.
- Dashboard covers only modules that have been *run* (have `results.json`); the 8
  eval-only modules appear in the catalog with an "evals ✓" badge but no graph.
