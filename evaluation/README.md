# Evaluation — does the `drupal-module-docs` skill help?

We measure, per module task: **is it solved correctly**, **how many tokens**, **how long**,
and **how much $** — for the matrix **{vanilla, +skill} × {claude, codex, gemini}**.

## Can we reuse the ai_best_practices eval system? — Yes, mostly.

`drupal/ai_best_practices` (installed at `vendor/drupal/ai_best_practices/evals/`) already
ships a solid harness, and we reuse it rather than reinventing:

- **`evals/providers.py`** — provider-agnostic CLI runners (`claude`, `codex`, `gemini`)
  that return `{response, elapsed, input_tokens, output_tokens, cost_usd, ...}`. This is
  the hard part (token/cost/time capture) and we import it directly.
- **`evals.json` format** — each case has `prompt`, `expected_output`, and text assertions
  (`must_contain_any`, `must_not_contain`, `check_php_lint`). Our per-module `eval/evals.json`
  files use this shape.
- **`evals/compare.py` A/B method** — baseline vs skill by prepending the skill text to the
  prompt, identical flags per arm. We follow the same design.

**The one gap:** that harness grades the model's **response text**. It never runs the task
against a live site, so it cannot answer *"did the pathauto pattern actually get created and
does a new node get the right URL?"* — which is exactly what you asked for.

**What we added** (thin layer, in `run-matrix.py`):
1. A claude runner that executes tools unattended (`--dangerously-skip-permissions`,
   `cwd` = project root) so the agent can actually run `drush` and mutate the site.
2. **Live-state verification** for `mode: execution` cases: run the case's `reset` script,
   let the agent work, then run its `verify` script against the real site (exit 0 = correct).

So each `evals.json` case carries a **`difficulty`** tier, and each tier maps to a `mode`.
Every benchmarked module should have **2-3 cases of each tier**:

- **easy → `mode: "recipe"`** — answer a question out of the box, graded on response text
  (reuses ai_best_practices grading). Cheap, CI-safe, no site mutation. "What's the command
  / the config key / the plugin type?"
- **medium → `mode: "introspection"`** — answer a question about the *current setup*. A
  `setup` script first saves a known configuration to the live site; the agent must inspect
  the running site (drush) to answer; graded on response text; a `cleanup` script then
  restores baseline. "This site already has X configured — what is its value / which pattern
  applies here?" Tests whether the agent knows *where to look* on a live site.
- **hard → `mode: "execution"`** — the agent must actually perform the change. A `reset`
  script clears state, the agent builds the config or codes the plugin, and a `verify` script
  checks live state (exit 0 = correct). This is the pathauto "set it up, then check it was set
  up" case.

Case fields by tier:

| Field | easy (recipe) | medium (introspection) | hard (execution) |
|---|---|---|---|
| `mode` | `recipe` | `introspection` | `execution` |
| `difficulty` | `easy` | `medium` | `hard` |
| `prompt` | ✓ | ✓ | ✓ |
| `must_contain_any` / `must_not_contain` | ✓ (grading) | ✓ (grading) | — |
| `setup` | — | ✓ (installs the config to read back) | — |
| `cleanup` | — | ✓ (restores baseline after) | optional |
| `reset` | — | — | ✓ (clears state before) |
| `verify` | — | — | ✓ (live-state check, exit 0 = pass) |
| `persona` | optional | optional | optional |

Script paths (`setup`/`cleanup`/`reset`/`verify`) are relative to the project root
(`/var/www/html`) and live in `evaluation/verify/`.

## Layout

```
evaluation/
├── README.md            # this file
├── run-matrix.py        # the runner (reuses vendor providers.py; adds exec + verify)
└── verify/              # live-state check + reset scripts referenced by execution cases
    ├── pathauto-blog-pattern.sh
    └── pathauto-reset.sh
modules/<name>/<version>/eval/
├── evals.json           # suggested tasks for this module (recipe + execution)
└── results.json         # accumulated results, all runs (written by run-matrix.py)
```

### `results.json` shape

One file per eval dir, **accumulated across runs** — each run upserts only its own
leaves, so different arms, models, and efforts coexist for later graphing:

```
{ module, version, skill_name,
  cases: {
    "<case_id>": {
      type,                         # "recipe" | "introspection" | "execution"
      difficulty?,                  # "easy" | "medium" | "hard"
      question,                     # the prompt
      persona?,                     # optional
      results: {
        "<arm>": {                  # vanilla | skill | memory
          "<model>:<effort>": {     # e.g. "claude-opus-4-8:medium", "claude-haiku-4-5-20251001:medium"
            provider, model, effort, runs,
            correct,                # integer count of passing runs (denominator = runs)
            in_tokens, cache_reads, out_tokens, time, cost
          }
        }
      }
    }
  }
}
```

