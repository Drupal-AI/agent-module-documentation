# RSVP List — manual setup guide

**RSVP List** (machine name `rsvplist`, project `rsvp_list`) lets visitors sign up to
attend an event, and gives administrators the resulting guest list. You enable RSVPs
on the content types you choose; on those nodes an **RSVP block** shows a small form
where a visitor enters their email to confirm they'll attend. Administrators can then
review everyone who responded, along with their contact details, per event.

It's handy for sub‑events and sign‑ups of all kinds — a rehearsal dinner, a
post‑conference breakout session, a workshop — anywhere you want a lightweight "who's
coming?" form attached to a page. Both anonymous and logged‑in users can submit,
subject to the permissions you set, and the collected responses are available in the
reports area.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose which content types allow RSVPs,
   place the RSVP block, set permissions, and find the responses.

## Where it lives in the admin menu

The module's settings live at **Configuration → Content authoring → RSVP List**
(`/admin/config/content/rsvplist`), where you pick the content types on which RSVPs
can be enabled. The RSVP form itself is a **block** you place through **Structure →
Block layout**, and collected responses appear in the site's **Reports**. See
[Configuration](configuration/index.md).
