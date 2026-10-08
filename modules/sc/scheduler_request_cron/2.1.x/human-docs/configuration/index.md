# Configuration

Scheduler Request Cron has just two settings, and both come with sensible
defaults — so the module works as soon as it is enabled. You only need this form
if you want to change how often the request-based cron may run, or to switch on
logging.

## Open the settings form

Log in as a user with permission to administer the site's configuration, then
open the module's settings form (stored as the `scheduler_request_cron.settings`
configuration). The form exposes the two options below.

## Interval

The **minimum interval, in minutes, between executions.** The lightweight cron is
only ever triggered when someone requests a page — and only if at least this many
minutes have passed since it last ran. The default is **5 minutes**.

- A **lower** value makes scheduled publishing/unpublishing feel more immediate,
  but runs the lightweight cron more often, adding a little more work to page
  requests.
- A **higher** value reduces that per-request overhead at the cost of slightly
  less precise timing.

Choose a value that balances how promptly your scheduled content needs to appear
against how much extra work you want on page requests.

## Log

A checkbox that **enables logging of each cron execution** (in addition to
Scheduler's own log). The default is **off (false)**. Turn it on temporarily if
you are troubleshooting and want to confirm that the request-based cron is firing
as expected, then turn it back off to avoid filling the log on a busy site.

## Save

Save the form to apply your changes. The new interval takes effect on subsequent
page requests.
