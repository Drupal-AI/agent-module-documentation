# Gutenberg Block Report — manual setup guide

**Gutenberg Block Report** (`gutenberg_block_report`) gives site owners an
administrative report of which **Gutenberg** blocks are used across their content,
and where. It scans your Gutenberg‑authored content and summarises, per block, how
many times it appears and which nodes use it — with links through to those nodes.
It is a read‑only auditing tool, useful when you are about to deprecate or change a
block and need to know what would be affected.

The report lists, for each block:

- the **block name** — both the human‑friendly label and the machine name;
- the **total count** of occurrences across all content; and
- a **sample of nodes** using the block, plus a link to view more nodes for that
  block.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Configuration

There is nothing to configure — the module has no settings form. It simply adds a
report to the admin UI.

## Where it lives in the admin menu

The report is at **Administration → Reports → Gutenberg block report**. Open it to
see the per‑block usage summary described above. Access is governed by the module's
own permission, so grant that to the roles that should be able to run the audit.
