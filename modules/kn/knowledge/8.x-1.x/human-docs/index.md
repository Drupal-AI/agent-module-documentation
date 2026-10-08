# Knowledge — manual setup guide

**Knowledge** (`knowledge`) is a knowledge‑ and competency‑management system for
Drupal that implements the ideas of **Knowledge Centered Service (KCS®)**. It lets
teams link incidents to content and manage a body of knowledge articles alongside
**competency**, **adherence**, and **quality** entities — with **audience
segmentation** (internal, partner, customer, external), an approval **workflow**
via core Content Moderation, and search integration through **Search API**. It's
aimed at learning and knowledge‑management use cases: support teams, internal
handbooks, and structured competency tracking.

The module defines several entity types — **Link**, **Content Standard
Checklist**, **Process Adherence**, and **Competency** — and moves content through
a workflow of **Work in Progress → Not Validated → Validated → Archived**. The
`knowledge_field` submodule (a dependency, enabled with the module) supplies the
field types it relies on.

The most important part of setting up Knowledge is **permissions**. It exposes a
very large, granular permission set — create/read/update/delete on knowledge,
competency, adherence, and quality entities, plus revision access, the ability to
skip approval, and per‑audience visibility. The **audience‑visibility** and
**approval‑skip** permissions are security‑relevant: they decide who can see
internal‑only material and who can publish without review. Map them to roles
deliberately rather than granting them broadly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, satisfy the
   several module dependencies, and enable it.

This module is configured through **entities, workflow, and permissions** rather
than a single settings form, so there is no separate configuration page — the
setup work is described under "How to use it" below.

## Where it lives in the admin menu

Knowledge does not add one central settings page. You work with it through the
standard Drupal admin areas:

- **People → Permissions** (`/admin/people/permissions`) — assign the granular
  knowledge/competency/adherence/quality permissions to roles.
- **Content moderation** — the approval workflow (Work in Progress → Not Validated
  → Validated → Archived) runs through core Content Moderation.
- **Search API** (`/admin/config/search/search-api`) — index knowledge content for
  site search.

## How to use it

A typical setup sequence is:

1. **Assign permissions carefully** at **People → Permissions**. Decide which
   roles can create and edit each entity type, who can see each audience
   (internal/partner/customer/external), who may skip approval, and who can view
   revisions. Treat audience and approval permissions as the security boundary of
   the system.
2. **Configure the moderation workflow** so content flows through Work in
   Progress → Not Validated → Validated → Archived with the right roles able to
   move it between states.
3. **Set up Search API** to index knowledge content so it is findable.
4. **Start authoring** knowledge, competencies, adherence, and quality records,
   linking incidents to content as your process requires.
