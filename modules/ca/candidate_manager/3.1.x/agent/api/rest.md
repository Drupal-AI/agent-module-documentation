<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Candidate Manager REST API

Resource plugin `candidate_rest_resource` (enable the REST resource + a serialization format, e.g. via `rest.settings` / a REST UI). Base paths:
- Canonical: `/api/candidates/{id}`
- Create: `/api/candidates`

## Methods & access
| Method | Path | Route permission | In-code check |
|--------|------|------------------|---------------|
| GET | `/api/candidates/{id}` | `restful get candidate_rest_resource` | **none** (no per-entity access) |
| POST | `/api/candidates` | `restful post candidate_rest_resource` | `administer candidate entities` |
| PATCH | `/api/candidates/{id}` | `restful patch candidate_rest_resource` | `administer candidate entities` |
| DELETE | `/api/candidates/{id}` | `restful delete candidate_rest_resource` | `administer candidate entities` |

## Payloads
- POST expects JSON with at least `full_name` and `email`; returns `{message, id}` (201).
- PATCH iterates the JSON body and `set()`s any field the entity `hasField()`.
- GET returns the serialized Candidate entity; DELETE returns a message.

## Cautions for an operator
- Do **not** grant `restful get candidate_rest_resource` to a broad role: GET performs no per-entity access filtering, so it discloses every candidate's email/phone/resume/notes.
- Resume files live in `public://`; treat their URLs as effectively public even if the REST/HTML routes are locked down.
