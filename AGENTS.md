# Agent Module Documentation

A reusable, **agent-consumable** knowledge base of popular Drupal 11 contrib modules.
For each module we install it, read its code and config, and distill compact structured
docs an agent can read *instead of* the module source — cheaper in tokens, faster to act on.

This file is the specification. The step-by-step method lives in [`documentation/`](documentation/).

## Mission

Go module by module, in **popularity order**, over every module that supports Drupal 11.
For each one: fetch the latest release (highest major) compatible with Drupal 11 via
Composer, install and set it up, and produce three files that let an agent understand and
operate the module without reading its source.

## Data source

Modules come from the Drupal.org JSON:API, sorted by active installs, paginated:

```
https://www.drupal.org/jsonapi/node/project_module
  ?sort=-field_active_installs_total
  &filter[min][condition][path]=field_core_semver_minimum
  &filter[min][condition][operator]=<=
  &filter[min][condition][value]=11999999
  &filter[max][condition][path]=field_core_semver_maximum
  &filter[max][condition][operator]=>=
  &filter[max][condition][value]=11000000
```

- ~8 items per page. Advance with `page[offset]=N*8` (or `page[offset]` + `page[limit]`).
- The current page/offset we have reached is stored in [`pagination.md`](pagination.md)
  (just the integer) so any agent can resume.
- Release/version numbers are **not** in this feed — get the real installed version from
  Composer after `composer require`.
- See [`documentation/data-source.md`](documentation/data-source.md) for the field map.

## Keeping docs current (new stable minors)

The JSON:API feed above ranks modules but carries no per-release data. Two Drupal.org
endpoints fill that gap; **prefer the incremental one** so a routine check costs a handful
of requests, not thousands.

