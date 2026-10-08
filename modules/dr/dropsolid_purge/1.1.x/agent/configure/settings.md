# Configuring Dropsolid Purge

There is **no admin form and no configure route**. Configuration is the `dropsolid_purge.config`
array (read via `\Drupal::config('dropsolid_purge.config')`), normally set in **`settings.php`** as a
config override, plus enabling the purger inside Purge.

## 1. Load balancer / site config (settings.php)

```php
$config['dropsolid_purge.config'] = [
  'site_name'        => 'Somename',            // also the default auth token & part of the site id
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

`HostingInfoFactory::getLoadBalancers()` turns each entry into a `protocol://ip:port` URI (an entry
with no `ip` is skipped). The `everything`/`tag` BANs are sent to every resulting URI.

## 2. Auth token (optional)

```php
$settings['dropsolid_purge_token'] = 'a-shared-secret';  // defaults to site_name if unset
```

Sent so Varnish can authenticate the BAN request.

## 3. Enable the purger in Purge

The purger is a Purge plugin — add it through the Purge framework, not this module:

```bash
drush p:purger-add dropsolid_purge      # creates a purger instance
drush p:purger-ls                       # list configured purgers (shows instance_id + plugin_id)
```

Or via UI at `/admin/config/development/performance/purge` → *Add purger* → **Dropsolid Varnish
Purge**. Purgers are stored in Purge's own config `purge.plugins` under `purgers:` as
`{ instance_id, plugin_id: dropsolid_purge, order_index }`.

Pair it with a Purge **processor** (the README recommends both the **cron** and **lateruntime**
processors) so queued invalidations are actually sent.

## Reading current config

```bash
drush cget dropsolid_purge.config          # site_name, loadbalancers, ...
drush cget purge.plugins                    # confirm a dropsolid_purge purger is present
drush p:diagnostics                         # 'Dropsolid Purge' check must be green (fully configured)
```

Note: because the config normally comes from `settings.php`, `drush cset dropsolid_purge.config …`
also works to seed a plain config object (what the module reads with `->get()`), but a settings.php
override always wins at runtime.
