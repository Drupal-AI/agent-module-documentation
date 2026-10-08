# Entity Legal — manual setup guide

**Entity Legal** (`entity_legal`) lets you publish legal documents — terms &
conditions, a privacy policy, a EULA — that your users must accept, and it keeps a
verifiable record of *exactly which version* each user agreed to and when. That
audit trail is what makes it useful for GDPR/consent-style compliance: when your
policy changes, you publish a new version, and you can prove who accepted which
wording.

Each **document** is versioned. You keep a full history of the text, mark one version
as "published" at a time, and switch the published version whenever the policy is
updated. When you do, users who need to re-accept are prompted again the next time
they visit — and every acceptance is logged against the specific version, the user,
and the date.

You control *who* has to accept and *how* they're asked. A document can require
acceptance from **new users** (on the registration form) and/or **existing users**
(the next time they browse), and each audience gets a **delivery method** — the
module ships five:

- **Message** — a status message prompting acceptance on every page.
- **Popup** — a modal dialog shown on every page until accepted.
- **Redirect** — existing users are sent to a dedicated acceptance page.
- **Form link** — a checkbox on the registration form linking to the full document.
- **Form inline** — the acceptance checkbox embedded directly in the registration
  form.

Documents also get their own view/re-accept permissions (so you can, for example,
expose a document to anonymous visitors, or scope which roles must re-accept),
support per-language translation of the title, body, and acceptance label, and can
be reported on through a bundled Views listing of acceptances. Administrators and
designated support staff can be exempted from ever being forced to accept.

It requires the [Token](https://www.drupal.org/project/token) module (document
titles are token-driven) and core's Text module, and runs on Drupal 10 or 11.

This guide is written for a **human** setting the module up through the UI. If you
want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead — they cover the entity model, the
acceptance-method plugin type, the programmatic API, and permissions in depth.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — create a document, add a version,
   choose who must accept and how, and set up permissions.

## Where it lives in the admin menu

Documents are managed at **Structure → Legal documents**
(`/admin/structure/legal`). Managing them requires the **Administer entity legal**
permission. Each document also generates its own per-document *view* and *re-accept*
permissions (see [Configuration](configuration/index.md#permissions)).

## How to use it

The flow is: create a document, add at least one version and publish it, decide
which audiences must accept and via which delivery method, and grant the relevant
permissions. Users are then prompted according to your settings, and their
acceptances are recorded automatically. The full walkthrough is on the
[Configuration](configuration/index.md) page.
