# Profile — manual setup guide

**Profile** (`profile`) adds configurable user **profile entities** to your
Drupal site. Instead of piling every extra field directly onto the core user
account, Profile lets you define separate, fieldable **profiles** that are
attached to a user — for example a billing profile, a public bio, or a
membership record. Each kind of profile is its own **profile type**: a bundle
you can give its own fields, exactly like a content type.

Because profiles are their own entities rather than columns on the user account,
they are individually manageable and a single user can own **more than one**
profile of the same type — several shipping addresses, for instance. A profile
type can also be set to appear on the user registration form or be restricted to
particular roles.

This guide is written for a **human** clicking through the admin UI. It walks
you, step by step and with screenshots, from installing the module to creating
your first profile type and letting users fill it in. If you are looking for
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

![The Profile types list with an Add profile type button](images/types.png)

## Where it lives in the admin menu

Everything in this guide sits under **Configuration → People → Profile types**
(`/admin/config/people/profile-types`). That page lists every profile type on
the site and gives you an **+ Add profile type** button to create a new one.
Each row also has a **Manage fields** operation for attaching fields to a type.

## Contents

1. [Installation](installation/index.md) — install Profile with Composer and
   enable it along with its dependencies.
2. [Configuration](configuration/index.md) — understand the Profile types list
   and how each type is its own fieldable bundle.
3. [Creating a profile type](creating-a-profile-type/index.md) — add a profile
   type, choose its options, attach fields, and let users fill it in.
