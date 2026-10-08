# Symfony Packages — manual setup guide

**Symfony Packages** (`symfony_packages`) gives Drupal site administrators a
report page that lists every Symfony component installed in the site and its
version, so you can see your Symfony dependency stack at a glance without
dropping to the command line.

It is a diagnostic and reporting tool. For each Symfony package it shows the
current version and, where available, the latest version and whether an update is
waiting — including pre-release information — and it pulls package descriptions
from Packagist. It also distinguishes packages required by Drupal core from those
pulled in by contributed modules, and lets you filter the list by name or
description. Under the hood it uses Composer for accurate package information and
caches the results for performance. It is handy for debugging compatibility
issues, auditing the Symfony stack, and keeping an eye on which components have
security updates available.

The module works as soon as it is enabled — there is nothing to configure. It
simply adds the report page, which is gated by its own `view symfony packages`
permission. It has no content role of its own and no settings form. It depends
only on core's System module, requires a Composer-managed Drupal 11 installation,
and is covered by Drupal's security advisory policy.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Once enabled, grant the **`view symfony packages`** permission to the roles that
should see the report (for example administrators), at **People → Permissions**
(`/admin/people/permissions`). Then open the Symfony Packages report page to
browse the installed components, check for available updates, and filter the list
by name or description. Because the data comes from Composer, the report reflects
whatever is currently installed in your Composer-managed site.
