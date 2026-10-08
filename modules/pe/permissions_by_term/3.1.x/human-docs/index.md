# Permissions by Term — manual setup guide

**Permissions by Term** (`permissions_by_term`) controls who may see content by
attaching allowed **users and roles to taxonomy terms**. Once a term is
restricted, any node that references it becomes visible only to the accounts and
roles you have granted that term. It is a flexible, content-driven way to build
members-only areas, department intranets, per-class school pages or per-client
project spaces — without writing custom access code or Views filters.

The restriction is thorough. Restricted nodes disappear from Views listings,
menus, search results and the `/admin/content` list for people who lack access,
not just from the node page itself. The module also filters the taxonomy term
options offered in editing widgets, so an editor cannot even select — or publish
into — a restricted section they are not allowed to use.

You manage grants in two places: a **Permissions** fieldset added to the taxonomy
term edit form (which users and roles may use this term), and a **Permissions →
Vocabularies** selector added to the user edit form (which terms this user may
access). A settings page lets you change the overall model — for example whether
users need *all* of a node's terms or just one, whether untagged content is
hidden by default, and which vocabularies the module manages.

An optional bundled submodule, **Permissions by Entity**
(`permissions_by_entity`), extends the same term-based grants to non-node
entities such as media or paragraphs.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant the permissions that expose the grant forms.
2. [Configuration](configuration/index.md) — the settings form, how to grant a
   term to users and roles, and the Drush rebuild command.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → Permissions by Term**
(`/admin/permissions-by-term/settings`). The grant controls themselves are not a
separate page — they appear as a **Permissions** section on each taxonomy term's
edit form and as a **Permissions → Vocabularies** section on each user's edit
form (subject to the module's own permissions).

## How to use it

The basic workflow is: decide which taxonomy terms should be restricted, then on
each of those terms' edit pages grant the users and roles who may access content
tagged with them. Tag your content with those terms as usual. From then on, only
the granted users and roles can see that content anywhere on the site. See
[Configuration](configuration/index.md) for the step-by-step, including the
site-wide options and how to rebuild access after bulk changes.
