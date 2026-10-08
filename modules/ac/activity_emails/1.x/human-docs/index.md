# Activity Emails — manual setup guide

**Activity Emails** (`activity_emails`) sends a plain notification email to an
address you choose every time a **node** or a **user** is created or updated. It
is a lightweight change-notification tool — a low-effort way for a small
editorial team to keep an eye on what's changing on the site.

When you enable it and set a recipient, the module watches for node and user
saves. Each time one happens, it emails the recipient a short message built from
your template text plus the changed item's address (its absolute URL) and the
name and email of the user who made the change. It deliberately skips a couple of
cases: changes made by anonymous users, and entities that have no canonical URL
(such as paragraphs), so you don't get noise for things that aren't really pages.

It is worth being clear about what this is *not*. It is not a full audit log:
there's no per-content-type filtering beyond "nodes and users", no digest, and no
stored history — just one email per save. Delivery is synchronous and goes
through your site's normal mail system, so on a busy site it means one email sent
per save. Because the acting user's email address is included in the message
body, treat the recipient inbox as trusted. It runs on Drupal 8 through 12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — turn notifications on, set the
   recipient(s), and customise the message template.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Activity Emails**
(`/admin/config/system/activity_emails`), reachable by users with the
**Administer site configuration** permission.
