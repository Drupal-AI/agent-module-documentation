# Simple Groups — manual setup guide

**Simple Groups** (`simple_group`) is a lightweight way to relate entities together
into groups. Where core has no built‑in concept of "a group of users" or "a group
of content," and the full Group module can be more machinery than a small site
needs, Simple Groups gives you a simple middle path: create group types, create
groups, and use entity‑reference fields to tie users and content into them.

It is aimed at developers and site builders who want to organise users (and/or
content) into memberships quickly, without adopting the full Group ecosystem. You
define **group types**, create **groups** under them, and connect members through
ordinary entity‑reference fields — so the grouping is built on familiar core Field
API pieces rather than a bespoke API. The module provides its own permissions to
control who can administer groups.

The module works on **Drupal 10 and 11** and depends only on core's **Field**
module. Note that this release is an early **beta** (1.0.0‑beta1) and is not covered
by Drupal's security advisory policy, so weigh that before using it on a
high‑stakes production site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Once the module is enabled, look for the **Simple Groups** button in the admin
toolbar (admin bar) — that is the entry point for getting started. From there you:

1. Create one or more **group types** to describe the kinds of groups you need.
2. Create **groups** under those types.
3. Wire members in using **entity‑reference fields**, relating users or content
   entities to the groups they belong to.

Because grouping is expressed through standard entity‑reference fields, the members
of a group are queryable and reusable like any other reference data on your site.
