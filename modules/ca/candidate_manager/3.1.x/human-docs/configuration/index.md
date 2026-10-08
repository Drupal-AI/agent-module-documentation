# Configuration

Candidate Manager has a settings page, a set of granular permissions, Field UI
support for its entities, and a REST API. This page covers each, plus two
data‑handling cautions you should address before production.

## The settings page

Go to **`/admin/config/candidate-manager/settings`** (gated by **Administer site
configuration**). Here you choose the module's display/behaviour mode:

- **Simple** — the standard entity display.
- **Advanced** — enables a custom page template for the candidate view, with a
  candidate‑profile CSS library attached to profile pages.

## Permissions

Grant these under **People → Permissions** to the roles that need them:

- **Candidates:** `view candidate`, `add candidate`, `edit candidate`,
  `delete candidate`. For a view‑only recruiter, grant just `view candidate`.
- **Companies:** `view company`, `add company`, `edit company`, `delete company`.
- **Entity administration:** `administer candidate entities` /
  `administer company entities` — a broader administrative capability over each
  entity type (and, as noted below, what the REST write methods check in code).
- The module dashboard and settings sit behind **Administer site configuration**.

Canonical profile pages (`/candidate/{id}`, `/company/{id}`) use Drupal's normal
entity‑access checks.

## Adjusting fields with Field UI

Because Candidate and Company are real content entities, you can add, remove, or
reconfigure their fields and manage their form/display through **Field UI** —
enabled automatically as a dependency.

## The REST API

A REST resource (`candidate_rest_resource`) exposes candidates at
`/api/candidates[/{id}]`. To use it, enable the resource and a serialization format
(for example through `rest.settings` or a REST UI module).

| Method | Path | Route permission | Extra in‑code check |
|--------|------|------------------|---------------------|
| GET | `/api/candidates/{id}` | `restful get candidate_rest_resource` | **none** |
| POST | `/api/candidates` | `restful post candidate_rest_resource` | `administer candidate entities` |
| PATCH | `/api/candidates/{id}` | `restful patch candidate_rest_resource` | `administer candidate entities` |
| DELETE | `/api/candidates/{id}` | `restful delete candidate_rest_resource` | `administer candidate entities` |

- **POST** expects JSON with at least `full_name` and `email`, and returns
  `{message, id}` with a 201.
- **PATCH** sets any field named in the JSON body that the entity actually has.
- **GET** returns the serialized candidate; **DELETE** returns a message.

## Data‑handling cautions — read before production

Two behaviours in this module can expose candidate personal data more widely than
you might expect:

1. **Resume files are stored in `public://`.** A candidate's uploaded CV is written
   to the public files directory, so it is downloadable by direct URL by anyone who
   has (or guesses) that URL — this bypasses entity access entirely. Treat resume
   URLs as effectively public even if the HTML and REST routes are locked down.

2. **REST GET has no per‑entity access check.** The GET method returns a full
   candidate record based only on the blanket `restful get candidate_rest_resource`
   permission — it does **not** run a per‑entity `view` access check. So any role
   holding that permission can read **every** candidate's email, phone, resume, and
   notes. Do not grant `restful get candidate_rest_resource` to a broad or public
   role.

The REST **write** methods (POST/PATCH/DELETE) do additionally require
`administer candidate entities` in code, and the HTML admin routes are
permission‑gated.
