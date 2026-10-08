# Modal — manual setup guide

**Modal** (`modal_page`) lets site builders create configurable dialog / pop-up
windows — announcements, notifications, cookie notices, lightboxes, or fully custom
content — that appear on chosen pages, targeted by path, role and language, all
without writing code. Each dialog is created and managed from the admin UI and can
be styled, scheduled, and dismissed by visitors.

Every modal you create is a small configuration entity managed at **Structure →
Modal**. A modal carries a rich set of options: a title and formatted body, the
paths it shows on (with wildcard support and `<front>`), which roles and languages
see it, whether it opens automatically on load or when a CSS element is clicked, its
size, header/footer/button toggles, custom CSS classes, an optional "don't show
again" cookie, ESC-key and click-outside close behavior, an optional redirect link,
auto-hide, show-once, an embedded video link, and scheduling (publish/unpublish
dates). This makes it flexible enough for anything from a GDPR cookie banner to a
marketing splash or a newsletter-signup prompt.

Alongside the per-modal settings there is a single **global settings** page that
controls site-wide behavior — chiefly whether the module should auto-load Bootstrap
(and which version), the HTML tags allowed in modal bodies, whether to clear caches
when a modal is saved, and the default cookie lifetime. Scheduled modals are driven
by a Drush command (`modal_page:cron`) or an HTTP cron endpoint, and developers can
alter or handle modals through three hooks. The module defines one permission,
*Administer Modal*, and depends on core's Filter and Datetime modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — creating and tuning individual modals,
   and the global settings page, field by field.

## Where it lives in the admin menu

Once enabled, the module has two homes in the admin area:

- **Structure → Modal** (`/admin/structure/modal`) — the list of your modals, where
  you add, edit and delete them. This is where the day-to-day work happens.
- **Configuration → User interface → Modal settings**
  (`/admin/config/user-interface/modal-page/settings`) — the global settings that
  apply to every modal (Bootstrap loading, allowed HTML tags, cache-clearing, the
  default cookie lifetime).

Both pages require the **Administer Modal** permission. See
[Configuration](configuration/index.md) for a walkthrough of each.
