# Message Filter — manual setup guide

**Message Filter** (`message_filter`) gives you control over which of Drupal's
status messages — the green "saved", yellow warnings and red errors that appear at
the top of the page — actually reach each user. Out of the box Drupal shows every
message to everyone, which often means end users and editors see technical
notifications meant for developers. Message Filter lets you filter those messages by
**user role**, by **message type**, and by **route or URL path**, so each audience
sees a cleaner, more relevant interface.

The typical use is to shield non-technical users from noise while keeping everything
visible to administrators: hide technical warnings from editors and visitors, keep
public-facing pages tidy, or prevent information overload on specific workflows like
login or content creation. A priority/level system resolves conflicts for users who
hold several roles, and a built-in debug panel helps you confirm your rules behave as
intended.

The module depends only on Drupal core's System module — there are no other module or
library requirements — and it works on Drupal 10 and 11 (PHP 8.1+). It does **not**
work automatically on enable: nothing is filtered until you switch filtering on and
define at least one rule on the settings form.

One caution the module's own guidance stresses: filter only cosmetic or technical
messages. Do not suppress messages users genuinely need, such as validation errors or
confirmations that an action succeeded. Message Filter is a presentation aid, not an
access-control feature.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and grant the administration permission.
2. [Configuration](configuration/index.md) — switch on filtering and build your
   role-based rules, field by field.

## Where it lives in the admin menu

Once enabled, its settings form sits at **Configuration → System → Message Filter**
(`/admin/config/system/message-filter`). Access to that form is gated by the
**Administer message filter** permission, which you grant at
**People → Permissions** (`/admin/people/permissions`).
