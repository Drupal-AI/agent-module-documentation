# DSFR Core — manual setup guide

**DSFR Core** (`dsfr_core`) is the shared base of the DSFR module suite — the
Drupal implementation of the DSFR, *Système de Design de l'État*, the French
State Design System. It provides the common **services** that the other DSFR
modules build on, and it is designed to work with the **DSFR theme** (and DSFR
child themes). On its own it does not add visible site features; it is the
foundation the rest of the suite depends on.

Because it is a base module, you typically install it because another DSFR module
requires it — for example [DSFR Menus](../../dsfr_menu/2.1.x/human-docs/index.md)
depends on it. It pulls in a few companion modules of its own:
**DSFR Twig Components** (`dsfr_twig_components`), which supplies the Twig
components that render DSFR‑compliant markup;
[**Form Options Attributes**](https://www.drupal.org/project/form_options_attributes);
and [**Style Selector**](https://www.drupal.org/project/style_selector).

There is nothing to configure — enable it (usually as a dependency) and the
services become available to the rest of the suite. It supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (it pulls in its companion modules).

There is **no configuration page** for this module — it provides base services
for the rest of the DSFR suite.

## Where it lives in the admin menu

DSFR Core adds no admin settings page. It works behind the scenes as the base for
the DSFR suite; you interact with the DSFR features through the other modules
(such as DSFR Menus) and the DSFR theme.
