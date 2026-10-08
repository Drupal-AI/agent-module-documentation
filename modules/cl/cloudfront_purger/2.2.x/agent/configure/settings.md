<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure CloudFront Purge

The module has **no dedicated admin route** (`configure: null`). Its purger config form
(`CloudFrontPurgerConfigForm`) is reached through **Purge**'s purger UI (needs `purge_ui`):
*Configuration → Development → Performance → Purge* → the CloudFront purger's settings. Everything it
sets lives in the `cloudfront_purger.settings` config object, so you can also set it directly.

## Settings keys (`cloudfront_purger.settings`)

```yaml
distribution_id: ''   # CloudFront Distribution ID (required to actually purge). Regex ^[a-zA-Z0-9]+$
aws_key: ''           # AWS access key (optional). Regex ^[A-Z0-9]*$
aws_secret: ''        # AWS secret (optional). Regex ^[A-Za-z0-9/+=]*$
disabled: true        # true = black-hole invalidations (mark SUCCEEDED, no AWS call)
```

Schema is `FullyValidatable` with the constraints above; `distribution_id` is `NotBlank` +
alphanumeric.

> The config form maps a **"Enabled"** checkbox to the **inverse** of `disabled`
> (`enabled = !disabled`). Ticking "Enabled" stores `disabled: false`.

### Set the distribution id

`settings.php` (kept out of exported config, good for per-environment values):

```php
$config['cloudfront_purger.settings']['distribution_id'] = 'ABCD1234';
```

or via drush / config:

```bash
drush config-set cloudfront_purger.settings distribution_id ABCD1234 -y
drush config-set cloudfront_purger.settings disabled 0 -y     # enable real purging
drush cget cloudfront_purger.settings
```

## AWS authentication

Handled by `CloudFrontClientFactory::createInstance()`:

1. If **both** `aws_key` and `aws_secret` are set in config, they are passed as explicit credentials.
2. Otherwise the AWS SDK's **default credential chain** is used, in order:
   - IAM roles (EC2/ECS instance profile),
   - environment variables (`AWS_ACCESS_KEY_ID` / `AWS_SECRET_ACCESS_KEY`),
   - a profile in `~/.aws/credentials`.

The IAM identity must be allowed the **`cloudfront:CreateInvalidation`** action. You can also set the
keys in `settings.php` the same way as `distribution_id`.

## Region / client options

Default client options come from a service parameter:

```yaml
# cloudfront_purger.services.yml
parameters:
  cloudfront_purger.cloudfront_client.options:
    region: ap-southeast-1
    version: latest
```

Override the region (CloudFront is global but the SDK wants a region) in your site's
`sites/default/services.yml`:

```yaml
parameters:
  cloudfront_purger.cloudfront_client.options:
    region: us-east-1
    version: latest
```

## Register the purger with Purge

Configuring credentials is not enough — the purger must be added to Purge's pipeline:

```bash
drush p:purger-lsa            # shows 'cloudfront' as an available plugin
drush p:purger-add cloudfront # creates a purger instance (stored in purge.plugins)
drush p:purger-ls             # confirm it is configured
```

This writes an entry under `purge.plugins` `purgers` (`{instance_id, plugin_id: cloudfront,
order_index}`). Then queue paths to purge — the module **suggests** `purge_queuer_url` to collect
URLs automatically — and let a Purge processor run (cron/drush). Directly test one path with:

```bash
drush p:invalidate path /some/page
```

## The `disabled` black hole

With `disabled: true` (the default), `CloudFrontPurger::invalidate()` logs "Invalidations were ignored
because the purger is disabled." and marks every invalidation **SUCCEEDED without calling AWS**. Use
this on staging/dev so the purge pipeline runs green without touching (or being billed by) AWS. Set
`disabled: false` only where you want real invalidations.