**Per-project truth — the release-history feed** (what core's Update Status uses):

```
https://updates.drupal.org/release-history/{project}/current
```

- XML listing every release on the project's **currently supported** branches, newest first.
  Use `/current`, not `/all`, so abandoned branches don't come back.
- Each `<release>` has `<version>` (`3.6.3`), `<date>`, `<core_compatibility>`, `<security>`;
  `<supported_branches>` lists the live minor branches.
- Unknown project → `<error>…</error>` body at **HTTP 200**; detect failure by the `<error>`
  tag, never the status code.

**Global stream — the legacy api-d7 release feed** (JSON:API does *not* expose releases):

```
https://www.drupal.org/api-d7/node.json?type=project_release&sort=created&direction=DESC&page=N
```

- 50 releases/page, newest first. `title` is `"machine_name version"`;
  `field_release_version_major`/`_minor`; `field_release_version_extra` is empty for stable
  (`alpha2`/`rc1`/`dev` otherwise); `field_release_build_type` is `static` (tagged) vs
  `dynamic` (dev); `created` is the unix timestamp used as a watermark.
- It carries **no core-compatibility** (`taxonomy_vocabulary_7` is *Release type*, not core),
  so D11 is confirmed per-candidate with one release-history lookup.

### The two scanners

- **`scripts/scan-recent-releases.py`** — the routine tool. Walks the global stream backwards
  from the newest release to a stored watermark (`scripts/.release-watermark`), keeps stable
  releases of modules we already document, collapses to the newest minor per `(project,
  major)`, then confirms D11 with one release-history call per candidate. First run without a
  watermark scans `--days N` back (default 30); `--no-update` for a dry run;
  `--set-watermark-now` to prime it. Typical cost: a few pages + a few confirm calls.
- **`scripts/scan-new-minors.py`** — the full backfill. `--all` polls release-history for
  every documented module (~8,900 requests); also takes explicit names or `--list FILE`. Use
  it for a one-off complete sweep, not routine checks.

Both apply the same rules and emit the same TSV worklist:
`project ⇥ branch ⇥ version ⇥ dir-path ⇥ reason`. **D11-only** (a release counts only if its
`<core_compatibility>` admits `^11`) and **stable-only** (`-alpha`/`-beta`/`-rc`/`-dev`
ignored). Coverage is modelled, not string-matched, because the tree mixes `3.x` (major-only),
`3.0.x` (minor) and `8.x-1.x` (legacy) dir names — a major-only dir covers every minor of that
major, so it never produces a false gap. A missing minor is documented in a **new**
`{minor}.x/` dir beside the existing one (nothing deleted), via the same per-module pipeline.

### Re-documenting a wave from the worklist

`scripts/wave-context.py <start> <count>` prints, for that slice of the worklist, each
module's `project ⇥ new-branch ⇥ version ⇥ reason ⇥ src-path ⇥ newest-template-dir ⇥
installed-version` — the template dir seeds the new docs and the last two columns catch the
install trap below.

**Always diff installed-vs-target before documenting.** `composer require drupal/<name> -W`
does **not** reliably land the target release: it frequently resolves a **dev checkout**
(`8.x-<n>.x-dev`, no `version:` in the info.yml), an **older** tag (a newer minor caps below
this site's core, e.g. `>=11 <11.3`, or a dependency clash blocks it), or a **beta/rc** when
the target is the stable. Roughly 40% of modules in the last full run needed the fallback.
Where the installed `version:` ≠ the worklist target, document from the **release tarball**
instead of the working copy:

```
curl -sfL https://ftp.drupal.org/files/projects/<project>-<version>.tar.gz | tar xz -C <scratchpad>
```

point the doc subagent at the extracted dir, and never enable/build a module that can't
install on the current core. When re-documenting, the subagent MUST NOT emit tool-call/markup
tags (`</content>`, `</invoke>`) into file bodies — validate each wave with a grep for those
plus a `json.load` on every `data.json` before committing.

## What we produce, per module

> **Current practice (waves ~44 onward).** The full layout below is the specification, but
> recent waves ship **only** `data.json`, `usage.md`, `agent/**` and — where a finding
> warrants it — a local-only `security.md`. `eval/`, `human-docs/` and screenshots have not
> been produced since wave ~44; the commit messages say so explicitly ("no evals/human-docs/
> screenshots"). Keep writing the agent docs; treat the eval and human-docs sections as the
> spec for work that is currently paused, not as a checklist you are failing.

Modules are bucketed by the **first two letters of the machine name** so no single
directory grows unwieldy (`modules/{ab}/…` where `{ab}` is `machine_name[0:2]`):

```
modules/{ab}/{machine_name}/{major.minor.x}/
├── data.json          # structured metadata (see documentation/file-formats.md)
├── usage.md           # short summary / long summary / 15–30 use cases, split by ---
├── agent/
│   ├── start.md       # token-cheap index linking to the solution docs below
│   └── {solution_type}/{name}.md   # configure, plugins, extend, drush, api, hooks, ...
├── human-docs/        # human-facing mkdocs site: manual setup with screenshots (see below)
│   ├── index.md
│   ├── {section}/index.md          # installation, configuration, ... one dir per topic
│   └── images/*.png                # committed screenshots referenced from the pages
└── eval/
    └── evals.json     # easy + medium + hard eval cases (see the Evals section below)
```

e.g. `modules/ac/access_unpublished/1.9.x/`, `modules/to/token/1.17.x/`. The two-letter
bucket is derived from the machine name's first two characters (lowercase); a module whose
name is itself two letters buckets under itself, e.g. `modules/og/og/2.0.x/`.

**Submodules nest under their parent**, mirroring how they ship inside the project.
A submodule lives in a `modules/` directory *beside* the parent's version directory (the
two-letter bucket applies only to the top-level project, not to nested submodules), so its
docs sit at `modules/{ab}/{parent}/modules/{submodule}/{version}/…`. Nesting can be more
than one level deep when a submodule itself has submodules, e.g.:

```
modules/vi/video_embed_field/3.1.x/…
modules/vi/video_embed_field/modules/video_embed_media/3.1.x/…
modules/vi/video_embed_field/modules/video_embed_media/modules/vem_migrate_oembed/3.1.x/…
```

Admin-UI screenshots are stored **outside this repo**, one level up at the project root
(`<project-root>/screenshots/{machine_name}/{major.minor.x}/*.png`), and referenced from the
solution docs. They are binary artifacts we intentionally do not commit.

- The version directory is `major.minor.x` (patch dropped), derived from the installed
  release, e.g. `to/token/1.17.x`, `pa/pathauto/1.15.x`.
- **Submodules** shipped inside a module each get their own tree with the same three
  files, nested under the parent at
  `modules/{ab}/{parent}/modules/{submodule_machine_name}/{version}/` (see the layout above).
- Every `agent/**/*.md` must be **shorter than reading the equivalent source** — that is
  the whole point. If it isn't, cut it.

## Human documentation (mkdocs)

Alongside the token-cheap `agent/` docs, every module gets a **`human-docs/`** folder: a
human-facing manual that reads like real product documentation and follows
[mkdocs](https://www.mkdocs.org/) conventions (Markdown pages that a `mkdocs` build could
render as-is). Where `agent/` tells an agent *what to call*, `human-docs/` shows a **person**
how to click through the module's forms and set it up by hand.

Layout — `index.md` at the root plus **one directory per topic**, each with its own
`index.md` (mkdocs nested-page style):

```
modules/{ab}/{machine_name}/{version}/human-docs/
├── index.md              # landing page: what the module is + a linked table of contents
├── installation/
│   └── index.md          # requirements, composer require, enabling, submodules
├── configuration/
│   └── index.md          # global/admin settings, dependencies (e.g. AI provider + key)
├── {task}/
│   └── index.md          # one dir per major user task the module supports
└── images/
    └── *.png             # screenshots referenced by the pages
```

Rules:

- **Write for a human, not an agent.** Numbered click-by-click steps ("Go to *Configuration
  → …*, click **Add**, fill in …"), what each important field does, and what a correct
  result looks like. Prose and headings, not terse bullet indexes.
- **Every form and setup step gets a screenshot.** Capture the real admin UI with
  `agent-browser` (see [`documentation/browser-screenshots.md`](documentation/browser-screenshots.md)
  for login/capture mechanics) and embed it under the relevant step. **Always shoot
  at 1920×1080** — `agent-browser set viewport 1920 1080` then a viewport screenshot
  (no `--full`). For content taller than 1080px, scroll the relevant section into
  view and take a second 1920×1080 shot rather than one full-page image.
- **human-docs screenshots ARE committed** — they live *inside* the repo at
  `human-docs/images/` and are referenced with a **relative** path
  (`![alt](../images/<shot>.png)` from a `{topic}/index.md`). This is a deliberate exception
  to the agent-doc rule that keeps screenshots outside the repo: here the screenshots are the
  deliverable. Keep them reasonably sized (full-page PNGs of the relevant form only).
- **index.md is the nav hub** — a short intro then a table of contents linking each section
  (`- [Installation](installation/index.md)`), mirroring an mkdocs `nav`.
- Start with `installation` and `configuration`; add one directory per significant manual
  task (creating an entity, wiring an integration, running the feature). Skip tasks that have
  no UI (pure code/API usage belongs in `agent/`, not here).

## Categories

[`categories.yml`](categories.yml) is the canonical category → subcategory taxonomy.
Consult it before inventing a category name so we don't create duplicates. Top-level
categories are seeded from Drupal.org's official module-category vocabulary; subcategories
grow organically as modules are processed. Add new names there, never duplicate.

## Install & setup rules

- This is a Drupal 11 site in DDEV (`module-documentor`). From the **host** prefix commands
  with `ddev` (`ddev composer`, `ddev drush`); **inside the container** run `composer` /
  `drush` directly.
- **Installs are per wave, not cumulative.** Install only the modules the current wave needs,
  document them, then remove them and reset the database before the next wave —
  `scripts/wave-reset.sh`. The cumulative model saturated at 2,311 root requirements and
  wave 54 could not install a single one of ten verified-D11 projects; every failure was a
  version clash with something an earlier wave had pinned. See
  [`documentation/workflow.md`](documentation/workflow.md) for the cycle and the recovery
  path (`.campaign-backups/`).
- Install: `composer require drupal/{name} -W`, then `drush en {name} -y`.
- Setup: read exported/default config, resolve the `configure` route from `*.info.yml`,
  note permissions and any Drush commands.
- **Use the simplest tool for each step** (`drush`/config over the UI). When a module has
  admin forms/UI, drive them with `agent-browser` and save screenshots to
  `<project-root>/screenshots/{name}/{version}/` — **outside this repo** (screenshots are
  binaries we do not commit) — see
  [`documentation/browser-screenshots.md`](documentation/browser-screenshots.md).
- **Test every code snippet** you put in a doc against the live site before committing it.
- Installs are **cumulative** (modules are left enabled). If the site breaks, reinstall it
  with `drush site:install -y` and continue — nothing here depends on site content.

## Evals

Every module gets an `eval/evals.json`, and it must **always contain all three difficulty
tiers** — do not stop at asking questions. See [`evaluation/README.md`](evaluation/README.md)
for the exact case shape, grading, and harness mechanics. Aim for **2-3 cases of each tier**:

- **easy** (`mode: "recipe"`) — answer a question out of the box, graded on the response
  text (`must_contain_any` / `must_not_contain`). No site changes.
- **medium** (`mode: "introspection"`) — answer a question about the module's *current
  setup on the live site*. A per-case `setup` script first saves a **known config** (an
  entity, a settings value, a field, a plugin instance); the agent must inspect the running
  site to answer; a `cleanup` script restores the baseline. This proves the agent can find
  and read real configuration, not just recite docs.
- **hard** (`mode: "execution"`) — the agent must **build** something and it is verified
  against live state. A `reset` script clears state, the agent writes the config / creates
  the entities / codes the plugin, and a `verify` script checks the result (exit 0 = pass).

So the suite must exercise the full range: **read about it (easy) → look up how it's
configured here (medium) → configure it / write configs, entities, and plugins (hard)**.
Reset/setup/cleanup/verify scripts live in `evaluation/verify/` and are referenced from the
case (paths relative to the project root). Every script must be smoke-tested: a medium
`setup` makes the answer discoverable then `cleanup` restores baseline; a hard case must
FAIL on empty state, PASS after a correct build, and leave the site clean. Tag every case
with `difficulty` (`easy` | `medium` | `hard`). Do **not** run the eval harness as part of
documenting a module — authoring the cases is enough; runs are a separate step.

## Pipeline (summary)

1. **Pick targets.** Cheapest first: `scripts/undocumented-on-disk.sh` (modules composer
   already pulled as dependencies — no resolution needed, cannot fail to install), then
   `scripts/next-wave.sh N | scripts/check-d11.sh --stdin --only-ok` (the campaign list,
   pre-filtered against drupal.org release history so projects with no Drupal 11 release
   never reach composer).
2. **Install.** `scripts/safe-install.sh --file wave.txt`, then
   `scripts/wave-prepare.sh --file wave.txt` to enable and get the manifest.
3. For each module: determine version → read code/config → set up → write `data.json`,
   `usage.md`, `agent/*` (+ `security.md` if a finding turns up — and never mention or describe that
   finding anywhere public; see `documentation/file-formats.md`). See the *Current practice*
   note above about `eval/` and `human-docs/`.
4. Recurse into submodules.
5. Update `categories.yml`; record anything unusable in `scripts/.campaign-skip` **with a
   reason**; commit as one wave.

Note `pagination.md` is **stale** — it still holds the old feed offset (`61`). Since wave ~2
the campaign has been driven by `.campaign-5000.txt` + `scripts/.campaign-skip`, recomputed
from disk on every call, so there is no cursor to advance.

Full detail: [`documentation/workflow.md`](documentation/workflow.md).
Reusable helpers live in [`scripts/`](scripts/).
