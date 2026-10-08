# Cloudfront Cache Path Invalidate — manual setup guide

**Cloudfront Cache Path Invalidate** (`cloudfront_cache_path_invalidate`) clears
(invalidates) cached paths on an Amazon **CloudFront** distribution from inside
Drupal. If your site sits behind CloudFront, this is how you make edits show up
quickly at the edge instead of waiting for the cache to expire.

It works two ways. **Automatically**, whenever a content entity of a type you have
configured is created, updated, or deleted, the module invalidates that entity's URL
alias (with the right language prefix, plus any legacy paths tracked by the Redirect
module) along with any extra paths you listed for that rule. **Manually**, an admin
form lets an operator paste path patterns — including wildcards like `/sector/*` —
and invalidate them on demand.

AWS credentials are read from `settings.php`, never from module config, so your keys
stay out of the database and out of exported configuration. Under the hood the module
calls the AWS SDK's CloudFront `createInvalidation` API for your distribution, and
logs every attempt (success or failure) so you have an audit trail. It requires the
`aws/aws-sdk-php` library, which Composer installs for you.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add your AWS credentials to
   `settings.php`, set up automatic invalidation rules, and use the manual
   invalidate form.

## Where it lives in the admin menu

Both forms live under **Configuration → Web services**:

- **Manual invalidation:** `/admin/config/services/cloudfront-invalidate-url`.
- **Automatic rules:** `/admin/config/services/auto-cloudfront-cache-entities`.

## How to use it

First put your AWS distribution ID, region, and keys in `settings.php`. Then either
set up per-content-type automatic rules (so edits invalidate the right paths on
save), use the manual form for one-off purges, or both. See
[Configuration](configuration/index.md) for the specifics — including the cost and
permission considerations of on-demand wildcard purges.
