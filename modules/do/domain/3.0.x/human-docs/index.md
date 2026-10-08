# Domain — manual setup guide

**Domain** (`domain`), often called Domain Access, lets a single Drupal
installation answer to many hostnames from one codebase and database. Each
hostname you register becomes a **domain record**, and on every request the module
works out which domain is "active" by matching the incoming hostname. This is how
you run several branded sites — say `example.com`, `example.org`, and
`example.net` — from one Drupal site.

The core `domain` module deliberately does one thing: it creates and negotiates
domain records. A domain record holds a machine name, a hostname, a human-readable
name, a scheme (http, https, or "inherit"), a status (active/inactive), a weight
for ordering, a default flag, and an optional URL path prefix. When a request
comes in, the domain negotiator compares the HTTP host to your registered
hostnames — handling exact matches, www-prefix variants, and aliases — and falls
back to the default domain if nothing matches. The very first domain you create is
automatically marked as the default.

Almost everything else you'll want in a multi-domain site is provided by the
module's **submodules**, which you enable as needed on top of the base module.
Domain also ships blocks (a domain navigation block and a switcher block), a
domain condition plugin for showing blocks per domain, Views integration, tokens,
and a cache context so cached output can vary per active domain. It provides Drush
commands for managing domains from the command line and a rich set of permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## The submodule suite

The base module registers and negotiates domains; these submodules add the
features most multi-domain sites need. Enable only the ones you want:

| Submodule | What it adds |
|---|---|
| **Domain Access** (`domain_access`) | Per-domain content and user access control — adds domain fields to content and gates who can see and edit it by domain. |
| **Domain Source** (`domain_source`) | Assigns each content item a canonical source domain and rewrites its outbound URLs to that domain. |
| **Domain Config** (`domain_config`) | Domain- (and language-) specific configuration overrides — e.g. a different site name or theme per domain. |
| **Domain Config UI** (`domain_config_ui`) | The admin UI for saving the per-domain config overrides that Domain Config stores. |
| **Domain Alias** (`domain_alias`) | Maps multiple host patterns (aliases, wildcards, www/non-www, environment variants) onto a single domain record. |
| **Domain Content** (`domain_content`) | Per-domain content administration views so editors can review and manage content by assigned domain. |

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module, and pick the submodules you need.
2. [Configuration](configuration/index.md) — create and manage domain records, the
   global settings, the Drush commands, and the permissions.

## Where it lives in the admin menu

Domain records are managed at **Configuration → Domain**
(`/admin/config/domain`), and the global settings at **Configuration → Domain →
Settings** (`/admin/config/domain/settings`).

## How to use it

1. Enable the base module (and any submodules you need).
2. At **Configuration → Domain**, add a domain record for each hostname the site
   should answer to. The first one you add becomes the default.
3. Point those hostnames at your server (DNS / virtual hosts) so the requests
   actually reach Drupal.
4. Enable submodules such as Domain Access or Domain Config to control content and
   configuration per domain (see [Configuration](configuration/index.md)).
