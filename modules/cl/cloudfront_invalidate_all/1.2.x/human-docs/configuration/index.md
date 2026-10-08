# Configuration

There are four parts: tell the module which CloudFront distribution to clear,
make sure AWS credentials are available from your environment, choose which cache
tags are *allowed* to trigger a clear, and finally switch the module on (it ships
switched off).

> **It ships disabled.** The default configuration sets *"Temporarily disable
> CloudFront invalidations"* to **on**, so nothing is ever sent to CloudFront until
> you uncheck that box on the settings form. Set your distribution ID first, confirm
> AWS credentials work, then un-disable it.

## Set the distribution ID

The module does not have a field for AWS keys, but it does need to know your
**distribution ID**. The usual approach is to set it in `settings.php`, injected
from an environment variable:

```php
$config['cloudfront_invalidate_all.settings']['distribution_id'] = getenv('DISTRIBUTION_ID');
```

You can also hard‑code the ID there, or save it to configuration — but reading it
from an environment variable keeps it out of committed config and lets each
environment target its own distribution.

## Provide AWS credentials via your environment

Credentials are **never entered in Drupal**. The module assumes your setup already
has AWS access through one of the standard mechanisms:

- The **AWS metadata service** — an IAM role attached to the EC2/ECS instance
  (the most secure option, since no keys are stored anywhere).
- **Environment variables** — the standard AWS SDK variables.

> **Least privilege.** Scope the IAM permissions to just
> `cloudfront:CreateInvalidation` on the one distribution this site clears. A token
> or role that can only create invalidations on a single distribution limits the
> blast radius if it is ever exposed. Store any AWS access key/secret as secrets
> (environment/IAM/Key), never in code or config.

## Tune the cache‑tag whitelist (allow‑list)

Despite the README calling it a "black list," the field on the settings form is a
**whitelist** — an *allow*-list. Only cache tags whose name **starts with** one of
the prefixes you list will trigger a CloudFront clear; every other tag is ignored.
An empty whitelist therefore means *nothing* ever fires.

The module ships with a short default list of just two prefixes:

- `node_list`
- `node:` (matches `node:1`, `node:2`, and so on)

So out of the box only node-related invalidations reach CloudFront. Edit the
**Cache Tag Whitelist** textarea on the settings form (one prefix per line) to add
or remove prefixes for your site. This is your main lever for controlling how often
the wildcard invalidation actually fires.

## How it behaves

Once the distribution ID is set, AWS credentials are available, and you have
un-disabled the module, it issues a wildcard `/*` invalidation against the
distribution whenever Drupal invalidates a cache tag that matches the whitelist. A
failed CloudFront call is logged but never breaks Drupal's own cache clear. Because
a wildcard invalidation clears everything and carries an AWS cost at high frequency,
keep the whitelist tight — and remember this approach only suits small sites. For
anything larger, move to the Purge module with `cloudfront_purger`.

Turn on **Enable debug logging** temporarily if you want to see, in the log, which
tags are being processed and why an invalidation was or wasn't sent.
