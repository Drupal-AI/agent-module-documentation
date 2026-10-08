# Candidate Manager — manual setup guide

**Candidate Manager** (`candidate_manager`) is a small applicant‑tracking system
(ATS) built as a Drupal module. It gives you two custom content entities —
**Candidate** and **Company** — each with admin lists, add/edit/delete forms, and a
public profile page, plus a REST API for reading and writing candidates
programmatically.

A **Candidate** record holds the kind of fields a recruiter needs: full name,
email, phone, an uploaded resume file, notes, skills, a category, a linked company,
a pipeline status (applied → shortlisted → interviewing → hired/rejected), a
LinkedIn URL, availability date, and location. A **Company** groups candidates
under an employer. Because the fields are real Drupal fields, you can add or adjust
them through Field UI.

Candidates and companies are managed under `/admin/candidates` and
`/admin/companies`, each gated by granular permissions, and each has a canonical
profile page (`/candidate/{id}`, `/company/{id}`). A REST resource exposes
`GET/POST/PATCH/DELETE` on `/api/candidates`.

> **Two data‑handling points worth knowing before you go live.** Candidate **resume
> files are stored in the public files directory** (`public://`), which means they
> are downloadable by anyone who knows or guesses the URL, bypassing entity access.
> And the REST **GET** method returns a full candidate record **without a per‑entity
> access check** — it relies solely on the blanket "restful get" permission. Treat
> both as reasons to lock down who can reach candidate data. See
> [Configuration](configuration/index.md) for detail.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (with its core dependencies).
2. [Configuration](configuration/index.md) — the settings page, permissions, Field
   UI, the REST API, and the data‑handling cautions.

## Where it lives in the admin menu

- **Candidates:** `/admin/candidates` (list, add, edit, delete).
- **Companies:** `/admin/companies` (list, add, edit, delete).
- **Module dashboard:** route `candidate_manager.admin`.
- **Settings:** `/admin/config/candidate-manager/settings` (under **Administer site
  configuration**).
- **Public profiles:** `/candidate/{id}` and `/company/{id}`.
