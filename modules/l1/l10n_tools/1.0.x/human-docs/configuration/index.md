# Configuration

L10n Tools has no settings to save — it's an **action tool**. Each tab shows you a
set of translation‑table rows and offers to delete them. Because the operations are
destructive, treat this page as you would a database maintenance task.

> **Back up your database first.** Custom translations entered by hand in the UI
> exist only in the database and cannot be re‑downloaded. If the tool deletes one
> as "orphaned", it's gone. A backup is your only undo.

## Open the tool

1. Log in as a user with the **access l10n_tools form** permission.
2. Go to **Configuration → Regional and language → L10n Tools**.

## The tabs

### Equal translations

Lists every translation whose translated text is *identical* to its source string —
for example an English source that was "translated" into English unchanged. These
add rows without adding value. If any are listed, an option appears to **delete the
listed translations** (the source strings themselves are kept). Note that after you
delete equal translations, those source strings will subsequently show up under the
Orphan / Untranslated tab, because they now have no translation.

### Orphan / Untranslated translations

Lists translation entries where the source string has no translated string, or the
translation is empty. If any are listed, an option appears to **delete those
entries**. Be deliberate here: a string that looks orphaned may belong to a module
that is only temporarily uninstalled or enabled on another environment.

### Reset translation status

Resets the translation‑update *status* rather than deleting translated strings. It
clears each project's recorded translation status and resets the `locale_file`
timestamp, the per‑project last‑checked date, and the overall last‑checked date, so
Drupal will re‑check localize.drupal.org for available updates. This tab also offers
a button to **check for available translation updates manually**.

## Drush

Per the project, the same cleanup tasks are also available as Drush commands, which
is handy for scripting maintenance or running cleanups on servers where you prefer
the command line. Whichever route you use, the same backup caution applies.
