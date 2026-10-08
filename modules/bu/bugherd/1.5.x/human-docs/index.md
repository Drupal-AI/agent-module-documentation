# BugHerd — manual setup guide

**BugHerd** (`bugherd`) embeds the BugHerd feedback overlay into your Drupal
site. Reviewers can click an element on a page, type a comment, and file an issue
against it — and the resulting ticket automatically carries the element, the URL,
the browser and the screen size. It replaces the usual "the thing on the right of
the second page" email-and-screenshot review with something a developer can act
on directly.

This module supplies the Drupal side: a settings form, and the important control
of **which roles see the overlay**. That control matters because the widget is
client-side JavaScript that should not be shipped to the public — you grant the
`access bugherd` permission to reviewer roles only. The module can also suppress
the overlay on admin pages. Its core requirement is `^10 || ^11 || ^12`, so it
already declares support for Drupal 12.

Two things are worth stating plainly. First, the overlay is a **third-party
script** loaded into the page, so it is a data-flow and consent consideration
anywhere real visitors might encounter it. Second, the recommended arrangement is
to grant `access bugherd` to reviewer roles only, and ideally to enable the
module on **staging** rather than production.

This guide is written for a **human** setting the module up through the admin UI.
If you want a terse, token-cheap reference for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — connect your BugHerd project and
   decide who sees the overlay.

## Where it lives in the admin menu

The settings form is at **Configuration → Development → BugHerd**
(`/admin/config/development/bugherd`), behind the `administer bugherd`
permission. Who actually sees the overlay is controlled by the separate
`access bugherd` permission.
