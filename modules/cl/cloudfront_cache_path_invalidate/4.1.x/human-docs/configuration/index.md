# Configuration

## 1. Add AWS credentials to `settings.php`

The module reads AWS credentials from `settings.php` only — never from module
config, so your keys never enter the database or an exported configuration. Add:

```php
$settings['aws.distributionid'] = 'ABCD1234EFGH7';   // your CloudFront distribution ID
$settings['aws.region']         = 'eu-west-2';        // the distribution's region
$settings['aws.access_key']     = 'AKIA...';          // optional (see below)
$settings['aws.secret_key']     = '...';              // optional (see below)
```

Notes:

- **Region and distribution ID are required.** If either is missing, invalidation
  aborts with a message.
- **Access/secret keys are optional.** If you omit them, the AWS SDK falls back to
  its default credential chain (an IAM role on the server, environment variables,
  etc.) — the preferred approach on AWS-hosted infrastructure.
- The IAM identity you use needs the `cloudfront:CreateInvalidation` permission on
  the distribution. Scope it to just that action for least privilege.
- If you prefer to keep keys out of `settings.php` too, store them as environment
  variables and read them in, e.g.
  `$settings['aws.secret_key'] = getenv('AWS_SECRET_KEY');` (with DDEV, set the
  variable via `ddev dotenv set`).

## 2. Set up automatic invalidation rules

Go to **Configuration → Web services → *(Auto CloudFront cache entities)*** at
`/admin/config/services/auto-cloudfront-cache-entities`. This form requires the
**Cloudfront cache path invalidate permission** (a restricted, admin-level
permission).

The form manages a list of **groups**, one per entity-type/bundle rule. Use the
**Add** and **Remove** buttons to build up your rules. For each group you set:

- **Entity type** — which content entity type this rule applies to (only types that
  have bundles).
- **Bundle** — the specific bundle (e.g. the *Article* content type).
- **Detail page** — when ticked, also invalidate the entity's `/{bundle}/{id}`
  detail alias.
- **Extra paths to invalidate** — one path per line, for listing/section pages that
  should also be cleared when this entity changes (for example `/articles` when an
  article is saved).

With a rule in place, whenever a matching entity is created, updated, or deleted the
module invalidates:

- the entity's canonical path alias (with the correct language prefix on non-default
  languages, and the site base path on subdirectory installs),
- any source paths tracked by the **Redirect** module (if enabled),
- the detail-page alias (when *Detail page* is set),
- and your configured extra paths.

Changes triggered by an **anonymous** user are skipped (to avoid, for example,
anonymous comment saves firing invalidations). `menu_link_content` changes are
matched by their menu.

## 3. Use the manual invalidate form

Go to **Configuration → Web services → *(CloudFront invalidate URL)*** at
`/admin/config/services/cloudfront-invalidate-url`. Paste one path per line — each
must start with `/`, and CloudFront wildcards (`*`) are allowed:

```
/sector/*
/state/*
/blog/my-post
```

Submit and the module sends one CloudFront invalidation batch for those paths.

> **Grant this permission carefully.** The manual form is gated by the
> **Use invalidate URL form** permission, which is **not** marked as a restricted
> permission — so it can be handed to lower-trust roles. Anyone who holds it can
> trigger arbitrary (including wildcard) invalidations against your distribution
> using the site's AWS credentials. Because CloudFront **bills** invalidation paths
> beyond the monthly free allotment, scope both this permission and the IAM key
> deliberately, and avoid unbounded automated wildcard purges.

## Logging

Every invalidation attempt — and any AWS error — is written to the
`cloudfront_cache_path_invalidate` log channel, so you can audit what was cleared and
troubleshoot failures at **Reports → Recent log messages**.
