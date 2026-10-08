# Configuration

Dropsolid Purge has **no admin form and no configure route**. You configure it
in two places: an array in your site's `settings.php`, and the Purge framework's
own UI (or Drush) where you enable the purger.

## 1. Load balancer and site settings (settings.php)

Add a `dropsolid_purge.config` array to `settings.php`. This tells the module
which Varnish servers to talk to and how to identify this site:

```php
$config['dropsolid_purge.config'] = [
  'site_name'        => 'Somename',            // also the default auth token, and part of the site id
  'site_environment' => 'local',               // e.g. local / dev / stage / prod
  'site_group'       => 'DropsolidSolutions',
  'loadbalancers'    => [
    'varnish' => [
      'ip'       => '127.0.0.1',               // required
      'protocol' => 'http',                    // optional, defaults to http
      'port'     => '8080',                    // optional, defaults to 80
    ],
    // add more entries to purge multiple balancers
  ],
];
```

Each load-balancer entry becomes a `protocol://ip:port` address; an entry with no
`ip` is skipped. Every BAN request is sent to all of the resulting addresses.

The combination of `site_name`, the site path, `site_environment`, and
`site_group` produces the unique site identifier that Varnish uses to ban only
this site's objects — so give each environment its own `site_environment` value
to keep local, staging, and production caches separate.

## 2. Auth token (optional)

```php
$settings['dropsolid_purge_token'] = 'a-shared-secret';  // defaults to site_name if unset
```

This token is sent with the BAN requests so Varnish can authenticate them. If you
leave it out, the site name is used as the token.

## 3. Enable the purger in Purge

The purger is a Purge plugin, so you add it through the Purge framework rather
than through this module:

```bash
drush p:purger-add dropsolid_purge      # creates a purger instance
drush p:purger-ls                       # list configured purgers
```

Or in the UI: go to **Configuration → Development → Performance → Purge**
(`/admin/config/development/performance/purge`), choose **Add purger**, and pick
**Dropsolid Varnish Purge**.

Then pair it with a Purge **processor** so queued invalidations actually get
sent. The module's README recommends enabling both the **cron** and
**lateruntime** processors.

## Verify it worked

```bash
drush cget dropsolid_purge.config       # confirm your site_name / loadbalancers
drush cget purge.plugins                # confirm a dropsolid_purge purger is present
drush p:diagnostics                     # the 'Dropsolid Purge' check must be green
```

The purger will not load until its configuration is complete, so a green
diagnostic check is your signal that everything is wired up. Finally, apply the
bundled example VCL to your Varnish servers so they carry out the BAN logic.
