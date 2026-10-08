<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Candidate Manager (candidate_manager) — agent index

**Applicant-tracking domain module**: `candidate` and `company` content entities with admin lists, profile pages, Field UI support and a REST API.

**Version:** 3.1.x (git branch `3.1.x`, no packaged version). Core: `^10 || ^11`. PHP `>=7.4`. Depends on core `rest`, `serialization`, `field_ui`.

Entities: `Candidate` (fields incl. email, phone, `resume` file, notes, skills/category taxonomy refs, company ref, status, linkedin, availability) and `Company`; `admin_permission = administer {candidate|company} entities`. Routes: lists/forms under `/admin/candidates` and `/admin/companies` (perms `view|add|edit|delete candidate|company`); dashboard `candidate_manager.admin` and settings `/admin/config/candidate-manager/settings` (`administer site configuration`); canonical `/candidate/{id}`, `/company/{id}` (`_entity_access`). REST: `candidate_rest_resource` at `/api/candidates[/{id}]`, perms `restful {get|post|patch|delete} candidate_rest_resource`.

**Security (report):** (1) `resume` file field uses `uri_scheme => public` — candidate CVs are world-downloadable by direct URL, bypassing entity access (src/Entity/Candidate.php:89). (2) REST `get()` returns the entity with **no** `->access('view')` check; any role holding `restful get candidate_rest_resource` can read every candidate's PII (src/Plugin/rest/resource/CandidateRestResource.php:60-66). Write methods do check `administer candidate entities`. HTML admin routes are permission-gated.

See [api/rest.md](api/rest.md).