# Configuration

Liveness has a short settings form for *what* to monitor and *who* to notify, plus
a scheduling step so the checks actually run on a regular basis.

## Open the settings

1. Log in as an administrator.
2. Go to **Configuration → Development → Performance → Liveness**
   (`/admin/config/development/performance/liveness`).

## Environment URLs and probing

- **Environment URLs** — enter the URL for each environment you want to monitor.
  Each URL is an endpoint Liveness will probe to decide whether that environment is
  up.
- **Enable / disable probing** — turn probing on or off per environment (or
  globally), so you can pause monitoring for an environment without deleting its
  configuration.

## Notification emails

Enter the **email addresses** that should be notified when an environment goes down
and when it recovers. These are the recipients of the outage and recovery alerts.

## Save

Save the form. Your environments and notification recipients are now stored.

## Schedule the checks

Liveness is designed to be run repeatedly on a schedule. There are two ways to
drive it.

**Drush command:**

```bash
drush liveness:check https://example.com example-environment
```

This checks the configured environments and merges the logs.

**Standalone PHP command (recommended by the module):** Liveness ships a PHP script
that wraps the check and can log outage/recovery events even if the Drupal database
is down — which is exactly when you most want the alert. It takes the path to your
Drupal installation, the URL to check, and an environment name:

```bash
php /path/to/drupal/modules/contrib/liveness/liveness.php /path/to/drupal https://example.com example-name
```

## Set up cron

Add crontab entries so the checks run automatically at regular intervals. For
example, running three environments a minute apart each hour:

```cron
# MIN HOUR DOM MONTH DOW  CMD
1 * * * * php /path/to/drupal/modules/contrib/liveness/liveness.php https://example.com  environment-name
2 * * * * php /path/to/drupal/modules/contrib/liveness/liveness.php https://example2.com environment-name2
3 * * * * php /path/to/drupal/modules/contrib/liveness/liveness.php https://example3.com environment-name3
```

Edit your crontab with `crontab -e` and adjust the paths, URLs, environment names,
and intervals to suit your setup. Also make sure Drupal's own cron runs regularly.
With the schedule in place, Liveness will probe your environments and email the
configured recipients on outages and recovery.
