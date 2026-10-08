# LocalGov Microsites Group — manual setup guide

**LocalGov Microsites Group** (`localgov_microsites_group`) turns Drupal's **Group**
module into a multi-tenant **microsites platform** for LocalGov Drupal. Each microsite
is a Group of the `microsite` type, bound to its own domain, with its own theme,
enabled feature modules, content types and members. It is the foundation on which a
council can run many small, self-contained sites from one Drupal install — each looking
and behaving like its own site, but managed centrally.

A microsite is created from an admin form, which seeds its default group content,
roles, and domain binding. From there, each microsite is configured through a
per-microsite settings form covering four areas: its **theme override**, its **site
settings** (name, email and so on), which **content types** are enabled, and its
**domain** binding. A context system maps the active domain to its owning Group, so
visitors and editors always land in the right microsite, and a theme negotiator applies
each microsite's chosen theme.

Access is layered on top of the Group module's permission system, with LocalGov adding
its own global and per-group permissions — and the `localgov_microsites_permissions`
submodule lets a microsite administrator manage their own group's permissions. A range
of content submodules (blogs, news, events, guides, directories, publications,
step-by-step, webforms, taxonomy UI) add per-microsite content and features.

This module is the core of the LocalGov Microsites distribution and pulls in a sizeable
stack of dependencies (Group, Domain, and several supporting modules). It is meant to
run as part of that platform rather than as a standalone add-on.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable it
   and its large dependency stack, and choose the content submodules you need.
2. [Configuration](configuration/index.md) — create a microsite, configure its
   per-microsite settings, and understand the permissions model.

## Where it lives in the admin menu

The module does not expose a single classic settings page (`configure` is `null`);
instead it adds several routes:

- **Add a microsite** — `/admin/microsites/add/{group_type}`, gated by Group's entity
  create-access.
- **Microsites overview / current microsite admin** — `/admin/microsite`, which
  resolves to the current microsite from the active domain/group context (requires the
  *access microsites overview* permission).
- **Per-microsite settings** — `/group/{group}/domain-settings`, the design/site/
  content-type/domain settings form for a single microsite.

## How to use it

1. Install and enable the module, its dependency stack, and the content submodules you
   want (see [Installation](installation/index.md)).
2. Create a microsite from `/admin/microsites/add/{group_type}`, which sets up its
   default content, roles and domain.
3. Configure the microsite from its `/group/{group}/domain-settings` form — theme,
   site settings, enabled content types, and domain (see
   [Configuration](configuration/index.md)).
4. Add members and assign roles (using ginvite and role delegation, which come with the
   platform), and toggle feature modules per microsite.
