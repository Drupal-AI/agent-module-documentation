# Cancel Button — manual setup guide

**Cancel Button** (`cancel_button`) adds a **Cancel** button next to **Save** on
entity add and edit forms, and sends the editor somewhere sensible when they click
it. It removes the familiar "how do I get out of this form without saving?"
friction for content teams, and saves you from writing custom `form_alter` code to
add a cancel link yourself.

When Cancel is clicked, the module works out where to go using a clear order of
preference: (1) any redirect the form set internally, (2) the `?destination=`
parameter on the URL, (3) the page the user came from (HTTP referer), (4) the
entity's own view page if it has one, and finally (5) a fallback path you configure
per content type. That last fallback matters mainly for *add* forms, where the
entity doesn't exist yet and so has no page to return to.

The redirect rides on Drupal core's normal redirect handling — the `destination`
parameter is sanitised by core to internal paths — so the button does not introduce
an open‑redirect of its own. Its configuration is gated behind a dedicated
permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the per‑content‑type fallback
   destinations.

## Where it lives in the admin menu

Its settings form sits at **Configuration → Content authoring → Cancel Button**
(`/admin/config/content/cancel-button`, route `cancel_button.admin_settings`),
behind the **Administer cancel button configuration**
(`administer cancel button configuration`) permission. The Cancel button itself
appears automatically on entity add/edit forms once the module is enabled.
