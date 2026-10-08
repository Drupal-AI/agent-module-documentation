# CRM Core — manual setup guide

**CRM Core** (`crm_core`) is a native Drupal CRM framework for managing contacts,
activities, and relationships inside your site — without an external CRM system. It
models this data as Drupal entities and provides a set of tools to work with it,
integrating along the way with Views, VBO, ctools, rules, Solr, services, the Field
API, and Search API.

CRM Core is really a suite: the base module supplies the framework, and its behavior
comes from a set of submodules you enable as needed — **Contact** management, an
**Activity** log, duplicate **Matching**, and **User Sync** to pair Drupal user
accounts with contacts, plus optional demo content. You turn on just the pieces your
project needs and build your contact workflows on top of them.

A word on which module to choose. CRM Core is the long-standing framework whose
lineage goes back to Drupal 7, and this 3.x branch is **mostly not maintained** (the
project is seeking a new maintainer, with no further development planned). If you are
starting a brand-new contact-management project on Drupal 11, the newer
[CRM](https://www.drupal.org/project/crm) module is the modern, actively developed
successor, and existing Drupal 7 CRM Core sites have a dedicated migration path via
the **CRM Migrate CRM Core** module. Choose CRM Core when you are maintaining an
existing site built on it or need its specific integrations; choose CRM for new work.

CRM Core has no hard dependencies and supports Drupal 9, 10, and 11. Because it
stores personal data about real people, grant CRM administration only to trusted
staff and apply your usual privacy safeguards.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and pick the submodules you need.
2. [Configuration](configuration/index.md) — what each submodule adds once enabled,
   and where to configure contacts, activities, matching, and user sync.

## Where it lives in the admin menu

CRM Core adds contact, activity, and settings pages once its submodules are enabled;
the exact locations depend on which submodules you turn on (see Configuration). The
CRM Core Handbook on drupal.org is the authoritative reference for detailed
administration.
