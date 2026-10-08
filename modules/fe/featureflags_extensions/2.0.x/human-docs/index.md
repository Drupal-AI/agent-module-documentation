# Feature Flags Extensions — manual setup guide

**Feature Flags Extensions** (`featureflags_extensions`) adds extra functionality on
top of the [Feature Flags](https://www.drupal.org/project/featureflags) module. Where
the base module gives you flags, a manager service, a cache context, and a block
condition, this extension lets a flag do three more things:

- **Enable or disable routes** depending on a feature flag;
- **Enable or disable permissions** depending on a feature flag;
- **Check a flag's status from a Twig template** with a `featureflag_active()`
  function.

It has no settings page of its own — the route and permission bindings are set
directly in each **feature flag's settings** (in the base Feature Flags UI) and are
exported as configuration. Who may toggle flags is governed by the module's
permissions; because a flag can now switch routes and permissions on and off, keep
that ability with trusted operators.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (alongside Feature Flags).

There is **no standalone configuration page** — you set route and permission
bindings inside each flag's settings, as described below.

## How to use it

**Bind routes or permissions to a flag.** Edit a flag in the base Feature Flags UI
(**Configuration → Development → Feature Flags**). This extension adds fields there
where you list the routes and/or permissions the flag should control. Those choices
are saved as config, so they travel with your normal deployment workflow. When the
flag is active the bound routes/permissions are available; when it is inactive they
are switched off.

**Check a flag in Twig.** In a template, wrap flag‑dependent markup like this:

```twig
{% if featureflag_active("demoflag") %}
  Flag is active!
{% endif %}
```

## Version note

For Drupal 10+, use Feature Flags Extensions **1.1.3 or newer**. This **2.0.x**
release targets **Drupal 11+**.
