# AWS Manager — manual setup guide

**AWS Manager** (`aws_manager`) gives a Drupal site one central place to configure
AWS credentials and to create AWS SDK clients from them. Rather than every module
that talks to AWS setting up its own credentials, AWS Manager holds the credential
setup once — including S3 access and support for organization accounts — so other
modules and custom code can use AWS services through a single, consistent
configuration.

It is a foundation/integration module aimed at developers and site builders who
need AWS connectivity. Access to it is gated by the **`access aws manager`**
permission, which should be restricted to trusted roles only, since AWS
credentials are involved.

Because it handles AWS credentials, storing them securely is essential. **Never
commit AWS keys** to configuration or code. Prefer an IAM instance role where the
site runs on AWS, or supply the access key and secret via environment variables.
It supports Drupal 10, 11, and 12.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

AWS Manager is primarily used by other code: once your AWS credentials are
configured centrally, other modules obtain ready‑to‑use AWS SDK clients (for
example an S3 client) from it. Restrict the `access aws manager` permission to
trusted administrators.

### Handling AWS credentials securely

Do not put AWS keys in configuration. Where the site runs on AWS, prefer an **IAM
role** so no static keys exist at all. Otherwise store them as environment
variables. With DDEV:

```bash
ddev dotenv set .ddev/.env --aws-access-key-id=<value>
ddev dotenv set .ddev/.env --aws-secret-access-key=<value>
ddev restart
```

Keep `.ddev/.env` out of version control, and confirm the variables are present
without printing them:

```bash
ddev exec 'test -n "$AWS_ACCESS_KEY_ID" && test -n "$AWS_SECRET_ACCESS_KEY"'
```

Then reference those variables (via a Key entity or `getenv()`), never a
committed value.
