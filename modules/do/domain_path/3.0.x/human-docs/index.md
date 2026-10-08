# Domain Path — manual setup guide

**Domain Path** (`domain_path`) gives a piece of content a **different URL alias on
each domain** of a multi‑domain Drupal site. Core lets an entity have one alias per
language; Domain Path adds a per‑domain alias on top of that, so the same node can
live at `/products/widget` on one domain and `/widget` on another. It is built for
sites running the **Domain** module (Domain Access / Domain Source), where several
branded domains are served from one Drupal install.

Once enabled, entity edit forms (nodes by default) gain a *Domain‑specific aliases*
section — one alias field per domain, shown in the advanced sidebar. When you fill
one in, the module stores it as an ordinary `path_alias` entity tagged with the
domain it belongs to; clear it and the alias is deleted. On the front end, when a
link is generated for a particular domain, Domain Path resolves that domain's alias,
falling back to the default alias when a domain has no specific one.

If you also run **Domain Access**, editors only see and can only set aliases for the
domains they are assigned to, and aliases are only written for domains the content
actually belongs to. An optional submodule, **Domain Path Pathauto**, adds automatic
per‑domain alias generation when you have Pathauto installed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, the Domain
   dependency, enabling the module, and the optional Pathauto submodule.
2. [Configuration](configuration/index.md) — the settings form: which entity types
   get domain aliases, how domains are labelled, hiding core's alias field, and
   language handling.

## Where it lives in the admin menu

The settings form is at **Configuration → Domain → Domain Path**
(`/admin/config/domain/domain_path`), gated by the **Administer domain paths**
permission (`administer domain paths`). The per‑content aliases themselves are
edited directly on each entity's add/edit form, in the *Domain‑specific aliases*
section.
