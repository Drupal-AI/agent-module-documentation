# Hierarchical Taxonomy Importer — manual setup guide

**Hierarchical Taxonomy Importer** (project `hti`, machine name
`hierarchical_taxonomy_importer`) builds a taxonomy vocabulary from a spreadsheet.
Instead of typing dozens or hundreds of terms — and their parent‑child
relationships — into Drupal by hand, you prepare a CSV file, upload it, choose the
vocabulary, and let the module create the nested term structure for you.

It's an administrative, site‑building tool. You point it at a target vocabulary,
give it a CSV describing the terms and their hierarchy, and it imports the terms
with their parent‑child relationships intact — a fast way to stand up a large,
structured vocabulary.

> **Two things to know before you import.** First, the module **does not update an
> existing taxonomy tree** — it imports fresh terms rather than reconciling with
> what's already there, so importing into a populated vocabulary can create
> duplicates or an unexpected result. Validate your CSV carefully first, and **back
> up** before importing into a vocabulary that already has content. Second, because
> taxonomy terms can drive access, menus, and content organisation, treat an import
> as a controlled operation: only import files you trust, and review the resulting
> hierarchy afterwards.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside its core dependencies.
2. [Configuration](configuration/index.md) — the import form, step by step.

## Where it lives in the admin menu

The importer is at **Configuration → Taxonomy Importer**. You select the target
vocabulary, upload your CSV file, and submit — the module creates the terms and
their hierarchy. See [Configuration](configuration/index.md) for the full workflow.
