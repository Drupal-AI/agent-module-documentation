# Revision Extras — manual setup guide

**Revision Extras** (`revision_extras`) adds configuration options on top of
Drupal core's revision system for content entities, and works around a few
long-standing core issues. If you rely on revisions for editorial accountability,
it lets you *enforce* good revision habits and smooths some rough edges core has
not yet fixed.

Its main features:

- **Require revisions and revision log messages** on nodes, media, and custom
  blocks — configurable per bundle, so you can insist that editors record *why*
  they changed something.
- **Customize the revision log message field** — change its label and description,
  and optionally display the last revision log message below the field for
  reference.
- **A Drush command** that generates a report of public content (node) changes for
  a given day, optionally emailing it with a CSV attachment.
- **Extra tokens** for the log message on media and custom blocks (core already
  provides one for nodes), available when the Token module is installed.
- **Workarounds for core issues** — it populates the revision user for media
  created through the media library form, and (on core before 11.3) adds the
  revision log message to the Layout Builder form.

The core-issue workarounds apply the moment the module is installed. Everything
else is opt-in on the settings form. This is a content-editing enhancement;
revision access still follows core's revision permissions, and the module adds no
access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

The opt-in features are turned on from a single settings form, described in "How to
use it" below.

## Where it lives in the admin menu

The settings form is at **Configuration → User interface → Revision Extras**
(`/admin/config/user-interface/revision-extras`).

## How to use it

1. The **core-issue workarounds** (revision user on media-library uploads, and the
   Layout Builder log message on older core) take effect as soon as the module is
   enabled — no configuration needed.
2. To enforce revisions, open **Configuration → User interface → Revision Extras**
   and, per bundle, turn on *require a new revision* and *require a revision log
   message* for the node, media, and block content types where you want them.
3. On the same form you can **customize the log message field** — set a custom
   label and description, and choose whether to show the previous log message
   below the field.
4. To use the **daily change report**, run the module's Drush command. To attach a
   CSV, install and configure a mailer such as *Drupal Symfony Mailer Lite* or
   *Drupal Symfony Mailer Plus*; if the *Diff* module is installed, the report can
   also include a link to the diff between the current and previous revision.
5. Install the **Token** module if you want the extra media/block log-message
   tokens.
