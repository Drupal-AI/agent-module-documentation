# Webform Autosave — manual setup guide

**Webform Autosave** (`webformautosave`) saves a Webform submission as a draft
automatically as the user fills it in — no "Save draft" click required. Whenever
an input changes, the module waits a short, configurable moment and then quietly
saves the submission in the background, so a long or multi‑step form isn't lost
if the user navigates away or their session drops.

It also offers optional **optimistic locking**. On submissions that more than one
person might edit, this warns an editor when someone else has changed the same
submission since they loaded it, and gives them a reload link instead of silently
overwriting the newer data.

The clever part is that the module adds no endpoints of its own. It works entirely
through Webform's existing draft‑save machinery: it injects a hidden draft‑submit
button and a small piece of JavaScript that clicks it after each change, so the
save goes through Webform's standard AJAX flow. That means access control stays
exactly as core Webform defines it — a user's autosaved draft is never exposed to
anyone else by this module.

There's no separate settings page. You switch autosave on **per webform** (or set
a global default) from the webform's own settings, under a "Webform auto‑save
settings" section. One thing to be aware of: turning autosave on will
automatically adjust that webform's draft, purge, and submission‑log settings so
the feature has what it needs to work.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Webform
   dependencies with Composer, and enable it.
2. [Configuration](configuration/index.md) — turn autosave (and optimistic
   locking) on for a webform and tune the timing.

## Where it lives in the admin menu

There is no dedicated admin page. You configure autosave from within each webform:
edit the webform, then go to **Settings → General** and find the *Webform
auto‑save settings* section. You can also set site‑wide defaults from the global
Webform settings' third‑party settings section.
