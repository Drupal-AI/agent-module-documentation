# Marketo MA — manual setup guide

**Marketo MA** (`marketo_ma`) integrates Adobe's **Marketo** marketing‑automation
platform with Drupal. It does three things: it adds Marketo's **Munchkin** tracking
script to your pages, it **captures lead data** from form submissions and user
accounts, and it **synchronises** that data with Marketo through Marketo's REST
API. The pieces are split across a base module and several submodules so you enable
only the parts you need.

Munchkin tracking can be included or excluded by path and by role. Lead capture can
run through Munchkin's JavaScript or through the API, and API capture can be
synchronous or deferred to cron. You can capture leads during user creation,
update, and login, and map Drupal user (and webform) fields to Marketo fields.

Marketo MA depends on core's **User** module and provides an **administer marketo**
permission that is marked restricted‑access. It targets Drupal 9.2 and later.

> **A note on the core requirement.** This version declares `core_version_requirement:
> ">=9.2"` — an open‑ended constraint with no upper bound. That is a statement that
> the module *will install* on any future core release, not evidence that it has been
> *tested* on one. Verify it behaves on your specific core version before relying on
> it in production.

### Take the privacy weight seriously

This category is often treated as a marketing decision when it is really a
data‑protection one:

- **Munchkin builds an identified profile, not aggregate statistics.** Once a person
  is known to Marketo, their page‑by‑page browsing is attached to their name in a
  system your sales staff can read. That is a materially different activity from
  counting visits, and it needs a lawful basis, an entry in your privacy notice, and
  usually a **consent gate**.
- **Lead capture means personal data leaves your site** on submission. A form that
  says nothing about it is collecting data for an undisclosed purpose.
- **The API credentials are a live grant** over your organisation's marketing
  database. Store them as securely as any other secret and scope them as narrowly as
  Marketo allows.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and choose the submodules you need.
2. [Configuration](configuration/index.md) — connect to Marketo, set up Munchkin
   tracking and lead capture, map fields, and store credentials safely.

## Where it lives in the admin menu

The main settings form is the **Marketo MA settings** page (route
`marketo_ma.settings`), reached from the **Configuration** area. Permissions are set
at **People → Permissions** (`/admin/people/permissions`), where **administer
marketo** is a restricted‑access permission for trusted administrators only.
