# Open ReadSpeaker — manual setup guide

**Open ReadSpeaker** (`open_readspeaker`) connects your Drupal site to the
commercial [ReadSpeaker](https://www.readspeaker.com/) webReader / Enterprise
Highlighting text‑to‑speech service. It adds a *"Listen"* button to your pages
that reads a chosen region of the page aloud, highlighting words or sentences as
they are spoken — an accessibility feature that helps visitors who prefer or
need to listen rather than read, and that supports WCAG / inclusive‑design
goals.

Under the hood the module does three things: it loads ReadSpeaker's remote
JavaScript from their CDN, it gives you an admin form that exposes ReadSpeaker's
entire `rsConf` configuration (voices, highlighting colours, keyboard shortcuts,
which toolbar tools appear, and much more), and it provides a *"Listen"* block
you place through Block Layout. **Important: this module is only useful if you
already have a paid ReadSpeaker customer account** — you enter your ReadSpeaker
customer ID and the service does the actual speech synthesis.

The module has no other module dependencies. It optionally works with
[Token](https://www.drupal.org/project/token) (to browse the tokens used in the
script URL) and [CSP](https://www.drupal.org/project/csp) (to automatically
allow ReadSpeaker's host under a strict Content‑Security‑Policy). Enabling the
module does nothing visible on its own — you must configure your customer ID and
place the block before the *"Listen"* button appears. It works on Drupal 10.2+
and Drupal 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your ReadSpeaker account
   details, tune the reader, and place the *"Listen"* block.

## Where it lives in the admin menu

The global settings form sits at **Configuration → Services → Open ReadSpeaker**
(`/admin/config/services/open-readspeaker`) and requires the **Administer open
readspeaker** permission. The *"Listen"* button itself is a block you add under
**Structure → Block Layout**.

## How to use it

At a high level: install and enable the module, open the settings form and enter
your ReadSpeaker **Customer ID**, pick a CDN region, language and voice, then go
to Block Layout and place the **Open ReadSpeaker: Webreader** block in a region
(and, using normal block visibility settings, restrict it to the content types
or pages where you want the *"Listen"* button to appear). The
[Configuration](configuration/index.md) page walks through every field.
