# Installation

> **Local development only.** Droost deliberately exposes your application, can run
> raw SQL, and — when you opt in — arbitrary PHP. Install it as a **dev**
> dependency and enable it only on local and trusted development environments.
> Never install or run it on a production or internet‑reachable site.

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- The **MCP Server** module (`mcp_server`) — Droost is built on it and cannot work
  without it.
- An AI coding agent / harness you want to wire up (Claude, Codex, Gemini, Qwen,
  OpenCode, etc.).

## Install with Composer (as a dev dependency)

From the project root, install Droost **and** MCP Server as dev requirements:

```bash
composer require --dev 'drupal/droost:^1.0@rc' 'drupal/mcp_server:^2.0@alpha'
```

Using `--dev` keeps these tools out of your production dependencies — which is
exactly where they must never run.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require --dev …`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

> If Composer refuses to install because of an `mcp/sdk` security advisory, the
> module's `KNOWN_LIMITATIONS.md` (item #6) documents a one‑command workaround
> until the next MCP Server release.

## Enable the module

```bash
drush en droost -y
```

## Wire it to your coding agent

Register the MCP server with your agent harness and write an `AGENTS.md` block
that points the agent at this site:

```bash
drush droost:install --harness=claude   # or codex, gemini, qwen, opencode, all
```

This command is reversible. It also installs three guided slash commands
(`/droost-init`, `/droost-configure`, `/droost-upgrade`) and the Droost Workflow
pack, and writes a `droost.workflow.yml` file at your repo root, sized to your
project layout.

## Verify it worked

1. Confirm Droost is enabled at **Extend** (`/admin/modules`) — on a local
   environment only.
2. After running `drush droost:install`, ask your agent: *"Ask Droost what this
   site knows about itself."* A useful, structured answer means the wiring worked.
3. Confirm a `droost.workflow.yml` file now exists at your repo root.
