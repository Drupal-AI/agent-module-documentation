# CKEditor Mentions — manual setup guide

**CKEditor Mentions** (`ckeditor_mentions`) brings `@`‑mentions to CKEditor 5 —
the smart autocomplete familiar from Slack, Jira, or Facebook. Type `@` in the
editor and a list of matching users appears; pick one and the inserted mention
becomes a link to that user. Two optional submodules extend it: mention arbitrary
entities (not just users), and display real names instead of usernames.

The value is the same as in any collaboration tool: mentioning a person creates a
reference the system can act on, rather than just a name typed into prose. Beyond
linking, the module exposes an event system (`ckeditor_mentions.rules.events.yml`)
so a mention can trigger a workflow — for example, a notification — through Rules
or ECA. That event integration is often the real reason to install it, rather than
the linking alone.

Access is controlled by a dedicated permission, **Use inline mentions**, which
turns the autocomplete on for a role. Grant it to the roles that actually author
content or comments, so the mention feature is available where you want it.

Requirements are modest: PHP 8.1 or newer, core **CKEditor 5** and **Image**, and
the `masterminds/html5` library for parsing (Composer pulls it in). The active
line is **3.x**, which supports CKEditor 5 only; the current release is a **beta**
(3.0.0‑beta6), so factor that in for production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and optional submodules, add the toolbar button per text format, and
   grant the mention permission.

There is **no standalone settings page** — you enable the feature per text format
and control access with the mention permission, both covered in Installation.

## Where it lives in the admin menu

Mentions is enabled per text format through the CKEditor 5 toolbar configuration at
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`). Access is controlled at **People →
Permissions** (`/admin/people/permissions`), where you grant the **Use inline
mentions** permission to the appropriate roles.

## How to use it

Once the feature is enabled on a format and a user has the mention permission, they
type `@` in a CKEditor 5 field, choose a match from the autocomplete list, and the
mention is inserted as a link. If you have installed the entity submodule they can
mention other entity types (such as taxonomy terms); with the realname submodule
the suggestions show real names rather than usernames. To act on mentions — say,
to email the mentioned user — wire the module's events to Rules or ECA.
