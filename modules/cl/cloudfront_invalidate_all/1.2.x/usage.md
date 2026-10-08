<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CloudFront Invalidate All invalidates CloudFront whenever Drupal invalidates its cache.

---

CloudFront Invalidate All **invalidates an AWS CloudFront distribution when Drupal invalidates its cache** —
so a CDN in front of the site is purged (a wildcard `/*` invalidation) whenever Drupal clears caches, keeping the
CDN copy fresh. It provides its own permissions, in the Purge package.

Use it to keep CloudFront in sync with Drupal's cache. It is a performance/CDN integration. Security/data
handling: it calls the **AWS CloudFront API** (egress) using **AWS credentials** and a distribution ID — store the
AWS access key/secret as **secrets** (env, IAM role, or Key), never in code/config, and scope the IAM permission
to `cloudfront:CreateInvalidation` on that distribution only (least privilege). Note wildcard invalidations have
**AWS cost** implications at high cache-clear frequency. It has no content/access role beyond its permission.
Configure the distribution ID and AWS credentials.

---

- Invalidate CloudFront on Drupal cache clear.
- Purge the CDN (wildcard /*).
- Keep the CDN fresh.
- Provide its own permissions.
- Serve performance/CDN.
- Sync CloudFront with Drupal.
- Call the AWS CloudFront API (egress) with AWS credentials.
- Store AWS key/secret as secrets (env/IAM/Key), not code/config.
- Scope IAM to cloudfront:CreateInvalidation (least privilege).
- Mind AWS cost of frequent wildcard invalidations.
- Have no content/access role beyond permission.
- Configure the distribution ID and AWS credentials.
- Handle CDN invalidation.
- Invalidate CloudFront.
- Configure the credentials.
- Purge the CDN.
- Handle the integration.
- Clear the CDN.
- Secure the AWS credentials.
- Provide CloudFront invalidation.
