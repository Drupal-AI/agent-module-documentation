# Config Features — manual setup guide

**Config Features** (`config_features`) helps you **share and bundle configuration
from one site to another**. You group a set of related config objects into a
reusable bundle — a "feature" — that can be exported from one site and imported
into another, in the same spirit as the long-standing Features module. Its headline
convenience is that it handles the **UUID differences** between sites: the same
piece of configuration usually has a different UUID on each site, which normally
makes a straight import create a duplicate or fail. Config Features recognises this
and simply **updates** the matching configuration instead, even though it arrived
from a different site.

Use it to package configuration for reuse across sites — a set of content types, a
group of views, a block layout — rather than hand-copying config files. It moves
**configuration, not content**, and provides its own permission; it has no
access-control role beyond that permission. It requires no other modules and
supports Drupal 9.4, 10, and 11.

> **Review a feature before you share it.** Exported configuration can embed
> sensitive settings — API keys, credentials, tokens stored in config. Look through
> a feature's contents before handing it to another site or committing it, so you
> don't leak secrets along with the config you meant to share.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   set its permission.

The feature bundles you build are themselves configuration, so the workflow is a
mix of admin UI and standard config export/import, described below.

## Where it lives in the admin menu

Config Features adds admin screens for defining and exporting features and provides
its own permission to control who may use them. Grant that permission to trusted
site builders under **People → Permissions** (`/admin/people/permissions`).

## How to use it

1. On the **source** site, define a feature — a named bundle of the configuration
   objects you want to package together.
2. Export the feature. Because a feature is itself configuration, it moves with
   your config export.
3. On the **target** site, import the feature. Config Features reconciles the UUID
   differences and updates the matching configuration rather than duplicating it.
4. Before sharing, review the feature's contents to make sure no sensitive settings
   are included.
