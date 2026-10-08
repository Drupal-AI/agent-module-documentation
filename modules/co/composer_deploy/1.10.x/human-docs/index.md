# Composer Deploy — manual setup guide

**Composer Deploy** (`composer_deploy`) fixes a common annoyance on
Composer-managed Drupal sites: modules and themes showing up as "Unknown"
version — or with no version at all — on the **Available Updates** report. That
happens because when you install contrib with Composer (rather than the
Drupal.org tarball), the `.info.yml` files often ship without the `version`,
`datestamp`, and `project` lines that Drupal.org's packaging script normally
adds. Core's Update module then can't tell what release you're running.

This module restores that information. It reads your Composer lockfile data
(`vendor/composer/installed.json`) and, for any extension whose version is still
empty, injects the real `version` (including a readable `x.y.z-dev` string for
dev branches), a `datestamp`, the `project` name, and even a
`composer_deploy_git_hash` taken from the package's source reference — so you can
see the exact commit you deployed. With that in place, core's update checker can
compare installed versus available releases again, and security-update warnings
work properly.

It also enhances the updates report itself, adding a **"Diff" link** on each
listed release so you can review the upstream changes between your deployed commit
and a newer tag. It is essentially read-only: it never writes to your packages or
filesystem, it only adjusts the extension information Drupal has already computed
in memory.

For most sites there is **nothing to configure** — it works out of the box on the
standard `drupal/*` vendor layout. The only setting exists for sites that install
modules under a different vendor name (see below).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Composer Deploy has no admin page of its own (`configure` is null). Its effect
shows up on the core **Reports → Available updates** page
(`/admin/reports/updates`), where versions are now correct and each release
carries a "Diff" link.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Visit **Reports → Available updates** (`/admin/reports/updates`) — module and
   theme versions should now be correct, and you should see the extra "Diff"
   links. That's it; no configuration is needed for the normal `drupal/*` setup.

### Advanced: custom vendor prefixes

Composer Deploy has exactly one setting, `composer_deploy.settings:prefixes` — a
list of Composer vendor prefixes used when matching a package to an extension by
name. The default is `['drupal']`, and `drupal` is always included even if you
remove it, so the common case needs no attention. There is **no admin form** for
this; manage it with config only.

You only need to touch it if your modules are installed under a vendor other than
`drupal/` — for example a private fork published as `mycompany/my_module`. Add
that vendor so the name-based lookup can resolve it:

```bash
drush config:get composer_deploy.settings prefixes
drush php:eval '\Drupal::configFactory()->getEditable("composer_deploy.settings")
  ->set("prefixes", ["drupal", "mycompany"])->save();'
drush cr
```

(The primary lookup is by install path and is prefix-independent, so the normal
`drupal/*` case resolves without any config.)
