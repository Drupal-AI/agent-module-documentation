# Taxonomy Preferences — manual setup guide

**Taxonomy Preferences** (`taxonomy_preferences`) provides a front-end block where a
visitor ticks the taxonomy terms they care about, and stores their choices in the
browser **session** so a View can filter content to match. It is a lightweight,
login-optional way to personalize a listing: a visitor picks a few topics, and a
"recommended for you" style View shows content tagged with those terms.

The way it fits together: an administrator uses the settings page to choose which
taxonomy terms are offered to visitors (a curated subset of a vocabulary) and,
optionally, an instruction message to show above the checkboxes. The block renders
those terms as checkboxes; when a visitor submits, their selected term IDs are saved
into `$_SESSION['taxonomy_preferences']['preferences_key']` as a `+`-joined string,
along with a visibility flag. Because storage is session-based, preferences last for
the browser session without ever writing to the database. Term labels and the message
are shown translated in the current content language.

The module is **designed to pair with Views Extender / Views Extra**, which can feed a
session variable into a View as a contextual filter — that is what turns the stored
preferences into a filtered content listing. It depends on core **Locale** and
**Config Translation** (so the offered terms and message can be translated), and it
provides two permissions.

One thing worth knowing: the block's submit route is gated only by the core *access
content* permission, so it is effectively available to anonymous visitors. That is
appropriate here, because the only thing a submission changes is the **visitor's own
session** — there is no server-side or business-data mutation. The optional admin
*user message* is rendered as raw markup, so treat it as trusted administrator/config
input.

The module needs configuration before it is useful — you pick the terms, place the
block, and (optionally) wire a View to the session variable.

This guide is written for a **human** using the admin UI. If you are an AI coding
agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose the offered terms, place the
   block, and connect a View.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Taxonomy Preferences**
(`/admin/config/system/taxonomy_preferences`, route
`taxonomy_preferences.settings`). The preferences block itself is placed through
**Block Layout**. See [Configuration](configuration/index.md) for the full setup.
