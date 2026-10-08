# Configuration

The confirmation step works as soon as the module is enabled; the settings form
lets you control the wording shown on the confirm page.

## Open the settings form

1. Log in as a user with the **Administer Confirm Logout configuration**
   permission (`administer confirm_logout configuration`) — an administrator has it
   by default. You can grant it to another role at **People → Permissions**.
2. Go to **Configuration → People → Confirm Logout**, or navigate directly to
   `/admin/config/people/confirm-logout`.

## The settings

- **Confirmation title** — the heading shown on the confirm page. Because Token is
  a dependency, you can include tokens here (for example the site name or the
  current user's name) and they will be replaced when the page renders.
- **Confirmation message** — the body text shown beneath the title, explaining what
  is about to happen. This field is token‑enabled too, so you can personalise or
  brand it.

A token browser is available (provided by the Token module) to help you find and
insert the exact token strings, such as `[current-user:display-name]` or
`[site:name]`.

Because these are plain text settings stored as configuration, the message is also
translatable through Drupal's configuration translation, and the whole
configuration deploys cleanly between environments.

## Save

Click **Save configuration**. Log out (or visit `/confirm/logout`) to see your new
title and message on the confirmation page, with any tokens resolved.
