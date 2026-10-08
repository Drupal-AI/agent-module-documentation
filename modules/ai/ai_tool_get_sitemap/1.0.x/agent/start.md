<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Tool: Get Sitemap (ai_tool_get_sitemap) — agent index

One AI Agents **tool plugin** that returns the site's own XML sitemap (from Simple XML Sitemap)
so an agent can process it. Package `AI Tools`. Depends on modules `ai` and `tool`; needs
`drupal/simple_sitemap` ^4 for the sitemap data. Core `^10 || ^11`. PHP `>=8.2`. License
GPL-2.0-or-later. Version 1.0.3.

- **The tool plugin, what it returns, access, and operating notes** →
  [plugins/get_sitemap.md](plugins/get_sitemap.md)

## What it actually is

- One plugin: `GetSitemap` (id **`ai_tool_get_sitemap`**, label *"Get Sitemap"*) in
  `src/Plugin/tool/Tool/GetSitemap.php`, extending `Drupal\tool\Tool\ToolBase` and implementing
  `ContainerFactoryPluginInterface`. Declared via the `#[Tool(...)]` attribute with
  `operation: ToolOperation::Read` and one output, `sitemap` (a `map`).
- **No routes, no permissions, no config objects, no schema, no Drush, no hooks, no submodules.**
  The whole module is this one plugin plus `.info.yml`/`composer.json`.

## Mechanism (from source)

- `create()` injects `current_user` and, only if the container `has('simple_sitemap.generator')`,
  the `simple_sitemap.generator` service; otherwise the generator is left NULL.
- `doExecute($values)` **ignores its arguments** — it takes no tool input. It calls
  `$this->simpleSitemapGenerator->getDefaultSitemap()`, then `setSitemaps($variant)`,
  `getContent()` (the generated XML string) and `getDefaultSitemap()->getLinkCount()`. If the
  link count is non-zero it returns `ExecutableResult::success(...)` with `sitemap`/`result` set
  to `[$xmlContent]`; otherwise `ExecutableResult::failure(...)` telling the operator to install
  Simple XML Sitemap.
- It reads the **locally generated** sitemap through the Simple Sitemap service. It does **not**
  fetch any URL, open a socket, or parse remote XML — the XML string is passed straight through.
- `checkAccess()` returns `AccessResult::allowed()` / `TRUE` unconditionally; gating relies on the
  surrounding AI-agent/Tool framework and the (public) nature of a sitemap.

## Caveat

- If Simple XML Sitemap is not installed the injected generator is NULL, so `doExecute()`'s first
  call would error rather than fall through to its "please install" message — install and
  configure `drupal/simple_sitemap` before enabling the tool for an agent.
