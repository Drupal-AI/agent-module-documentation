# Alien Alias — manual setup guide

**Alien Alias** (`alien_alias`) lets you create tidy internal paths on your own
site that automatically redirect visitors to **external** URLs. For example, you
could make `/docs` on your site send people to a documentation site hosted
elsewhere. Each redirect is stored as an "alien alias" entity that you create and
manage in the admin UI.

Under the hood it resolves these redirects very early in the request — a kernel
event subscriber matches the incoming path and, for a matching alias, issues a
trusted redirect to the configured external URL. This early handling keeps the
response fast. You can append query parameters to the target, and the module
records access statistics for each alias. A "fast response" setting controls
whether this early handling is used.

Because these aliases send visitors off to administrator-configured external
sites, the module ships granular permissions (add, edit, delete, view, and a
restricted administer permission) so you can control exactly who may create and
manage them. Only trusted users should be able to add or edit aliases, since they
define where visitors get sent.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and assign the alias permissions.

## Where it lives in the admin menu

Alien Alias is managed through its alias entities — you add, edit, and delete
alien alias entities in the admin UI, and its permissions appear on **People →
Permissions**. It has no separate global settings page.

## How to use it

1. Enable the module and grant the appropriate alien-alias permissions to trusted
   roles.
2. Create an alien alias entity: give it the internal path visitors will use and
   the external URL they should be redirected to (optionally with query
   parameters appended).
3. Visit the internal path — the module redirects to the external target. You can
   review access statistics per alias, and toggle the fast-response behaviour via
   its setting.
