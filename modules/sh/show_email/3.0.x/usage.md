Show Email makes the user account's email address a configurable display component and adds a "Show email address" field formatter so a user's email can be shown on their profile, optionally as a mailto link, with the ability to hide it for user 1 or for chosen roles.

---

Core normally hides the user `mail` base field from the display. This module's `hook_entity_base_field_info_alter()` marks the user `mail` field as display-configurable, so it appears on *Configuration » People » Account settings » Manage display*, where you enable it and pick the **Show email address** formatter (`ShowEmailAddress`, applicable only to `email` fields on the `user` entity). The formatter has three settings: **Hide user one** (default on — never show the super-admin's email), **Hide per role** (a checkboxes list of roles; if the *account being viewed* has any selected role, its email is suppressed), and **Enable mailto link** (wrap the address in an `<a href="mailto:…">`). Whether a given viewer sees the email is still governed by core: the user profile/field must be viewable by that viewer and the display component enabled — this module does not add its own view permission, it only adds these hide toggles on top. Settings are stored per view-mode in the user entity's display config (schema `field.formatter.settings.show_email_address`). No admin page of its own, no permissions, no Drush.

---

- Show a registered user's email address on their profile page.
- Render the email as a clickable `mailto:` link.
- Render the email as plain text (mailto disabled).
- Always hide the super administrator's (user 1) email address.
- Hide the email for accounts holding a specific role (e.g. hide staff emails).
- Hide emails for several roles at once via the checkboxes list.
- Show emails only in a specific view mode (e.g. "Full" but not "Compact").
- Expose the email in a custom user view mode you created.
- Combine with core field/profile access so only certain viewers reach the profile at all.
- Display member contact emails in a members directory built on user view modes.
- Let site admins verify a user's email inline on the profile without editing the account.
- Provide a support-contact email on staff profile pages.
- Toggle email visibility site-wide by enabling/disabling the display component.
- Keep the email hidden by default and reveal it only where explicitly configured.
- Present the email consistently through Drupal's field display pipeline rather than custom code.
- Switch between mailto and plain-text presentation per view mode.
- Use the formatter summary to confirm at a glance whether user 1 and mailto are on.
- Suppress the email for the anonymous-adjacent/low-trust roles while showing it to others via view-mode choice.
