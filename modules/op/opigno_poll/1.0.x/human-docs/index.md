# Opigno Poll — manual setup guide

**Opigno Poll** (`opigno_poll`) brings multiple‑choice polls back to Drupal as a
first‑class content entity, revived from the Poll subsystem that used to ship with
Drupal core and adapted for the **Opigno LMS**. Each poll is its own entity: it
holds a question, a set of answer choices, an open/closed status and a voting
duration, and it captures votes into a dedicated database table (recording the
choice, the user, the poll, the voter's IP address and a timestamp).

Visitors vote through an AJAX form, and once they have voted — or once the poll
closes — the results appear as a meter. The module also ships a "Most recent poll"
block, a chart block that visualises the percentage split across choices, and
Views fields for a poll's status and total vote count. Optional shipped fields let
you scope a poll to an Opigno learning path or restrict who can see it by role,
which is where the LMS integration comes in.

Because it is built for Opigno, enabling it pulls in the **Opigno LMS**
distribution as a dependency (plus **Twig Tweak**), so it is really meant for sites
already running Opigno rather than as a standalone poll module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its Opigno/Twig Tweak dependencies.

Opigno Poll ships a settings route (`opigno_poll.settings` at
`/admin/config/content/opigno_poll`), but at this version it is a **placeholder
form with no options yet**, so there is no separate configuration page to walk
through — everything you actually do happens on the polls themselves.

## Where it lives in the admin menu

- **Manage all polls:** **Content** → the Opigno Poll listing at
  `/admin/content/opigno_poll` (needs the *administer opigno_polls* permission).
- **Add a poll:** `/opigno_poll/add` (needs *create opigno_polls*).
- **View and vote:** `/opigno_poll/{id}` — the public voting form for a poll.

## How to use it

1. **Create a poll** at `/opigno_poll/add`. Give it a **question**, add one or more
   **poll choices** (each choice is a label plus an optional starting vote count),
   set its **status** to open or closed, and give it a **duration**.
2. **Decide the voting rules** with the poll's flags: allow anonymous visitors to
   vote (*anonymous vote allow*), let people see the results before they vote
   (*result vote allow*), and let voters change their mind by cancelling their vote
   (*cancel vote allow*).
3. **Optionally scope the poll** to an Opigno learning path or to specific roles
   using the shipped optional fields, so only the right learners see it.
4. **Show it on the site.** Place the **Most recent poll** block or the **poll
   chart** block through **Structure → Block layout**, or add the poll's status and
   total‑vote columns to a View.

Voting happens on the poll's page: after a visitor votes (or when the poll is
closed) the form re‑renders to show the results as a meter. Grant the *view
opigno_poll results* permission to let a user always see results without voting,
and *cancel own vote* (together with the poll's *cancel vote allow* flag) to let
people withdraw a vote.

> **A note on vote integrity.** The route that deletes a vote
> (`/opigno_poll/{poll}/delete/vote/{user}`) is gated only by the broad *access
> opigno_polls* permission and, per an in‑code `@todo`, is missing a check that the
> person deleting a vote is the same user the vote belongs to. Until that check is
> added, only grant *access opigno_polls* to users you trust with other people's
> votes if vote integrity matters on your site.
