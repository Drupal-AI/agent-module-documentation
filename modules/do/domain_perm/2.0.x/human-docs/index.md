# Domain Permissions — manual setup guide

**Domain Permissions** (`domain_perm`) is a security-hardening feature for
multi-domain sites: it dynamically **strips a user's roles whenever they are
browsing a non-edit domain**, so authoring and administration capabilities only
exist on a designated "edit" domain. It sits alongside the **Domain** ecosystem
conceptually, though notably it lists no module dependencies of its own.

The idea is to confine the editorial surface to a separate host. Say your site
serves the public at `www.example.com` and editors work at `edit.example.com`. On
any domain other than the edit domain, this module overrides Drupal core's
`UserRolesAccessPolicy` so that a user's granted roles are dynamically dropped,
leaving them with only the *exempt* roles (by default `anonymous` and
`authenticated`). The upshot: even if an editor's session is somehow active on the
public host, it carries no privileged roles there, shrinking the attack surface of
the public domain.

Understand its scope before relying on it. This is **defence-in-depth built on
Drupal's access-policy layer**, not a replacement for core permission and role
management. Its effectiveness depends on correct domain configuration, on the edit
and public domains being genuinely separate, on trusted host resolution, and on
the exempt-roles setting being what you intend. It does not work purely on
enable — you need to designate the edit domain and review the exempt roles.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Note:** this module's releases are not covered by Drupal's security advisory
> policy. Weigh that when deciding whether to depend on it for a hardening
> control.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is no dedicated settings page documented for this module — configuration is
handled through its settings (the edit domain and the list of exempt roles), as
described under "How the access model works" below and in the project's
`README.md`.

## How the access model works

- On the **edit domain**, users keep all their normal roles and permissions, so
  authoring and administration work as usual.
- On **every other domain**, the module removes the user's roles, leaving only the
  **exempt roles**. The default exempt set is `anonymous` and `authenticated`,
  configured through the `domain_perm_roles_exempt` setting — add any role here
  that must retain its capabilities everywhere.
- Because the stripping happens at the access-policy layer, it applies
  consistently across the request rather than being bolted onto individual checks.

Consult the module's `README.md` on the
[project page](https://www.drupal.org/project/domain_perm) for the exact way to
designate the edit domain and adjust the exempt-role list on your version, then
verify the behaviour by logging in on both an edit and a non-edit domain.
