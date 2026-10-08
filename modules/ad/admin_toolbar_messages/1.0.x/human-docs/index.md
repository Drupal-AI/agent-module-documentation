# Admin Toolbar Messages — manual setup guide

**Admin Toolbar Messages** (`admin_toolbar_messages`) moves Drupal's status
messages — the "The content has been saved." / warning / error notices — out of
the page content and into the administrative toolbar. Instead of a block that
appears at the top of the page body, notifications get a fixed, always-visible
home in the toolbar.

Why bother? Drupal's default placement quietly undermines its own feedback.
Messages render into a page region, which means they push the content down, land
in a different spot on every theme, and are often below the fold on a long form —
so an editor who saves at the bottom of the page sees no confirmation and has to
scroll back up to look for one. On a site with a custom admin theme that forgot
to print the message region, they can disappear entirely. Putting them in the
toolbar gives them a stable location that does not move the page.

The module is built for both of Drupal's administrative shells: it has test
dependencies on the classic core **Toolbar** and on the newer **Navigation**
module that core is moving toward, so it is prepared whichever one you run. It
targets Drupal 10.3 and 11.

Two things are worth checking on your own site rather than assuming, because they
are how a relocated-notification pattern goes wrong. First, **screen-reader
announcement**: Drupal's normal message region carries an `aria-live` attribute so
a new message is announced to assistive technology without moving focus — confirm
that relocated messages still do this, or the feedback becomes visual-only.
Second, **error visibility**: an error that scrolled past is bad, but an error
collapsed into an unread toolbar badge is worse, so make sure validation errors
in particular remain findable next to the field that caused them.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no settings page to visit. Once enabled, the module changes where status
messages appear across the site automatically.

## How to use it

Install and enable it — that is the whole setup. From then on, status, warning,
and error messages surface in the toolbar rather than in a page region. To try it,
log in as an editor (not user 1), save a long content form, and confirm the "saved"
confirmation appears in the toolbar without your needing to scroll. While you are
there, do the two accessibility checks noted above: verify a message is announced
to a screen reader, and that a validation error is still easy to find near its
field.
