# Configuration

All scheduling happens at **Configuration → Development → Maintenance Windows**
(`/admin/config/development/maintenance-windows`). You need the **Administer
maintenance_window configuration** permission to open it.

## Schedule a window

Add a maintenance window by providing:

- **Start time** — when the site should automatically enter maintenance (or
  read-only) mode.
- **End time** — when the site should automatically come back out again.
- **Message** — the text shown to visitors while the window is active. Use it to
  explain what's happening and roughly when the site will return.
- **Mode** — normally Drupal's core **maintenance mode**. If the
  [Read Only Mode](https://www.drupal.org/project/read_only_mode) module is
  installed, you can instead choose **read-only mode**, which keeps content
  readable while blocking changes.

You can schedule more than one window; each is managed independently.

## How the timing actually fires

The module does not use a real-time timer — it acts on **cron runs**. On each
run its `hook_cron` implementation checks the current time against your windows
and enables, disables, or cleans up maintenance mode accordingly. The practical
consequence: a window opens or closes on the first cron run at or after the
scheduled moment, so your cron frequency sets the precision. If you need a window
to start exactly on time, make sure cron runs frequently (for example every
minute) around that period.

## Start or end a window manually

The same interface lets you **manually start or end** a window without waiting
for its scheduled time — handy when maintenance work finishes early, or when you
need to take the site down immediately. Ending a window manually brings the site
back out of maintenance mode straight away.

## Save

Save your window from the form. Once saved and with cron running, the site will
enter and leave maintenance mode on its own at the times you set.
