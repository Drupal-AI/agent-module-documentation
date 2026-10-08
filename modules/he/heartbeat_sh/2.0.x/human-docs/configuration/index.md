# Configuration

heartbeat.sh is configured on one settings form. Log in as a user with the
**`administer heartbeat_sh`** permission and go to **Configuration → Web
services → heartbeat.sh** (`/admin/config/services/heartbeat_sh/settings_form`).

## Before you start: create the beat

On the [heartbeat.sh](https://heartbeat.sh/) service, sign in and create a
**beat** for this site. Note your account **subdomain** and the **name** you gave
the beat — you'll enter both in Drupal.

## Settings

- **Subdomain** — your heartbeat.sh account subdomain. Together with the beat name
  it forms the URL Drupal pings:
  `https://<subdomain>.heartbeat.sh/beat/<name>`.
- **Cron beat name** — the name of the beat to signal. Use a distinct name per
  environment (for example a separate beat for staging and production) so you can
  tell which site went quiet.
- **Warning timeout** *(optional)* — how long heartbeat.sh should wait after the
  last beat before flagging a warning. Sent as a query parameter with each ping.
- **Error timeout** *(optional)* — how long to wait before escalating to an error
  alert. Also sent as a query parameter.
- **Cron enabled** — the toggle that turns the beats on. Leave it off while you're
  still setting up, and switch it on once the account details are correct.

Set the timeouts a comfortable margin above your actual cron interval, so a single
slightly-late run doesn't trigger a false alarm.

Save the form when you're done.

## Make sure cron runs

The module only pings when Drupal cron runs, so the whole feature depends on cron
firing on a dependable schedule. Prefer a real system cron (or your host's
scheduler / `drush cron` on a timer) over relying on occasional
visitor-triggered runs, which are irregular and would produce false "cron
stopped" alerts.

## Verify and troubleshoot

Run cron manually (`drush cron`) and confirm heartbeat.sh records the beat. The
module logs the response from heartbeat.sh, so if a beat isn't arriving, check
Drupal's log (**Reports → Recent log messages**) for the request result, and
double-check the subdomain, beat name, and that **Cron enabled** is switched on.
Communication uses HTTPS with standard TLS verification.
