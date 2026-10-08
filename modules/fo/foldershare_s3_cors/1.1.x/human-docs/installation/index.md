# Installation

## Requirements

FolderShare S3 CORS needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **FolderShare** (`foldershare`), version 3.x, enabled and configured — the file
  manager whose uploads this module accelerates.
- **S3 File System** (`s3fs`), version 8.x-3.x — holds your S3 bucket and
  credentials configuration.
- The **Token** module (`token`), version 8.x-1.x.
- The **`aws/aws-sdk-php`** library, version 3.x — the AWS SDK, which Composer
  pulls in.
- An **AWS S3 bucket** and credentials with permission to upload to it.

> **Note on security coverage.** This module is not covered by Drupal's security
> advisory policy. Handle S3 credentials and the bucket CORS policy carefully.

## Install with Composer

From the project root:

```bash
composer require drupal/foldershare_s3_cors -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install S3 File System,
Token, the AWS SDK, and any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/foldershare_s3_cors -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en foldershare_s3_cors -y
```

## Configure S3, CORS, and FolderShare

This module has no standalone settings form; the pieces are configured in the
modules it builds on:

1. **Configure S3 File System** with your bucket and AWS credentials. Store the
   credentials as environment-backed **secrets** — never commit them. On DDEV,
   set them with `ddev dotenv set .ddev/.env --aws-...=<value>` and reference them
   from `settings.php` with `getenv()`.
2. **Set the bucket's CORS policy**, scoped tightly to your site's origin(s), so
   the browser is permitted to upload directly. Avoid wildcards.
3. **Point FolderShare's storage** at the S3-backed filesystem.

## Verify it worked

Upload a large file through FolderShare. In your browser's network tools, confirm
the file bytes are sent directly to the S3 bucket rather than to your Drupal
server, and check that the file appears in the bucket and is listed in
FolderShare.
