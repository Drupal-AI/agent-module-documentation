# Configuration

## Open the settings form

Go to **Configuration → Regional and language → Timezone detect**
(`/admin/config/regional/timezone_detect`). You need the **Administer site
configuration** permission. The form has just two options.

## Mode — when to set the user's timezone

This controls how aggressively the module updates a user's stored timezone:

- **Default** *(recommended, and the install default)* — set the timezone on login
  **only if the user doesn't already have one**. This never overrides a choice a user
  made themselves; it just fills in the gap for people who never set one. For this
  mode to actually do anything, your site's default user timezone must be
  configurable and left empty — see the note below.
- **Login** — update the timezone on **every** login. This overwrites any manual
  choice each time, which suits kiosks or shared machines where whoever logs in
  should get the local timezone.
- **Always** — update the timezone whenever the detected value changes, on **any**
  page load. Good for users who travel and change locations often; it also
  overwrites manual choices.

## Log timezone changes (watchdog)

A checkbox, **on by default**, that writes a log entry every time the module sets a
user's timezone. Handy for auditing while you roll the module out; turn it off later
to keep your logs quiet.

## Setting both options with Drush

```bash
drush config:set timezone_detect.settings mode always -y
drush config:set timezone_detect.settings watchdog 0 -y
```

## Important: make the recommended mode work

If you use the **Default** mode, Drupal's status report
(`/admin/reports/status`) will show an **error** unless your site's default user
timezone is both configurable and empty. The reason: if new users are already given a
non-empty timezone at registration, the "only set it if it's empty" rule never
triggers and detection never runs.

To fix it, go to **Configuration → Regional and language → Date and time**
(`system.date`) and set:

- **Users may set their own time zone** — enabled (configurable).
- **Default time zone → Time zones users see when their own is not known** — choose
  the **empty** option (leave new users with no timezone).

The **Login** and **Always** modes don't depend on this setting, so they work
regardless.

## How it works behind the scenes

For reference, once configured the flow is: on login (or on every page in *Always*
mode) the module attaches its JavaScript and hands the browser the account's current
timezone plus a CSRF token. The `jstz` library determines the browser timezone and,
if it differs, POSTs it back to `/timezone-detect/ajax/set-timezone`. Drupal
validates the CSRF token, confirms the value is a real IANA timezone identifier, and
saves it to the user's account (logging the change if the watchdog option is on).
