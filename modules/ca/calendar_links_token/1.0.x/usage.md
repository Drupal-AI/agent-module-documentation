<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Calendar Links Tokens provides a single dynamic token that renders "add to calendar" links (Google, Yahoo, Outlook.com) plus a downloadable `.ics` file for an event described by a node's fields or literal values.

---

The module implements `hook_token_info()`/`hook_tokens()` to expose one token type, `calendar_links`, with a dynamic `parameters` token. When the token `[calendar_links:parameters:nid|start|end|title|description|location]` is replaced, the module loads the given node, resolves each of the five remaining pipe-separated arguments as either a field name on that node (its value is used) or, if the node has no such field, as a literal string. It feeds the resolved start/end datetimes, title, description and location into the `spatie/calendar-links` PHP library and emits a small block of HTML: `Google | Yahoo | Outlook.com | iCal & Outlook` links. The Google/Yahoo/Outlook links are hosted calendar URLs; the iCal link points to a generated `.ics` file the module writes to the public files directory. There is no admin UI, no route, no permission and no configuration — you place the token wherever token replacement runs (node body/fields, views, email templates, and especially webform confirmation/notification emails for event registrations).

---

- Add "add to calendar" links (Google, Yahoo, Outlook.com, iCal) to an event node's display.
- Insert calendar links into an event registration webform's confirmation email.
- Insert calendar links into an event registration webform's notification email to attendees.
- Turn a node's start/end date fields into a Google Calendar link.
- Turn a node's start/end date fields into a downloadable `.ics` invite.
- Build calendar links from a node's title, body and venue/location fields.
- Build calendar links from literal date/title/location strings without any node fields.
- Mix node fields and literal strings in one token (e.g. real date fields but a hardcoded location).
- Provide a one-click "add this event to your calendar" block in an event's body text.
- Include calendar links in a Views field or rewrite-results token output.
- Include calendar links in a node template via a token filter.
- Offer attendees an Outlook.com "add to calendar" link.
- Offer attendees a Yahoo Calendar "add to calendar" link.
- Generate an iCal/Outlook desktop `.ics` download for an event.
- Reuse the same token across multiple content types that share date field names.
- Populate a reminder/confirmation email with per-event calendar links using the recipient's event node id.
- Render calendar links inside any text that passes through Drupal's token replacement.
- Provide calendar links for a single fixed event node with a hardcoded nid.
- Localize the event start/end using the site's configured default timezone when passing literal date strings.
- Produce calendar links for events whose datetime is stored in a core `datetime` field.
- Generate calendar links for events whose date/title/location are plain text (string) fields.
