AI Drush Tools provides Drush commands for checking Drupal module upgrade compatibility and inspecting Drupal.org project health, with optional AI-generated commentary on top of deterministic ecosystem lookups.

---

The module ships five Drush commands and no UI, routes, permissions, or configuration objects. `ai:module-check` (and `ai:module-check-list` for a file of modules) reports whether a core or contrib module is compatible with the next major Drupal version — core modules resolve from a built-in registry, contrib modules are looked up via Packagist with a Drupal.org update-feed fallback. `ai:project-info` fetches Drupal.org project metadata: releases, usage by branch, maintainers, issue-queue summaries, and security-advisory coverage. The deterministic work runs in a bundled Python checker (`scripts/drupal_module_checker`) invoked as a subprocess. Every command has an optional `--enrich-with-ai` flag that adds LLM commentary; the model call is routed through a pluggable backend layer (`src/Ai/`) that can use the `drupal/ai` module, a LiteLLM proxy, a Python LiteLLM subprocess, or host-native AI CLIs (Claude, Codex, OpenCode) either directly on `PATH` or via a DDEV host bridge. `ai:setup` runs a wizard that writes backend/model/proxy/bridge defaults into `drush.yml`, and `ai:setup:bridge` installs the DDEV host-bridge helper scripts. AI is always additive and never required — the checks are fully useful without any provider configured.

---

- Check whether a contrib module is ready for the next major core version: `drush ai:module-check token --from=10`.
- Check a core module that may have been moved to contrib or removed: `drush ai:module-check book --from=10`.
- Batch-check an upgrade inventory from a file, one module per line: `drush ai:module-check-list modules.txt --from=10`.
- Get a machine-readable upgrade report for scripting with `--format=json`.
- Inspect a Drupal.org project's release and health signals before adopting it: `drush ai:project-info pathauto`.
- Render a detailed vertical project report with `drush ai:project-info condition_field --detail`.
- Report usage for one specific release branch: `drush ai:project-info condition_field --usage-version=2.0.x`.
- Include or suppress issue-queue summary data with `--include-issues=summary|none`.
- Run all deterministic checks with no AI provider configured at all — commentary is optional.
- Add expert AI migration commentary to any check with `--enrich-with-ai`.
- Preview exactly what would be sent to the model without spending tokens using `--ai-dry-run`.
- Feed project context (AGENTS.md / CLAUDE.md) into the AI prompt automatically, or point at one with `--project-context`.
- Pass extra AI instructions inline or from a file with `--ai-prompt "…"` / `--ai-prompt @notes.md`.
- Route AI through the site's `drupal/ai` provider automatically when that module is installed.
- Use a LiteLLM proxy directly from PHP without `drupal/ai`: `--litellm-proxy=http://localhost:8000/v1`.
- Use a host-native AI CLI from inside DDEV via the host bridge: `--ai-backend=claude-host --host-bridge-url=http://host.docker.internal:4141`.
- Pin a specific backend and model per invocation with `--ai-backend` and `--ai-model`.
- Configure durable AI defaults once with the `drush ai:setup` wizard so later commands need no flags.
- Install the DDEV host-bridge helpers for host-native Claude/Codex/OpenCode workflows with `drush ai:setup:bridge`.
- Integrate upgrade checks into CI to flag modules blocking a major-version bump.
- Build an adoption/maintenance-risk shortlist by combining `ai:project-info` output across candidate modules.
- Provide a Python-LiteLLM fallback for AI commentary on hosts without `drupal/ai`, driven by `LLM_MODEL` + provider API-key env vars.
