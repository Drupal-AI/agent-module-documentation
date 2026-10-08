<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Forward adds an "email this page to a friend" capability to any entity: a Forward form (and a field formatter that renders a link or an inline form) that emails a rendered view of the entity to one or more recipients, with token-driven subject/body, flood control, per-recipient limits, and forward statistics.

---

The module exposes a Forward form at `/forward/{entity_type}/{entity}` (route `forward.form`,
permission `access forward`, plus `_entity_access: view`) built by `Form\ForwardForm` /
`Services\ForwardFormBuilder`. The visitor supplies their name, email, recipient address(es) and an
optional personal message; the entity is rendered (in a `forward`, `teaser`, or `full` view mode) as the
**anonymous** user — the form switches to an `AnonymousUserSession` before rendering unless
`forward_bypass_access_control` is set — and mailed via the mail manager using a `forward` mail plugin
(`Plugin/Mail/ForwardMail`, key `send_entity`/`mail_entity`; SMTP etc. are respected). Subject, header,
footer and confirmation text are token-replaced (`[forward:*]`, `[site:*]`), and the module registers a
`forward` token group (`forward.tokens.inc`). Two field formatters expose the feature on entity displays:
`forward_link` (a "Forward" link, styled text/icon) and `forward_form` (the form inline); there is also a
`forward` field type/widget. Sending is protected by flood control (`forward_flood_control_limit`, default
10/hour, bypassable with the restricted `override flood control` permission) and a `forward_max_recipients`
cap (default 1). Every send is logged to `forward_log` and aggregated in `forward_statistics`, both
surfaced through provided Views (`forward_logs`, `forward_statistics`) and migrate source/destination
plugins. Symfony/Rules events (`EntityPreforwardEvent`, `EntityForwardEvent`) and hooks
(`hook_forward_token`, `hook_forward_mail_pre_render_alter`, `hook_forward_mail_post_render_alter`,
`hook_forward_entity`) let other modules extend the flow. Global settings live at
`/admin/config/user-interface/forward` (route `forward.settings`, permission `administer forward`).

---

- Add a "Forward to a friend" link to nodes, taxonomy terms, or any entity.
- Let visitors email a rendered page to one or more friends.
- Render the forwarded entity as it appears to anonymous users (respecting view access).
- Show the Forward link via a field formatter on the entity display.
- Embed the Forward form inline on the entity page via the form formatter.
- Customise the email subject/header/footer with tokens (`[forward:sender-name]`, `[site:name]`).
- Allow a short personal message from the sender, optionally with limited HTML.
- Cap the number of recipients per send (default 1).
- Rate-limit forwards per hour with flood control to reduce abuse.
- Let trusted roles bypass flood control via the `override flood control` permission.
- Let logged-in users change the sender email with the `override email address` permission.
- Offer a plain-text vs HTML email choice to the sender.
- Track how many times each page has been forwarded (statistics).
- Report a log of all forwards (who, what, when, from which IP) via the provided View.
- Use a dedicated `forward` view mode to control exactly what gets emailed.
- Apply a filter format (e.g. Pathologic) to fix relative links in the email body.
- Trigger a Rules reaction after an entity is forwarded (Rules events provided).
- Add custom tokens to the email via `hook_forward_token`.
- Alter the email render array or final body via the pre/post render hooks.
- Redirect the user somewhere specific after forwarding via `hook_forward_entity`.
- Migrate legacy forward logs/statistics using the provided migrate plugins.
- Send through SMTP/other transports automatically when such a module is enabled.
- Localise the forwarded email using the entity's language.
