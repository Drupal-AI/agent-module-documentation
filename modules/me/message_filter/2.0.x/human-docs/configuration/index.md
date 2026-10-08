# Configuration

Message Filter does nothing until you configure it. This page walks through switching
filtering on and building the rules that decide which status messages each role sees.

## Open the settings form

1. Log in as a user with the **Administer message filter** permission.
2. Go to **Configuration → System → Message Filter**, or navigate directly to
   `/admin/config/system/message-filter`.

## Enable message filtering

At the top of the form is the master switch:

- **Enable message filtering** — until this is ticked, the module stays completely
  inactive and every status message displays as normal. Tick it to activate the rules
  below.

## Role-based filtering rules

The heart of the form is a **Role-based Filtering Rules** section with a block of
settings for each user role (administrator, editor, contributor, anonymous visitor,
and any custom roles). For each role you can:

- **Enable filtering for the role** — turn the rules on for that role only. Roles you
  leave disabled keep seeing all messages.
- **Block all messages, or select specific types** — choose to suppress *every*
  notification for that role, or narrow it to particular message types. The message
  types are **status** (the green success messages), **warning** (yellow) and
  **error** (red). For most audiences you would hide status and warning while leaving
  errors visible.
- **Routes and URL paths to filter** — restrict the rule to specific pages. Enter one
  route or path per line; wildcards are supported so you can target whole sections of
  the site (for example a path pattern that covers an entire workflow). Use this to
  keep, say, the login page or content-creation forms free of technical noise.
- **Priority level** — a number that resolves conflicts when a user holds more than
  one role. If two roles disagree about whether a message should show, the level
  system decides which rule wins, so a user with several roles gets predictable
  behavior.

## Debug information

The form includes a built-in **debug/logging panel**. Use it while you are setting up
to confirm your rules are matching the routes and roles you expect before you rely on
them. It is a diagnostic aid — you can ignore it once your configuration is settled.

## Save

Click **Save configuration**. Filtering takes effect immediately for the roles and
pages you targeted. Test as a non-administrative user (or in a private browser
window) to confirm the right messages are hidden — and, just as importantly, that
errors and validation messages users need are still getting through.
