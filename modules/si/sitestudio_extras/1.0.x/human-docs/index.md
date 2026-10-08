# Site Studio Extras — manual setup guide

**Site Studio Extras** (`sitestudio_extras`) extends
[Acquia Site Studio](https://www.drupal.org/project/cohesion) (formerly Cohesion)
with additional helpers that fill gaps in the low-code Site Studio builder. Its
headline feature is a Site Studio custom element that lets you select from the
libraries provided by the active modules and themes on your site — so builders
can pull in the assets they need without hand-editing configuration.

It is a site-building enhancement layered on top of Site Studio. The extra
functionality follows Site Studio's own handling of content and components, and
the module carries no access-control role of its own. It depends on the Cohesion
(Site Studio) module and only makes sense on sites that already use Site Studio.

The module simply adds its functionality once enabled; there is no separate
configuration form to fill in. This is release 1.0.1, and the project carries
official security-advisory coverage.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Site Studio.

## How to use it

Once enabled next to Site Studio, the extra functionality becomes available
inside the Site Studio builder — including the custom element for selecting a
library from your active modules and themes. You work with it in the normal Site
Studio editing interface; there is no dedicated Drupal settings page to visit.
