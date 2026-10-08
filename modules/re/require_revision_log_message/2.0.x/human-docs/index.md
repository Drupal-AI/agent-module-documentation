# Require Revision Log Message — manual setup guide

**Require Revision Log Message** (`require_revision_log_message`) makes the
*revision log message* a mandatory field when editors save a node. On a normal
Drupal site the revision log is optional — editors can (and often do) leave it
blank, which means nobody can later tell *why* a change was made. This module
closes that gap for the content types you choose: it forces the "Create new
revision" checkbox on (and locks it so it cannot be unchecked) and marks the
revision log message as required, so a change cannot be saved without a short
written explanation.

You decide exactly which content types are affected on a simple settings form.
By default the requirement only kicks in when someone *edits* an existing node —
brand-new nodes are left alone — but a single checkbox lets you extend it to node
creation too. Trusted users can be exempted from the rule with a dedicated
*bypass* permission, which is handy for administrators, migration accounts, or
automated processes that should be able to save without leaving a note.

The module is deliberately tiny: it adds one settings form, one stored
configuration object, and two permissions, and it works only on content that uses
core's standard node form and revision system. There are no services, plugins, or
Drush commands to learn.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose which content types require a
   log message, the new-node option, and the two permissions.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Content authoring →
Require Revision Log Messages**
(`/admin/config/require-revision-log/adminsettings`). Reaching it requires the
*Administer require_revision_log_message* permission. Nothing is enforced until
you tick at least one content type there.
