# Legal — manual setup guide

**Legal** (`legal`) puts your Terms & Conditions in front of visitors when they
register (and, optionally, when they log in or edit their profile) and makes them
tick an **Accept** checkbox before an account is created. It records exactly who
accepted which version of the terms and when, giving you a consent audit trail —
useful for GDPR and other compliance requirements.

You enter your T&C text on an admin page, and every time you save you create a new
**version**. Publishing a new version forces everyone to re-accept: on their next
login, users who have not accepted the latest terms are sent through an acceptance
step before they can continue. You choose how the terms are displayed (a scrollable
read-only box, inline HTML, or a link that opens the terms in a modal), whether to
re-ask on every login, which roles are exempt, and where to send people after they
accept. User 1 and any masquerading session are always exempt so you cannot lock
yourself out.

Beyond registration, Legal ships a public `/legal` page that shows the current
terms, a `[legal:tc]` token you can embed elsewhere, and two ready-made Views
reports — one listing the history of T&C versions and one listing user acceptances.
It depends on core's **User** and **Views** modules, works across languages (you can
keep separate terms per language), and adds no Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — entering the terms, the display and
   behaviour settings, and the permissions.

## Where it lives in the admin menu

Legal's admin pages sit under **Configuration → People → Legal**
(`/admin/config/people/legal`). That first page is where you enter and save the
T&C text; a **Settings** sub-tab (`/admin/config/people/legal/settings`) holds the
display and behaviour options, and a **Languages** sub-tab handles per-language
options on multilingual sites. The public terms page is at `/legal`. Access is
gated by two permissions: **Administer Terms and Conditions** (to manage terms and
settings) and **View Terms and Conditions** (to see the public page).
