# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- The **Mail Group** module (`mailgroup`) — this module is a connection plugin for
  it.
- The **AWS** module (`aws`) — provides the client and credential handling for S3.
- An **Amazon Web Services account** with SES, S3, and SNS available, and
  permission to configure them.

## Install with Composer

From the project root:

```bash
composer require drupal/mailgroup_amazonses -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the AWS
and Mail Group dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mailgroup_amazonses -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mailgroup_amazonses -y
```

AWS and Mail Group are enabled automatically as dependencies if they aren't
already.

## Verify it worked

Once the AWS-side setup and the AWS module credentials are in place (see
[Configuration](../configuration/index.md)), the "Amazon SES" backend becomes
selectable when you configure a Mail Group's connection. Send a test email to the
group's address and confirm it arrives as a message in the group.
