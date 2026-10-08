# Node Title Validation — manual setup guide

**Node Title Validation** (`node_title_validation`) lets you set rules for the
titles editors give your content, enforced automatically when a node is saved. Out
of the box Drupal only checks that a title is not empty and is under 255
characters; this module adds **minimum and maximum character length**, **minimum
and maximum word count**, a **blocklist** of forbidden characters or words, and a
**uniqueness** check — each configurable per content type.

That means you can, for example, require Article titles to be at least 10
characters and no more than 12 words, block spammy or profane words from headlines,
forbid stray punctuation, and stop editors from accidentally creating two Events
with the same title. Every content type gets its own set of rules on one settings
form, and a single title is checked against all of its rules at once, so an editor
sees every problem to fix in one go.

Crucially, the rules are enforced as a proper entity **constraint** on the node
title field — not just a bit of form JavaScript. That means they fire on *any*
save path: the node edit form, programmatic `->save()` validation, content
imported via migration, and writes through JSON:API or REST. The settings form is
protected by the module's own dedicated permission, so you can hand title-rule
management to content managers without giving them broader admin access.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — the config structure and the
validator internals — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the per-content-type rules form,
   field by field, plus the permission.

## Where it lives in the admin menu

The settings form is at **Configuration → Content authoring → Node Title
Validation** (`/admin/config/content/node-title-validation`). Access is controlled
by the module's own **Node title validation admin control** permission.

## How to use it

Enable the module, grant the **Node title validation admin control** permission to
the roles that should manage title rules, then open the settings form. It shows a
section per content type — fill in whichever rules you want for each type and save.
From then on, any node of that type that breaks a rule is rejected on save with a
clear message. See [Configuration](configuration/index.md) for a walkthrough of
each rule.
