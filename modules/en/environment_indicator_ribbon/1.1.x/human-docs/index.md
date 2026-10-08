# Environment indicator ribbon — manual setup guide

**Environment indicator ribbon** (`environment_indicator_ribbon`) adds a corner
**ribbon** to the page showing which environment you are on — development, staging,
or production. It extends the
[Environment Indicator](https://www.drupal.org/project/environment_indicator)
module, which colours the admin toolbar for the same purpose, and adds a marker
that stays put in a corner of the viewport where the toolbar cannot.

The mistake it prevents is specific, common, and expensive: doing something on
production while believing you are on staging — deleting content, running a
migration, sending a test email to a real list, clearing a cache at peak. It
happens to competent people who have three near‑identical browser tabs open. The
admin toolbar's colour helps, but the toolbar is not always where your attention
is: an editor working in a front‑end theme, a developer looking at a rendered page,
or anyone whose toolbar has scrolled away. A ribbon sits in the corner and stays
there.

Two things determine whether the ribbon actually protects you:

- **The environment must be detected, not configured per environment.** A value
  read from an **environment variable** is correct everywhere automatically. A
  value stored in **exported configuration** is identical on every environment, so
  it will cheerfully say "production" on staging — which is *worse* than no ribbon,
  because people trust it.
- **Colour alone is not enough.** A ribbon that distinguishes environments only by
  red versus green fails a colour‑blind developer, so the environment's **name**
  must appear in the ribbon text.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, pull
   in its Environment Indicator dependency, and enable it.
2. [Configuration](configuration/index.md) — where the environments, names, and
   colours are set, and the permission that controls who sees the ribbon.

## Where it lives in the admin menu

The ribbon is configured together with the rest of Environment Indicator at
**Configuration → Development → Environment indicator**
(`/admin/config/development/environment-indicator`, the
`environment_indicator.settings` form). Access to the ribbon itself is governed by
the **`access environment indicator ribbon`** permission at **People →
Permissions**.
