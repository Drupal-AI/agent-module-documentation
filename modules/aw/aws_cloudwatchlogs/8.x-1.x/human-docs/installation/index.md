# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- The **Key** module (`key`) — a hard dependency, used to hold your AWS
  credentials securely.
- An **AWS account** with CloudWatch Logs, and an IAM identity (access key or
  role) permitted to create log groups/streams and put log events.

## Install with Composer

From the project root:

```bash
composer require drupal/aws_cloudwatchlogs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Key module and
any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/aws_cloudwatchlogs -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en aws_cloudwatchlogs -y
```

Drupal will enable the Key module alongside it.

## Store your AWS credentials as a secret

Do not paste AWS keys into configuration. Put them in an environment variable and
create a Key entity that reads it. With DDEV:

```bash
ddev dotenv set .ddev/.env --aws-access-key-id=<value>
ddev dotenv set .ddev/.env --aws-secret-access-key=<value>
ddev restart
```

Keep `.ddev/.env` out of version control. Confirm the variables reached the
container without printing them:

```bash
ddev exec 'test -n "$AWS_ACCESS_KEY_ID" && test -n "$AWS_SECRET_ACCESS_KEY"'
```

Then create Key entities backed by the env provider (see the Key module's
documentation) and select them on the module's settings form. See
[Configuration](../configuration/index.md).
