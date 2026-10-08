# Taxonomy Unique — manual setup guide

**Taxonomy Unique** (`taxonomy_unique`) adds a simple but useful safeguard: a
per‑vocabulary **"Terms should be unique"** option that stops anyone saving a term
whose name already exists in the **same vocabulary and language**. It's the way to
keep a controlled vocabulary clean — no accidental second "News" tag, no
typo‑driven duplicate brands — with a clear, customizable error message when a
duplicate is entered.

Uniqueness is checked at **save time** through Drupal's entity validation, so it
applies wherever a term is created: the normal admin term form, imports, and even
REST or JSON:API term creation. Because it works per vocabulary and per language,
the same name can still exist in a *different* vocabulary, or in the same
vocabulary in a *different* language — only duplicates within one vocabulary and
language are blocked.

The module also handles free‑tagging fields: it ships a special entity‑reference
selection handler that prevents an autocomplete "Tags" field from silently
**auto‑creating** a duplicate term. There is **no global settings page** —
uniqueness is switched on per vocabulary from a small fieldset on that
vocabulary's edit form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — turn uniqueness on for a vocabulary
   and set the error message.

## Where it lives in the admin menu

There is no dedicated settings page. The option appears as a **Taxonomy unique**
fieldset on each vocabulary's edit form, at **Structure → Taxonomy → [your
vocabulary] → Edit** (`/admin/structure/taxonomy/manage/<vocabulary>`).

## How to use it

Edit the vocabulary you want to protect, open its **Taxonomy unique** fieldset,
tick **Terms should be unique**, optionally write a custom message, and save. From
then on, attempts to create a duplicate term name in that vocabulary are rejected
with your message. See [Configuration](configuration/index.md) for the details.
