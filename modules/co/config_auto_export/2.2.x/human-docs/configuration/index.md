# Configuration

All of Config Auto Export's behaviour is controlled from one settings form.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Development → Config Auto Export**, or navigate directly
   to `/admin/config/development/config_auto_export`.

Settings are stored in the `config_auto_export.settings` configuration object.

## Settings, field by field

- **Enabled** *(checkbox, default on)* — the master on/off switch for the module.
  Untick it to pause all automatic exporting.
- **Directory** *(text, default `temporary://cae`)* — where exported configuration
  changes are written. It accepts Drupal stream wrappers such as `temporary://`,
  `public://`, or `private://`. **Do not use a web-accessible location** — prefer
  `private://` or a temporary path. If you change this value, the previous export
  storage is removed.
- **Webhook** *(text, up to 1024 chars, default empty)* — the URL that receives a
  POST request when configuration changes are exported. Treat this URL as a
  credential.
- **Webhook params** *(YAML textarea, default empty)* — key/value pairs sent as the
  POST body of the webhook request. Use this to pass things like a target branch.
- **Webhook headers** *(YAML textarea, default empty)* — key/value pairs sent as
  HTTP headers with the webhook request. Use this for authentication tokens your
  receiving service expects.
- **Webhook autorun enabled** *(checkbox, default on)* — when on, the webhook fires
  automatically after configuration changes. When off, you trigger it manually from
  the trigger form (see below).
- **Delay** *(number of seconds, min 0, default 60)* — only relevant when autorun
  is on. Set to `0` to export changes immediately. A value greater than 0 means the
  export is triggered by the next feasible cron run after that period elapses — so
  **cron must be running** for delayed exports to fire.
- **Delay from first** *(checkbox, default off)* — only relevant when autorun is on.
  When ticked, the delay is measured from the *first* configuration change in a
  batch rather than the last, which bounds how long a burst of changes waits before
  being exported.

Click **Save configuration** when done.

## Webhook params and headers as YAML

Both **Webhook params** and **Webhook headers** are entered as simple YAML maps of
key/value pairs. The params become the POST body of the webhook request; the
headers are attached to that same request. Together they let you pass
authentication tokens, a target branch, or any other data your receiving service
needs.

## Triggering the webhook manually

If you turn **Webhook autorun** off, you fire the webhook yourself from the
module's trigger form. That action is protected by its own access-restricted
permission (`trigger config_auto_export`), so grant it only to the users who should
be able to push changes downstream on demand.

## Security reminders

- Keep the **export directory out of the web root**. Exported config can contain
  internal paths, endpoints, and email addresses.
- Treat the **webhook URL and any tokens** as secrets — prefer keeping them out of
  exported configuration; genuine secrets belong in a Key entity or environment
  variable.
- Remember the module records *every* change, not just deliberate ones, so a human
  review step before committing is still essential.
