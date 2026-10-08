# CloudFront Purge — manual setup guide

**CloudFront Purge** (`cloudfront_purger`) connects Drupal's **Purge** framework to
**AWS CloudFront**, so that when content changes, Drupal can invalidate the
matching paths on a CloudFront distribution used as a reverse proxy / CDN in front
of the site. It supports invalidating individual paths, wildcard paths (like
`/blog/*`), or everything (`/*`), turning each into a CloudFront `CreateInvalidation`
API call via the AWS SDK.

It plugs in as a Purge **purger** plugin (`cloudfront`). That means you don't drive
it directly — you add it to Purge's pipeline, and Purge's queue and processors feed
it the paths to clear (the `purge_queuer_url` module is a handy companion for
collecting URLs automatically). Cache **tag** invalidation isn't in the base module;
it comes from the bundled **CloudFront Purge Tags** (`cloudfront_purger_tags`)
submodule.

A few things to plan for. You'll need an **AWS distribution ID** and credentials
that allow the `cloudfront:CreateInvalidation` action — supplied either through
Drupal config or, better, through the AWS SDK's default credential chain (IAM
roles, environment variables, or an `~/.aws/credentials` profile). Following this
project's conventions, **keep secrets out of code and config** — prefer an IAM role
or environment variables over pasting a key/secret into the settings form. There's
also a **disabled** flag that "black-holes" invalidations (marks them done without
calling AWS), which is exactly what you want on staging/dev. And note that
**AWS charges per invalidation**, so queue only what changed.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (needs the AWS SDK
   and Purge), enable it, and the optional tags submodule.
2. [Configuration](configuration/index.md) — distribution ID, AWS authentication
   (secrets via environment), region, the disabled black-hole flag, and registering
   the purger with Purge.

## Where it lives in the admin menu

The module has **no admin page of its own**. Its settings are reached through
Purge's own UI at **Configuration → Development → Performance → Purge** (needs the
`purge_ui` module), where you add and configure the CloudFront purger.

## How to use it

1. Install CloudFront Purge, the Purge module, and the AWS SDK (see
   [Installation](installation/index.md)).
2. Provide AWS credentials that can create invalidations — ideally via an IAM role
   or environment variables, not in config (see
   [Configuration](configuration/index.md)).
3. Set the CloudFront **distribution ID**, and set the **disabled** flag off where
   you want real purging (leave it on in staging).
4. Add the purger to Purge: `drush p:purger-add cloudfront`.
5. Queue paths to purge (e.g. with `purge_queuer_url`) and let a Purge processor
   run. Test a single path with `drush p:invalidate path /some/page`.
