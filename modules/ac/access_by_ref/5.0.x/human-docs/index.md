# Access by Reference — manual setup guide

**Access by Reference** (`access_by_ref`) turns entity-reference relationships into
node-access rules. When a node references a user (or a value that user shares), the
module can dynamically grant that logged-in user **view, update, and/or delete**
access to the node. It is a code-free way to say things like "the user listed in a
node's *Owner* field may edit it" or "project members referenced from a project node
may view it".

You don't add any fields — instead an administrator creates one or more **Access by
ref config** rules. Each rule binds a node **bundle**, a **field** on that bundle, a
**reference type**, and which of read/update/delete to grant. On every node access
check, matching rules grant the configured rights. The module only ever **widens**
access — it returns "allowed" or "neutral", never "denied" — so it layers on top of
your existing permissions without ever taking access away.

There are four reference types: **user** (the field references the current user),
**user_mail** (an email field on the node matches the user's account email),
**shared** (a node field value matches a value in one of the user's own profile
fields), and **inherit** (the node references another entity the user already has
access to, chaining access transitively).

> **Note on inherit rules.** An **inherit** rule checks one operation on the parent
> but can grant any of read/update/delete you enable, and chained inherit rules have
> no loop protection, so configure them carefully.

This guide is written for a **human** clicking through the admin UI. If you want a
terse, token-cheap reference for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the two permissions, the rule fields,
   and each of the four reference types explained.

## Where it lives in the admin menu

The rules list is at **Configuration → Content authoring → Access by Reference**
(`/admin/config/content/access_by_ref`). It requires the **Administer access_by_ref
settings** permission.
