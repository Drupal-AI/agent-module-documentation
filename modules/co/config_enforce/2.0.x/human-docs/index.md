# Config Enforce — manual setup guide

**Config Enforce** (`config_enforce`) makes selected configuration **read-only**,
so chosen config objects can't be changed through the admin UI in production. The
idea is to flip Drupal's usual assumption: normally the config stored in a
production database is treated as canonical, and config files in code are applied
on top of it. Config Enforce instead treats the **config files in your codebase as
canonical** and the database copy as essentially a cache — the enforced values
come from code and deployment, not from someone editing a form.

Depending on how strictly you enforce a given config object, the module can make
its settings forms read-only, interrupt attempts to write new values to the
database, and periodically re-import the config from disk so the site cannot drift
away from the intended values. This makes it a **governance and hardening** tool:
locking security-relevant settings read-only prevents a privileged user — or an
honest mistake — from weakening them through the UI. It enforces at the
configuration layer only and has no access-control role of its own; the trade-off
to understand is that enforced config must then be changed in code and redeployed
rather than in the browser.

Config Enforce is the **production-facing** half of a pair. Its companion,
[Config Enforce Devel](https://www.drupal.org/project/config_enforce_devel), gives
developers a convenient UI to choose, per config object, whether and how strictly
to enforce it, and to write the resulting YAML into the codebase. You install
Devel only in development (never in production) and install Config Enforce
everywhere. Note the important installation quirk below: Config Enforce needs
Composer **patching enabled** to work correctly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — enable Composer patching, install the
   module (plus the dev companion in development), and enable it.

**You do not pick which config to enforce on this module's own settings page** —
that is decided during development (typically with the Config Enforce Devel UI),
and the enforcement then travels with your config YAML in the codebase. The
workflow is described below.

## Where it lives in the admin menu

Config Enforce adds one small settings page at **Administration → Configuration →
Development → Config enforcement**
(`/admin/config/development/config_enforce`), available to users with the
*Administer site configuration* permission. It does **not** list or choose config
objects; it only lets you pick which events trigger a re-import of enforced config
(today the single option is **Cache rebuild**, which is on by default). Which
config is enforced, and how strictly, is defined entirely in your config files.
Enforcement's visible effect appears wherever an enforced config object is edited —
for example, an enforced settings form renders read-only.

## How to use it

1. In your **development** environment, install both Config Enforce and Config
   Enforce Devel (see [Installation](installation/index.md)).
2. Use the Config Enforce Devel UI to mark each config object you want to protect
   and choose how strictly to enforce it (read-only form, block database writes,
   re-import from disk).
3. Devel writes the enforcement metadata into your config YAML in the codebase.
   Commit those files.
4. Deploy to production with Config Enforce enabled (but **not** Devel). From then
   on, the enforced config is locked to the values in code — to change it, edit
   the YAML and redeploy.
