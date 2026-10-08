# Module Missing Message Fixer — manual setup guide

**Module Missing Message Fixer** (`module_missing_message_fixer`) cleans up
"ghost" modules — the leftover schema records Drupal keeps for modules whose code
was deleted from disk without being properly uninstalled. Those records produce
the nagging *"The following module is missing…"* / *"invalid or missing"*
warnings on your status report, and this module gives you a UI (and Drush
commands) to find and delete them.

Here is what causes the problem. When you remove a module's files without running
an uninstall first, Drupal still has that module's schema version stored in the
`key_value` database table under the `system.schema` collection. Drupal notices
the code is gone but the record remains, and it keeps complaining. This module
reads every `system.schema` entry, checks whether each name still maps to an
installed extension on disk, and flags the ones that don't as ghosts.

From the admin form you tick the ghosts you want to clear and press **"Remove
These Errors!"** — the module deletes those stale schema rows and also removes any
leftover configuration objects named after the missing module (`<module>.*`). The
same work can be done from the command line with two Drush commands, which is
handy for scripting cleanup in CI or on a rebuilt database.

Because this tool mutates key-value state and can delete configuration, always
run it on a dev or staging copy first and re-export your configuration
afterwards.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the fixer form and the two Drush
   commands, step by step.

## Where it lives in the admin menu

The fixer sits at **Configuration → System → Module Missing Message Fixer**
(`/admin/config/system/module-missing-message-fixer`). Access is gated by the
**Administer module missing message fixer** permission.

## How to use it

Open the form, review the list of ghost modules it detected, select the ones you
want to clear, and press **"Remove These Errors!"** Prefer the command line?
`drush mmmfl` lists the ghosts and `drush mmmff <name>` (or `--all`) removes them.
See [Configuration](configuration/index.md) for the details of each.
