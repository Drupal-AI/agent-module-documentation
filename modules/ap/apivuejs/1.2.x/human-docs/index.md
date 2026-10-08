# Api vuejs — manual setup guide

**Api vuejs** (`apivuejs`) is a JSON backend for a decoupled **Vue.js** front end.
It exposes a set of HTTP routes that build Drupal **entity form definitions** and
perform entity **create / update / delete / duplicate** operations, so a Vue.js UI
can render Drupal's own entity forms and save entities back over JSON without you
writing that plumbing yourself.

It is a developer tool for progressive decoupling — the API layer that sits behind
a Vue.js admin or editing interface. It returns form arrays (including handling
Layout Builder sections and translations), and its endpoints run entity access
checks: updates call `access('update')` before writing, and queries use access
checking.

**On access control.** The data routes require the **`edit-create apivuejs
entities`** permission and authenticate with either a session cookie or HTTP basic
auth. Be aware that this single permission is **coarse** — it grants create,
update *and* delete across **all** entity types at once, so assign it only to
trusted roles. Read access to an entity render is a separate permission
(`canonical apivuejs entities`), and the settings form is gated by `administer
apivuejs configuration`.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it needs the
   `symfony/stopwatch` library) and enable the module.
2. [Configuration](configuration/index.md) — the settings form, the permissions,
   and how requests authenticate.

## Where it lives in the admin menu

The settings form is at **Configuration → System → apivuejs**
(`/admin/config/system/apivuejs`). The permissions are set at **People →
Permissions** (`/admin/people/permissions`).
