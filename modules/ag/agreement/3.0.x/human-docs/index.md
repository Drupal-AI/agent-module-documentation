# Agreement — manual setup guide

**Agreement** (`agreement`) makes users accept a document — a terms of service, an
acceptable use policy, an NDA, a code of conduct — before they can use the site,
and it records that they did. When a user in a targeted role visits, they are
redirected to the agreement page and cannot continue until they accept; once they
do, the acceptance is stored, so you have a record of who agreed to what and when.

Each agreement is a **configuration entity** with its own text, target roles,
applicable paths, and re-acceptance rules. Because agreements are configuration,
they export and deploy with `drush cex` / `drush cim` like the rest of your
site's config. You can have several agreements — different documents for different
roles, for example. The agreement text runs through a text format, which is why
the module depends on core's **Filter** module.

The module divides its responsibilities across three permissions, sensibly:

- **Administer agreements** — manage the agreements themselves (marked *restrict
  access* because it is powerful).
- **Bypass agreement** — exempt an account from the interruption entirely.
- **Revoke own agreement** — let a user withdraw their acceptance. This is a
  genuinely thoughtful inclusion: under GDPR, consent must be as easy to withdraw
  as it is to give.

**Two practical cautions.** First, the redirect applies to *every* request from a
targeted user until they accept, so assign **Bypass agreement** to your
deployment, monitoring, and support accounts *before* a rollout — otherwise those
accounts get redirected to the agreement page on every request and look broken.
Second, this module records *that* someone accepted; the wording of the agreement,
how you version it, and what happens if someone refuses are policy decisions it
cannot make for you.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create agreements, target roles and
   paths, set re-acceptance rules, and assign the permissions.

## Where it lives in the admin menu

Agreements are managed at **Configuration → People → Agreement**
(`/admin/config/people/agreement`), which lists your agreements and lets you add,
edit, and delete them. The three permissions are assigned under **People →
Permissions** (`/admin/people/permissions`).
