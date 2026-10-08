# Email Contact — manual setup guide

**Email Contact** (`email_contact`) adds two display formatters for core **Email**
fields that show a small **contact form** instead of exposing the address itself. A
visitor can message the address behind the field — filling in a name, email, subject and
message — without ever seeing (or being able to scrape) the actual email address.

This is a friendlier, spam-safer alternative to a plain `mailto:` link. Instead of
printing an author's or department's email address on the page, you display either a
**link** (optionally opening the form in a modal dialog) or an **inline** form embedded
right in the page. When someone submits it, Drupal sends the message to the field's
address with the visitor's own address set as reply-to, so staff can reply directly. The
address is never rendered, and the form validates input and blocks email header-injection
attempts.

The two formatters are:

- **Email contact link** (`email_contact_link`) — a link (or AJAX modal) to the contact
  form, with configurable link text and page/modal title.
- **Email contact inline** (`email_contact_inline`) — the contact form embedded directly
  in the field's output, with a configurable post-submit redirect.

Both can optionally include the submitter's name and email in the message body and
prepend an "additional message" that supports **tokens** when the Token module is
installed. Access simply follows normal entity and field view access — there's no
special permission and no global settings page; everything is configured per field on its
*Manage display* screen.

This guide is written for a **human** setting the module up through the admin UI. If you
want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.
2. [Configuration](configuration/index.md) — apply a formatter to an email field and set
   its options (link text, modal, redirect, message body, tokens).

## Where it lives in the admin menu

There is no global settings page. You configure Email Contact per field wherever you
manage an entity's display — **Structure → (content type / entity) → Manage display** —
by choosing one of the two Email Contact formats for an email field.
