<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Tome AWS ships the static HTML that Tome generates to an Amazon S3 bucket, including redirect objects and remote metadata diffing.

---

Tome AWS extends the Tome static-site generator with an AWS S3 deploy target. It adds a settings form (`/admin/config/services/tome_aws/settings`) where the S3 client id, client secret, bucket name, prefix, region and ACL are stored in the `tome_aws.settings` config object, and a deploy form/batch (`/admin/config/tome/aws/send`) that walks the generated static files and uploads them via the AWS SDK for PHP `S3Client`. A `RedirectSubscriber` mirrors Tome redirect entities as S3 `WebsiteRedirectLocation` objects, and a remote-metadata service compares local vs. remote to only push changed files. Both routes are gated by the `use tome static` permission. Deployment can also be run from Drush (`Deploy` command).

---

- Push a Tome static build to an S3 bucket.
- Serve a Drupal site as static files from S3.
- Store AWS credentials, bucket, region and ACL in config.
- Deploy from the admin UI at /admin/config/tome/aws/send.
- Run the deploy from Drush in CI.
- Only re-upload files whose remote metadata changed.
- Mirror Drupal redirects as S3 website redirect objects.
- Set a per-object ACL such as public-read.
- Use an S3 key prefix to deploy into a sub-path.
- Gate all operations behind the 'use tome static' permission.
- Batch-upload large builds without timing out.
- Integrate a decoupled/static publishing workflow.
- Head remote objects to read their metadata.
- Paginate bucket contents via the SDK paginator.
- Combine with tome_static generation as the deploy step.
