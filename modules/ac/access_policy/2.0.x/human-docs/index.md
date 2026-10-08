# Access Policy — manual setup guide

**Access Policy** (`access_policy`) decides who may view or edit an entity by
combining reusable **access rules** into named **policies** that an author can
assign to a specific piece of content. It moves per-item access out of role
permissions and into something an editor can apply to one document, page or
record.

Drupal's built-in permission system is role-based and site-wide: a role either may
edit articles or may not. Real editorial needs are often narrower — *this*
document is for the finance team, *that* page is restricted until launch, *this*
record belongs to one department. The usual answers are Group (heavy, based on
membership) or a node-access module with fixed behaviour. Access Policy takes a
third position: an administrator defines rules and assembles them into policies as
configuration, and an author with the right permission then assigns a policy to an
entity from an **Access** tab on that entity.

The permissions are deliberately layered, and the layering is the whole point.
**Administer access policy entities** (marked as a restricted permission) lets you
define policies. **Set entity access policy** lets an author use the Access tab.
On top of that, each policy gets its *own* per-policy permission, generated
automatically — so being able to assign one *particular* policy is separately
grantable. That is what stops an author applying a restriction they should not
control.

Both the rules and the underlying handlers are pluggable, so developers can add
custom access rules. One caveat worth knowing before you rely on it: as with any
entity-access module, verify the behaviour against **JSON:API, REST, Views and
search** — those are the channels where entity-access rules most often leak. At
the time of writing the release is **2.0.0-rc1**, a release candidate, so test
thoroughly before production use.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module plus its UI submodule.
2. [Configuration](configuration/index.md) — define rules and policies, grant the
   permissions, and assign a policy to content.

## Where it lives in the admin menu

The administrative interface is provided by the **Access Policy UI**
(`access_policy_ui`) submodule. Enable it and you get admin screens for building
policies; authors then assign a policy from the **Access** tab on an individual
entity.
