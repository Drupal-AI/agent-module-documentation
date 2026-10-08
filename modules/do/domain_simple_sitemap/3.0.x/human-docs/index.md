# Domain Access Simple Sitemap — manual setup guide

**Domain Access Simple Sitemap** (`domain_simple_sitemap`) is the glue between two
popular modules: **Simple XML Sitemap** and **Domain Access**. On a multi‑domain
site, a single shared sitemap is wrong — each domain should advertise its own set
of URLs. This module makes that happen by giving every Domain its own sitemap
*variant*, so each domain serves a correct `sitemap.xml` containing only the
content that belongs to it.

The best part is that it's mostly automatic. When you add a new Domain, the module
creates a matching sitemap variant for it; when you delete a Domain, its variant
is removed. Each variant is wired to Domain Access's `domain_entity` URL generator
so the links use the right host, and it's tagged with the domain it belongs to. If
you install this on a site that *already* has domains, a single button on the
settings page bulk‑creates variants for all of them.

Once the variants exist, you keep working in Simple XML Sitemap as usual: enable
indexing per content type against each domain's variant, then rebuild. There's no
separate publishing step here — the module just ensures the right per‑domain
structure is in place. It depends on both the **Simple XML Sitemap**
(`simple_sitemap`) and **Domain Access** (`domain_access`) modules.

Its own settings page is small: two toggles that control how each domain's sitemap
is filtered and whether front‑page URLs get rewritten to the clean domain base
URL. Everything else is handled through the standard Simple XML Sitemap and Domain
Access screens.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Simple XML Sitemap and Domain Access.
2. [Configuration](configuration/index.md) — the settings page and the two
   toggles, plus the "Generate variants" button and the end‑to‑end setup.

## Where it lives in the admin menu

Its settings form is at **Configuration → Domain → Domain Access Simple Sitemap**
(`/admin/config/domain/domain_simple_sitemap/config`), and it uses Domain Access's
**Administer domains** permission (it defines no permission of its own). You'll
review the resulting sitemap variants on the Simple XML Sitemap screen at
**Configuration → Search and metadata → Simple XML Sitemap**.

## How to use it

1. With Domains already defined, either add your domains (new ones get a variant
   automatically) or click **Generate domain's sitemap variants** on the settings
   page to create variants for existing domains.
2. In **Simple XML Sitemap** settings, enable indexing for each content type
   against the appropriate domain variant.
3. Run Simple XML Sitemap's **Rebuild queue & generate**.
4. Each domain then serves its own sitemap at `<domain>/sitemap.xml`.
