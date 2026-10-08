# Configuration

CloudFront Purge has **no dedicated admin page**. Its settings form is reached
through Purge's own purger UI (you'll need the `purge_ui` module):
**Configuration → Development → Performance → Purge** → the CloudFront purger's
settings. Everything it stores lives in the `cloudfront_purger.settings` config
object, so you can also set it in `settings.php` or with Drush.

## The settings

| Setting | Default | What it does |
|---|---|---|
| **Distribution ID** | *(empty)* | The CloudFront **Distribution ID** to invalidate. Required for any real purge; must be alphanumeric. |
| **AWS key** | *(empty)* | Optional AWS access key. Prefer leaving this empty and using an IAM role or environment variables instead (see below). |
| **AWS secret** | *(empty)* | Optional AWS secret. Same advice — avoid storing it here. |
| **Enabled / disabled** | disabled | Whether real invalidations are sent. The form shows an **Enabled** checkbox that is the inverse of the stored `disabled` flag: ticking **Enabled** stores `disabled: false`. When disabled, invalidations are "black-holed" — marked done **without** calling AWS. |

> Ship the module **disabled** on staging/dev so the purge pipeline runs green
> without touching (or being billed by) AWS, and enable real purging only where you
> mean it.

## AWS authentication — keep secrets out of config

The module resolves AWS credentials like this:

1. If **both** an AWS key and secret are set in config, they're used as explicit
   credentials.
2. **Otherwise** the AWS SDK's default credential chain is used, in order:
   - **IAM roles** (an EC2/ECS instance profile) — the cleanest option in AWS;
   - **environment variables** `AWS_ACCESS_KEY_ID` / `AWS_SECRET_ACCESS_KEY`;
   - a profile in `~/.aws/credentials`.

Whichever identity you use must be allowed the **`cloudfront:CreateInvalidation`**
action.

Following this project's secret-handling rules, **do not paste a long-lived AWS
key/secret into the settings form or committed config.** Prefer an IAM role, or
supply the credentials as environment variables. With DDEV you can set an
environment variable without committing it:

```bash
ddev dotenv set .ddev/.env --aws-access-key-id=AKIA... --aws-secret-access-key=...
ddev restart
```

Then leave the module's **AWS key/secret** fields empty so the SDK picks the
variables up from the container environment. (Keep `.ddev/.env` out of version
control.)

## Distribution ID without the UI

The distribution ID is fine to keep in config or, for per-environment values,
`settings.php` (which stays out of exported config):

```php
// settings.php
$config['cloudfront_purger.settings']['distribution_id'] = 'ABCD1234';
```

or with Drush:

```bash
drush config-set cloudfront_purger.settings distribution_id ABCD1234 -y
drush config-set cloudfront_purger.settings disabled 0 -y     # turn on real purging
drush cget cloudfront_purger.settings
```

## Region / client options

CloudFront is global, but the AWS SDK still wants a region. The default comes from a
service parameter (`ap-southeast-1`). Override it in your site's
`sites/default/services.yml` if needed:

```yaml
parameters:
  cloudfront_purger.cloudfront_client.options:
    region: us-east-1
    version: latest
```

## Register the purger with Purge

Configuring credentials isn't enough — the purger must be added to Purge's
pipeline:

```bash
drush p:purger-lsa            # shows 'cloudfront' as an available plugin
drush p:purger-add cloudfront # add a purger instance
drush p:purger-ls             # confirm it is configured
```

Then queue paths to purge — the module **suggests** `purge_queuer_url` to collect
URLs automatically — and let a Purge processor run (via cron or Drush). Test a
single path directly with:

```bash
drush p:invalidate path /some/page
```

With the module disabled this succeeds without contacting AWS; enabled, with a valid
distribution ID and credentials, it issues a real `CreateInvalidation`.

## What it can invalidate

The base purger handles **path**, **wildcard path**, and **everything**
invalidations: a path becomes `/path`, "everything" becomes `/*`. Cache **tag**
invalidation is **not** in this module — enable the **CloudFront Purge Tags**
(`cloudfront_purger_tags`) submodule for that.

## Remember: AWS bills per invalidation

Each invalidation request is billable by AWS, so keep your queue focused on changed
paths rather than blanket `/*` purges where you can avoid them.
