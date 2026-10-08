# Droost — manual setup guide

**Droost** (`droost`) is a local‑development toolkit that lets an AI coding agent
ask your Drupal site about itself — and then build on it deterministically. It's
the Drupal analog of Laravel Boost. Agents writing Drupal code normally work
blind: they don't know which modules and versions are installed, what entity
types and fields exist, which service to inject instead of calling `\Drupal::`,
or whether the last request errored. Droost exposes all of that as
schema‑described **MCP** (Model Context Protocol) tools returning structured
JSON, so the agent gets reliable, version‑correct answers about the real site
instead of guessing.

Beyond read‑only introspection, Droost also offers tiered, individually gated
**write** tools and a "work pipeline" (plan → code → test → document → complete)
whose gates are backed by real quality tools. It's built entirely on the **MCP
Server** module (its only dependency), which provides the runtime and the tool
plugin system; Droost provides the tools.

**Read this before you install: Droost is local‑development‑only.** It is in the
same class as `devel`, `devel_php`, and `webprofiler` — it deliberately exposes
your application, can run raw SQL, and (when you opt in) arbitrary PHP. The gates
it provides reduce footguns; they are **not** a security boundary against an
untrusted caller. Enabling it on a production or internet‑reachable site means
accepting the risk of remote code execution and data exposure. Install it with
`--dev`, run it only on local and trusted development environments, treat its
permissions as highly sensitive, and keep the MCP endpoint bound to local/trusted
access.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install as a dev dependency, enable it,
   and wire it to your coding agent.

Droost is configured from the command line and a repo‑root `droost.workflow.yml`
file (deliberately a file, not Drupal config, so an agent and the CLI can read it
with no running site) rather than through an admin settings form — so there is no
separate configuration page here. Its setup and workflow are described in "How to
use it" below.

## Where it lives in the admin menu

Droost has no user‑facing admin UI to speak of. It registers MCP tools through the
MCP Server module and is driven by `drush droost:*` commands and guided slash
commands in your AI coding agent. It provides its own permissions on **People →
Permissions** — treat them as highly sensitive.

## How to use it

1. Install Droost and MCP Server as **dev** dependencies and enable Droost (see
   [Installation](installation/index.md)).
2. Run the setup command to register the MCP server with your agent harness and
   write an `AGENTS.md` block pointing the agent at this site:

   ```bash
   drush droost:install --harness=claude   # or codex, gemini, qwen, opencode, all
   ```

   This step is reversible.
3. Ask your agent: *"Ask Droost what this site knows about itself."*
4. Optionally let the agent drive setup with the shipped guided slash commands —
   `/droost-init` (first wiring and verification), `/droost-configure`
   (profiles, write gates, embedding backend, workflow levers), and
   `/droost-upgrade` (walks the shipped upgrade bulletins in order).
5. Use the **Droost Workflow** pack via `/droost-work` to move each change through
   plan → code → test → document → complete, gated by real quality tools. The
   levers live in `droost.workflow.yml` at the repo root, with `enforcement`
   set to `hard`, `soft`, or `off`.

> **Never** enable Droost on a production or internet‑facing site.