`correct` is an integer (the pass count); reconstruct `x/y` as `correct/runs`.
`cache_reads` may be `null` for older runs that predate that column. The leaf key is
`model:effort` so opus and haiku never overwrite each other.

## Running

```bash
# one case, both arms, claude only (the pathauto setup example):
python3 agent-module-documentation/evaluation/run-matrix.py \
    --module pathauto --version 1.15.x --only pathauto-blog-pattern --arms vanilla skill

# whole module, add providers as their CLIs become available:
python3 agent-module-documentation/evaluation/run-matrix.py \
    --module token --version 1.17.x --providers claude codex gemini --runs 3

# see the exact prompts without spending anything:
python3 .../run-matrix.py --module pathauto --version 1.15.x --dry-run
```

Results are written (and accumulated) into `modules/<name>/<version>/eval/results.json`.

## Reading the results

Each leaf in `results.json` carries these fields (a visualizer reads them directly):

| Field | Meaning |
|---|---|
| arm (key) | `vanilla` = bare prompt; `skill` = prompt with `drupal-module-docs` SKILL.md prepended; `memory` = distilled docs already in context |
| `correct` | integer pass count over `runs` (execution: live-state verify; recipe: text assertions) — reconstruct `x/y` as `correct/runs` |
| `in_tokens` | **fresh** (uncached) input tokens, averaged over `runs` |
| `cache_reads` | cached input tokens **re-used** (priced at ~0.1×) — a big stable prefix (skill/memory) becomes mostly cache-reads after turn 1; `null` for older runs |
| `out_tokens` | output tokens — **never cached**, always full price; this is where the real arm-to-arm differences live |
| `time` | wall-clock seconds per case |
| `cost` | provider-reported (claude `total_cost_usd`) — **already cache-aware** (reads ~0.1×, writes ~1.25×); the honest bottom line |

Caching note: a skill/memory prefix is identical across the runs of an arm, so within a
multi-turn run it is cached after turn 1 (cheap re-reads), and Claude's `total_cost_usd`
prices that in. But the differences that decided our results were in **output** tokens
(e.g. vanilla flailing to 8344 out-tokens on a task the skill did in 2092) — and output is
never cacheable, so caching does not change those conclusions.

**The hypothesis the skill should prove:** same-or-better *Correct* at **fewer tokens and
less time** than vanilla — because reading `agent/start.md` + one solution doc is cheaper
than the agent grepping `web/modules/contrib/<name>/src`.

### Persona variants (`-layman` / `-expert`)

Execution cases can carry a `persona` and come in pairs that share one `verify`: the same
task phrased **once how a non-technical site owner would ask** (no Drupal jargon — "make my
blog post URLs read /blog/the-title") and **once how a Drupal developer would ask** ("add a
Pathauto pattern `blog/[node:title]` for the Article type"). A robust skill should solve
both and land on the same verified end state. Compare the `-layman` vs `-expert` rows to see
whether plain-English requests cost the agent more exploration.

### What the first runs show (token + pathauto, well-known modules)

Correctness was 3/3 for **both** arms on every case — these two modules are small and
familiar, so the skill is not needed for *correctness* here. The differentiator is
cost/time, and it is **task-dependent**: on obvious tasks the skill adds overhead (it reads
a doc vanilla didn't need), but on the more obscure API surface (e.g. token's entity-type →
token-type mapper) the skill roughly halved tokens and time. Expect the skill's advantage to
grow on **larger or less familiar modules** the model doesn't already know — the next
documented modules are the real test.

## Caveats / honesty

- **Isolation:** both arms run with `--setting-sources ''` so the project's skills do **not**
  auto-load; the skill reaches the model only via prompt injection in the `skill` arm. This
  keeps the A/B clean (the sole variable is the skill text). Note that `--setting-sources ''`
  also means a default model set in `settings.json` does **not** apply — the model comes from
  the `--model` flag (below), not your settings.
- **Model & effort:** the claude provider defaults to `--model claude-opus-4-8` at
  `--effort medium`. Override with `--model`/`--effort`; both are recorded per leaf (the
  `model:effort` run key and its `provider`/`model`/`effort` fields) in results.json.
  `--effort` applies to the claude provider only (codex/gemini keep their own default
  models and ignore it).
- **Non-determinism:** agents vary run-to-run. Use `--runs 3+` for stable cells.
- **codex/gemini:** rows show `n/a` until those CLIs are installed; the harness already
  supports them (via the reused `providers.py`).
- **Execution cases mutate the site** (patterns, a throwaway node). `reset` runs before each
  attempt; if the site ever breaks, `drush site:install -y` restores it.
