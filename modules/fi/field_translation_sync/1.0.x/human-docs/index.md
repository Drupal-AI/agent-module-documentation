# Field translation synchronize — manual setup guide

**Field translation synchronize** (`field_translation_sync`) provides **actions to
copy field values from one of an entity's translations into its others**, so fields
that should stay identical across languages don't drift apart. It's built for
multilingual sites that carry several regional variants of the same language —
Colombian, Argentinian, and Mexican Spanish, say — where you want to author a
translation once and then push it across the others, still free to tweak each copy
afterwards. You bulk copy/paste from any language into any other, field by field.

The module works through Drupal's Action system and Content Translation, so it acts
on content (it modifies translation values when you run an action) and adds its own
permission to gate who may do so. It has no access‑control role beyond that
permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central settings form**. The feature is delivered as actions you run
on content, described in "How to use it" below.

## How to use it

1. Make sure your site is multilingual and the relevant content types are set up
   for translation (Content Translation).
2. Under **People → Permissions**, grant the module's permission to the roles that
   should be allowed to synchronize translation values.
3. Run the synchronize action to copy a field's value from a source translation
   into the target translation(s) — choosing which fields to sync. Because you can
   still edit each copy afterward, use it to seed near‑identical translations and
   then customize per language as needed.

> Because the actions modify translated content, try them on a non‑production copy
> first so you're comfortable with which fields get overwritten.
