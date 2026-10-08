# Professional Directory — manual setup guide

**Professional Directory** (`professional_directory`) is a reusable module for
organisations that need a **moderated directory of professionals** with a
privacy-aware contact workflow. Prospective members apply through a public signup
form (uploading accreditation details), an administrator validates or rejects each
application, and approved members get a private area where they can find each
other and exchange contact details only after a **mutual** agreement.

The flow is built around privacy and moderation. Signup is open so anyone can
apply, but a new profile is stored as unvalidated until staff review it. Approved
professionals see a private directory of other approved members; contact requests
must be accepted by both sides before email and phone details are shared. Uploaded
accreditation files are kept in private storage with access-controlled downloads,
and the validation and rejection emails are configurable HTML. Optional phone QR
codes are generated when a QR library is available.

Access control is careful throughout. The private area only ever loads the
*current* user's own validated profile — an unvalidated or rejected account just
sees a "not yet validated" notice, and no user can read another's data. Anonymous
visitors to the private area are sent to log in first. Accreditation file
downloads are guarded so that only an administrator or the file's owning
professional (with a validated, non-rejected profile) can retrieve them, which
prevents guessing at other people's documents by ID. All administration and
moderation is gated behind the *administer professional directory* permission.
Because the module collects real personal information, protect the public signup
form with a CAPTCHA and treat the data accordingly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside the
   core File and Link modules, then enable it.
2. [Configuration](configuration/index.md) — set the directory name, categories,
   registration window, and notification emails, and grant the member permission.

## Where it lives

- **Settings:** **Configuration → Professional Directory**
  (`/admin/config/professional-directory`).
- **Moderation / overview:** **Content → Professional Directory**
  (`/admin/content/professional-directory`) — validate or reject applications.
- **Public signup:** `/professional-directory/signup`.
- **Private member area:** `/professional-directory/private-area`.

## The member lifecycle

1. A prospective member applies at `/professional-directory/signup`, uploading an
   accreditation file. Their profile is created as *unvalidated*.
2. Staff review it from `/admin/content/professional-directory` and **validate** or
   **reject** it; configurable emails notify the applicant.
3. Once validated, the member can reach `/professional-directory/private-area`,
   browse other approved professionals, and send contact requests.
4. When a contact request is mutually accepted, the two members' email and phone
   details are shared with each other.
