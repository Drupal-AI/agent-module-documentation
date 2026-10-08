# Bugherd API — manual setup guide

**Bugherd API** (`bugherdapi`) puts BugHerd's visual feedback overlay on your
site, so reviewers can report issues by clicking on the page they are looking at.
The reviewer clicks the element, types the comment, and BugHerd captures the URL,
the browser, the viewport and a screenshot alongside it — removing the round trip
of turning a review document into an actionable ticket.

The module places the overlay and lets you configure which pages carry it.

**The important deployment decision is who sees the overlay, and it needs to be
explicit.** A feedback tool loaded for everyone shows a floating widget to real
visitors, invites feedback from people who are not reviewers, and loads a
third-party script on every page. The usual arrangement is to restrict it to
authenticated users, to a specific role, or to a non-production environment.
Decide this before enabling it rather than after someone reports the widget on
the live homepage.

**It is also a third-party script that can read the page** — that is how
screenshot capture works. That places your BugHerd account inside the site's
trust boundary: the tool sees whatever a reviewer sees, including anything
personal on an authenticated page. On a site handling regulated data, that is
worth a moment's thought before the overlay goes on an internal admin screen.

Its core requirement is `^11 || ^12` — current Drupal only.

This guide is written for a **human** setting the module up through the admin UI.
If you want a terse, token-cheap reference for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — connect your BugHerd project and
   decide who sees the overlay.

## Where it lives in the admin menu

The settings form is at **Configuration → System → BugHerd**
(`/admin/config/system/bugherd`), behind the `administer bugherd` permission.
