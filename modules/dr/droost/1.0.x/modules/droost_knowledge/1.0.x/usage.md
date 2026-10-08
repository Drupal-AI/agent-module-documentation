<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Droost Knowledge is the version-keyed Drupal knowledge pack (Tier 0): offline, served facts for building on any Drupal site — site-planning grounding plus a shipped deprecation ledger with a lookup MCP tool.

---

Droost Knowledge ships the always-true, version-keyed Drupal facts that Droost serves to agents with zero network. It has three payloads. First, a site-planning guideline topic (`guidelines/topics/site-planning.md`) — the construct vocabulary, field-storage reuse, and ships-disabled components — which the base module's `GuidelineProvider` discovers and the `droost_guidelines` MCP tool serves. Second, a shipped, version-keyed deprecation ledger (`data/deprecations/<major>.json`): the `DeprecationLedger` service lazy-loads the running core major's dataset (deriving the major from `\Drupal::VERSION` via `GuidelineProvider::deriveMajor()`) and answers exact lookups and substring searches offline; a missing or malformed file yields an empty ledger whose stats say so, never an error. One read-only MCP tool, `droost_deprecations`, exposes it: pass `symbol` for an exact match (function/method/class/constant/hook), `search` for a substring, or no argument for ledger stats — returning "deprecated in X, removed in Y, replacement, change-record URL". Third, a brain-seed dataset (`data/brain-seed/<major>.yml`) that `droost_knowledge_install()` uses to bootstrap `droost_brain` before its first build (guarded so it never clobbers an already-harvested brain). A maintainer-side Drush command, `droost:knowledge:etl` (alias `dket`), regenerates the ledger from the installed core tree (using `nikic/php-parser`, a dev dependency) and writes only under `droost_knowledge/data/`; adopters ship the committed dataset and never run it. The module has no config schema or permissions and depends only on `droost`; the deprecations tool is gated behind mcp_server's `access mcp server` permission. Local development only.

---

- Look up whether a Drupal core symbol is deprecated, offline, with `droost_deprecations`.
- Get "deprecated in X, removed in Y, use Z, change-record URL" for a function/method/class/constant/hook.
- Exact-match a symbol (`symbol: "hide"` or `symbol: "Drupal\\Core\\X::y"`).
- Substring-search the ledger (`search: "entity"`) to find related deprecations.
- Read ledger stats (row count, core major, schema, core version) with no arguments.
- Serve the `site-planning` guideline topic to an agent via the base `droost_guidelines` tool.
- Ground an agent in the construct vocabulary, field-storage reuse and ships-disabled components before it plans a site.
- Answer deprecation questions with zero network (fully offline, from the shipped JSON dataset).
- Bootstrap the droost_brain project brain from the shipped brain-seed before its first `drush dbb`.
- Complement `droost_verify`'s deprecation scan: the scan finds violations, this explains and predicts them.
- Regenerate the ledger per core major at release time (maintainer) with `drush droost:knowledge:etl`.
- Keep deprecation knowledge version-correct (the ledger is keyed to the running core major).
- Degrade gracefully: an absent or malformed dataset yields an empty-but-honest ledger, never a fatal.
- Enable it wherever agents plan and build (the droost_cms recipe enables it by default).
