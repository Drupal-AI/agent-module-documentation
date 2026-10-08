# Installation

## Requirements

- **Drupal 10.6 or 11** (`core_version_requirement: ^10.6 || ^11`).
- The stack MCP Sentinel builds its guarantees on, all pulled in by Composer:
  - **Audit Chain** (`audit_chain`) — the tamper‑evident, hash‑chained audit trail.
  - **Key** (`key`) — for the HMAC signing key and other secrets.
  - **Encrypt** (`encrypt`) — for protecting data at rest.
  - **Simple OAuth** (`simple_oauth`) and **Consumers** (`consumers`) — for
    authenticating agent access.
  - **Tool** (`tool`) and core **JSON:API** (`jsonapi`).
- It is designed to sit in front of **MCP Server** and the **Tool API**, which
  provide the endpoint and tools it governs.

Note this module is **not covered by Drupal's security advisory policy** — review it
carefully before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/mcp_sentinel -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Audit Chain, Key,
Encrypt, Simple OAuth, Consumers, Tool, and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mcp_sentinel -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mcp_sentinel -y
```

## Verify it worked

After enabling, open MCP Sentinel's admin UI under **Configuration → Web services**
and confirm the settings form and the shipped **default** policy profile are present.
Because governance only applies to the validated OAuth agent channel, a full test
involves an agent request: confirm that redaction, gates, and the audit log behave as
your policy profile dictates, and run `drush mcp-sentinel:role-audit` to check that no
governed role holds a forbidden permission. See
[Configuration](../configuration/index.md) for the details.
