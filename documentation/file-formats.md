# File formats

Every `modules/{ab}/{name}/{version}/` directory holds exactly these three deliverables
(`{ab}` = the machine name's first two letters — a bucket so `modules/` stays browsable).

## `data.json`

Structured metadata, distilled from `*.info.yml`, `composer.json`, and the feed. Fields:

| Field | Source | Notes |
|---|---|---|
| `name` | info.yml `name` / feed `title` | human-readable |
| `data_name` | machine name | = directory name |
| `description` | info.yml `description` | one line |
| `version` | Composer / info.yml | `major.minor.x` |
| `package` | info.yml `package` | may be absent |
| `composer_namespace` | feed / composer.json `name` | e.g. `drupal/token` |
| `composer_requirements` | module `composer.json` `require` | the module's own deps (object) |
| `dependent_modules` | info.yml `dependencies` | Drupal module deps (array) |
| `configure` | info.yml `configure` | route name of the config UI, or `null` |
| `core_version_requirement` | info.yml | e.g. `^10.3 \|\| ^11` |
| `active_installs` | feed `field_active_installs_total` | popularity |
| `list_position` | feed rank by active installs | 1-based popularity rank of the module's **project** in the Drupal.org D11 feed (`token`=1); submodules inherit their parent project's rank; `null` if the project isn't in the feed. Enables tiered analysis (top-100 vs top-1000). |
| `project_url` | derived | `https://www.drupal.org/project/{name}` |
| `license` | composer.json `license` | |
| `php_requirement` | composer.json `require.php` | if declared |
| `library_dependencies` | composer.json `require` (non-drupal) | external libs, if any |
| `suggests` | composer.json `suggest` / info.yml `recommends` | optional extras |
| `submodules` | `modules/*/` info.yml | array of machine names (`[]` if none) |
| `provides_permissions` | `{name}.permissions.yml` exists | bool |
| `provides_drush_commands` | `drush.services.yml` / `src/Drush` | bool |
| `provides_config_schema` | `config/schema/*` exists | bool |
| `provides_plugin_types` | plugin manager in `src/` | array of plugin type ids (`[]` if none) |
| `categories` | feed categories | official names, match `categories.yml` |
| `subcategories` | our taxonomy | finer groupings from `categories.yml` |
| `keywords` | derived | search terms |

### Enriched project metadata (deterministic, from the JSON:API feed)

Added by [`scripts/enrich-data-json.py`](../scripts/enrich-data-json.py), which fetches the
project node by machine name — no reinstall. These are **project-level**, so every version dir
and submodule of a project carries the same values. Run it after documenting a module
(`--dir modules/{ab}/{name}`) or backfill the whole tree (`--all`).

| Field | Source (JSON:API `node/project_module`) | Notes |
|---|---|---|
| `project_description` | `body.processed` → plaintext | the **real** project-page description (vs the info.yml one-line `description`); capped ~4000 chars; also fed into search |
| `maintenance_status` | `field_maintenance_status` (term name) | e.g. "Actively maintained" |
| `development_status` | `field_development_status` (term name) | e.g. "Under active development" |
| `security_advisory_coverage` | `field_security_advisory_coverage` | e.g. `covered` |
| `project_created` | `created` | `YYYY-MM-DD` |
| `project_changed` | `changed` | `YYYY-MM-DD` |
| `core_semver_minimum` / `core_semver_maximum` | same feed fields | ints, e.g. `8000000` / `12000000` |

### Config-schema quality (`config_schema_quality`, static source scan)

How well the project's config schema serves an agent that has to read or write its config.
Computed from the project's source (parent + submodules, `tests/` excluded) by
`.redo/schema_quality.py`, via `.redo/scan_tooling.py` (sweep) or `.redo/regen_tooling.py`
(per wave). Parent project's top-level `data.json` only. Ratios are `null` when there is
nothing to measure.

| Field | Meaning |
|---|---|
| `schema_files` / `schema_definitions` | `config/schema/*.schema.yml` files / top-level schema keys |
| `coverage.checked` / `covered` / `ratio` | config the project **owns** that should have a schema: shipped `config/install\|optional` objects named after one of its modules, simple config read in code (`->config('x.settings')`, `getEditableConfigNames()`), config entity types (`<module>.<prefix>.*`), and settings of plugins with non-empty defaults (formatter/widget/field type/block/condition/action/filter). Only the project's own schema keys count. Config owned by other extensions is skipped. |
| `coverage.uncovered` | names/patterns lacking a schema (first 25) |
| `labels.labeled_ratio` | schema elements (top-level keys + mapping keys) with a `label` |
| `labels.agent_usable_ratio` | elements whose label (+ any unofficial `description:`) adds an informative word beyond the key's own name. `max_length` → "Max length" is **not** usable; "Maximum alias length in characters" is. |
| `constraints.ratio` | non-boolean leaf elements with validation: explicit `constraints:` (`Range`, `Choice`, `Length`, `Regex`, `NotBlank`, …) or a core type with built-in constraints (`machine_name`, `required_label`, `uuid`, …) |
| `constraints.types` | tally of explicit constraint names |
| `ignores.count` / `paths` | elements typed `ignore`: excluded from schema validation entirely (first 25 paths) |
| `undefined_count` / `fully_validatable` | elements typed `undefined` / top-level keys marked `FullyValidatable` |
| `description_review` | **model-read** verdict on every element's text (label + `description:`): could an agent use it as a tool parameter description, knowing only the key path and type? `good` / `weak` (agent left guessing: units, allowed values, format, effect) / `bad` (no usable information, echoes a non-obvious key, or wrong / copy-pasted) / `missing` (no text). `good_ratio` = good ÷ all elements; `examples` = up to 3 flagged elements with the reason; `rubric` names the rubric version. Present only on fully-read version-dirs; the structural `labels.*` ratios are the cheap heuristic and are kept alongside. |

## `usage.md`

Three blocks separated by a line containing only `---`:

1. **Short summary** — 1–2 sentences: what the module does.
2. **Long summary** — 5–8 sentences: what it does and how, at a glance.
3. **Use cases** — a markdown bullet list of **15–30** concrete things you'd use it for.

## `agent/start.md` + solution docs

`start.md` is a **token-cheap index**: a couple of orientation lines, then one bullet per
capability linking to a solution doc. Keep it scannable.

Solution docs live in `agent/{solution_type}/{name}.md`. Use only the types the module
warrants:

| Type | Covers |
|---|---|
| `configure` | admin UI config, settings keys, config entities, drush config |
| `plugins` | plugin types the module defines and how to implement one |
| `extend` | subclassing/decorating services, overriding behavior |
| `api` | services & public functions to call programmatically |
| `hooks` | hooks the module invites (`{name}.api.php`) |
| `drush` | Drush commands the module adds |
| `permissions` | permissions and what they gate |
| `theming` | templates, theme hooks, render elements |

**Golden rule:** each doc must cost fewer tokens to read than the source it summarizes.
If a module needs no configuration or has no plugins, don't create that doc.

### `screenshots/{name}/{version}/` (optional, OUTSIDE the repo)

Screenshots are binary build artifacts and are deliberately **not** committed to this repo.
They live one directory up from the repo, at the **project root**:
`<project-root>/screenshots/{name}/{version}/…png` (i.e. a sibling of
`agent-module-documentation/`, e.g. `/var/www/html/screenshots/pathauto/1.15.x/settings-form.png`),
mirroring the module path. Reference them from a solution doc with a relative link that
climbs out of the repo — a doc at `modules/{ab}/{name}/{version}/agent/{type}/` is seven
levels below the project root, so:
`![alt](../../../../../../../screenshots/{name}/{version}/name.png)`. These links resolve when
viewing locally (where the site is running); they are intentionally absent from the pushed
repo. How-to (and the container gotchas): [browser-screenshots.md](browser-screenshots.md).
Skip for modules with no UI.

## `security.md` (notable security findings, incidental, LOCAL-ONLY)

`modules/{ab}/{name}/{version}/security.md` is **git-ignored and never pushed** (`.gitignore` excludes
`**/security.md` but keeps `agent/**/security.md` solution docs). Written **incidentally** while reading
source (no formal audit), at a **moderate bar**: capture a real finding a security-conscious maintainer
would want flagged — an insecure shipped default (hardcoded/placeholder key, protection off by default),
an unauthenticated/low-priv SSRF/injection/access-bypass/CSRF-on-state-change, dangerous file/archive/
eval/unserialize handling, or credentials stored plaintext in config. Skip pure noise: dev-only tools,
by-design admin operations, "grant this carefully" advice, DoS, and trivial info-disclosure. Keep it to
a couple of code-grounded bullets; when unsure, a brief note is fine.

**Never leak a finding into the public docs.** `data.json`, `usage.md`, `agent/**` and `human-docs/**`
must not describe the weakness, hint that one exists ("see security.md", "a finding is recorded",
"verified live"), suggest the security fix, or tag it in `keywords`. Describe the module's behaviour
neutrally there; the finding itself lives only in `security.md` and goes through the Drupal Security
Team. Ordinary functional bugs and gotchas still belong in the public docs.

