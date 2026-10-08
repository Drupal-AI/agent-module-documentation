# Site Studio ACSF — manual setup guide

**Site Studio ACSF** (`sitestudio_acsf`) is a small utility module for sites that
run [Acquia Site Studio](https://www.drupal.org/project/cohesion) (formerly
Cohesion) on **Acquia Site Factory**. It switches Site Studio's template storage
from the file system (the default) to the database, using the database
template-storage feature introduced in Site Studio v6.3.5.

Why bother? Site Factory runs many sites from one codebase on a distributed
file system, where rapid file reads and writes can cause unexpected behaviour in
Site Studio. Storing templates in the database instead gives you consistent
read/write behaviour and avoids the compiled-asset problems that otherwise leave
a site rendering unstyled after a deployment. It is narrowly useful — only on
Acquia Site Factory, only with Site Studio, both of which are commercial products
— and on any other stack it has nothing to do.

The module changes behaviour the moment you enable it, but there is one important
follow-up step: you must run a **full Site Studio rebuild** to migrate all your
existing templates into the database. Be aware that this increases database
utilisation, especially during rebuild and sync operations, so your database will
grow. The module depends on `cohesion_templates` and is a beta release
(1.0.0-beta4).

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and run the required Site Studio rebuild.

## How to use it

There is no settings page. Once enabled, template storage moves to the database
automatically; you just need to trigger a rebuild so existing templates migrate.
Run it with Drush:

```bash
drush cohesion:rebuild
```

or from the UI at **/admin/cohesion/developer/rebuild**. After that, keep an eye
on styling after any deployment — on this kind of platform, a site that renders
unstyled is usually a compiled-asset path problem rather than a configuration
one.
