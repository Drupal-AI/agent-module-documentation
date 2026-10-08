# Tawk.to Live Chat — manual setup guide

**Tawk.to - Live Chat Application** (`tawk_to`) adds the
[tawk.to](https://www.tawk.to/) live-chat widget to your Drupal site so visitors
can chat with your support team. You pick which widget from your tawk.to account
to embed — through a configuration screen that logs you into tawk.to in an
embedded frame — and the module renders the chat script in the page footer,
subject to visibility rules you choose.

Rather than copy-pasting embed code, you select the widget in the admin UI and
the module stores the choice. Where the widget appears is controlled by the same
kind of **visibility conditions** you know from block settings — by page path,
role, content type, language, and so on (all conditions must pass). You can also
delay the chat script to improve perceived page-load speed, and optionally
pre-fill the visitor's name and email using tokens.

The module has a settings area, provides the **"administer tawk_to settings"**
permission (restrict-access), and stores its choices in one config object. The
widget only shows once a widget is selected **and** the configured conditions
pass. It has no dependencies beyond Drupal core (PHP 7.3+).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — select a widget, set visibility
   conditions, the load delay, and the optional visitor name/email.

## Where it lives in the admin menu

Its settings live under **Configuration → Web services → Tawk.to**
(`/admin/config/services/tawk_to`).

## How to use it

Enable the module, then go to the tawk.to admin page, select a widget from your
tawk.to account, and set where you want it to appear. Once a widget is chosen and
its conditions pass, the chat bubble shows up in the site footer. Step-by-step
details are in [Configuration](configuration/index.md).
