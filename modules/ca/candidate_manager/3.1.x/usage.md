<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Candidate Manager provides a small recruitment/ATS domain model: two custom content entities, **Candidate** (full name, email, phone, resume file, notes, skills, category, company, status, LinkedIn, availability, location) and **Company**, each with admin list builders, add/edit/delete forms and a public canonical profile page.

Candidate and Company management routes live under `/admin/candidates` and `/admin/companies` and are gated by granular permissions (`view/add/edit/delete candidate`, `view/add/edit/delete company`); the module dashboard and settings are under `administer site configuration`. Canonical profile pages (`/candidate/{id}`, `/company/{id}`) use entity access. A REST resource (`candidate_rest_resource`) exposes `GET/POST/PATCH/DELETE /api/candidates[/{id}]`, gated by the auto-generated `restful … candidate_rest_resource` permissions; write methods additionally check `administer candidate entities` in code.

Note two data-handling points to review before production use: candidate **resume** files are stored in the **public://** file scheme (directly downloadable by URL, bypassing entity access), and the REST **GET** method returns the full candidate entity without a per-entity `->access()` check (it relies solely on the blanket REST-GET permission). Configure the display/behaviour mode at `/admin/config/candidate-manager/settings` (simple vs advanced, the latter enabling a custom page template for candidate view).
---
Manage candidates and companies as content entities, expose them over REST, and configure display mode.
---
- Create a candidate record with contact details and a resume
- Track a candidate's pipeline status (applied → shortlisted → interviewing → hired/rejected)
- Tag candidates with skills and a category taxonomy
- Link a candidate to a company
- Record a candidate's LinkedIn URL and availability date
- Browse and filter the candidate list at `/admin/candidates`
- Manage companies at `/admin/companies`
- View a public candidate or company profile page
- Grant recruiters view-only access via the `view candidate` permission
- Restrict candidate editing to specific roles
- Create a candidate via `POST /api/candidates` (needs admin permission)
- Read a candidate via `GET /api/candidates/{id}`
- Update selected fields via `PATCH /api/candidates/{id}`
- Delete a candidate via `DELETE /api/candidates/{id}`
- Configure add/edit fields through Field UI
- Switch the module between simple and advanced display mode
- Use the advanced mode's custom candidate page template
- Attach the candidate-profile CSS library to profile pages
- Assign an owner (author) to each candidate record