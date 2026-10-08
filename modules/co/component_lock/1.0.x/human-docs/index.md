# Component Lock — manual setup guide

**Component Lock** (`component_lock`) gives site builders granular control over
the configuration forms of **Layout Builder** components. It lets you lock either
*all* of a placed component's settings, or specific individual form elements (for
example "Override title" or "View mode"), for users who do not hold
administrative permissions — protecting a curated layout from being changed by
other editors. Users with the **Administer blocks** permission always see and can
edit every setting, so the lock never gets in an administrator's way.

It also offers an option to use Drupal's interface translation for the block
label, so a locked component's label can still be translated. The module depends
on core **Layout Builder** (`layout_builder`) and the **Form Decorator**
(`form_decorator`) module, which it uses to modify the component configuration
forms. Think of it as layout governance: it constrains what editors can change,
and complements — rather than replaces — Layout Builder's own permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

There is **no central settings form** for this module — locking is configured per
component, on the component's own configuration form in Layout Builder.

## Where it lives in the admin menu

Component Lock adds no dedicated admin page. You use it inside **Layout Builder**:
when configuring a placed component, the module's locking options let you hide
all settings, or pick specific fields to hide, for non-administrators. Because it
targets non-admins, test the result as a non-administrative editor to confirm the
right fields are hidden.
