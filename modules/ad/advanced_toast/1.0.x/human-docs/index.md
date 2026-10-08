# Advanced Toast Messages — manual setup guide

**Advanced Toast Messages** (`advanced_toast`) provides customizable **toast
notifications** — the small floating notices that slide in, usually in a corner of
the screen, and can be dismissed. It offers a modern, component-based alternative
to Drupal's default status messages, with support for **custom toast types** and
**animations**.

The toasts are built with **Single Directory Components (SDC)**, Drupal core's
component system, which keeps each toast's markup, styles, and behaviour together
as a reusable component. It depends on core's **SDC** module.

This is a front-end / UI presentation feature: it changes how notices look and
behave. It has no content or access-control role — it only affects message
presentation.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Advanced Toast Messages does not add a dedicated top-level admin section. It
supplies the toast components (with configurable types and animations) that your
site uses to present notifications; there is no standalone settings page to fill
in before it works.

## How to use it

1. Enable the module (see [Installation](installation/index.md)); this also enables
   core's SDC component system.
2. Notices are then presented as styled, animated, dismissible toasts rather than
   the default status messages.
3. Use the module's toast **types** and **animations** to style the notices to
   taste — for example different colours or entrance animations for different
   kinds of message.
