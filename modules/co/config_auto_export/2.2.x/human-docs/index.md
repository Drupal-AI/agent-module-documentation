# Config Auto Export — manual setup guide

**Config Auto Export** (`config_auto_export`) watches Drupal's configuration
system for changes and **exports them automatically** to a directory you choose.
On top of that, it can fire a **webhook** — a POST request to an HTTP service you
define — so an external system (typically a CI pipeline) can react to those
changes.

The failure it closes is a familiar one: someone tweaks a view or a field on a
live site, nobody runs `drush config:export`, and weeks later a deployment quietly
overwrites the change or an unexplained diff appears. This module captures each
change as it happens and lets a downstream service collect it, push it into version
control, and notify developers to review and merge it. It's especially useful on
locked-down production environments where you still allow selected users to make
configuration changes (to blocks, webforms, or views, say) and want those changes
to flow back into your repository.

The module has no other module dependencies. Its behaviour is driven entirely by a
settings form, and delayed exports rely on cron, so make sure cron is running if
you use a delay.

**Three things to settle before turning it on:**

1. **The export directory must not be web-accessible.** Exported configuration
   isn't secret by design, but real sites carry internal paths, endpoints, and
   email addresses in it. (Actual secrets belong in a **Key** entity or an
   environment variable, never in config.)
2. **The webhook URL is effectively a credential** — anything holding it can
   trigger your pipeline. Prefer keeping it out of exported configuration.
3. **It changes what a config diff means.** A diff stops being a record of
   *deliberate* change and becomes a record of *every* change, including accidents
   — so someone still has to review before committing.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form field by field, and
   the manual webhook trigger.

## Where it lives in the admin menu

The settings form is at **Configuration → Development → Config Auto Export**
(`/admin/config/development/config_auto_export`), behind the **Administer site
configuration** permission. A separate, access-restricted trigger form
(`trigger config_auto_export`) lets you fire the webhook manually.
