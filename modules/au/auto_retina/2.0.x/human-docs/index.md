# Auto Retina — manual setup guide

**Auto Retina** (`auto_retina`) automatically creates high-magnification
("retina" / 2x) versions of your image-style derivatives, so images stay crisp
on high-DPI and retina screens. Normally you would have to define a second,
doubled image style by hand for every size you serve; Auto Retina handles that
for you.

It is a media/display feature. It affects only how image derivatives are
generated for display — it adds no content and has no access-control role. It
depends only on Drupal core.

The module ships a small settings form (route `auto_retina.admin_settings`)
where you choose which image styles should get retina derivatives. Beyond that
one choice there is nothing to manage, so this guide keeps the settings on this
page rather than in a separate configuration section.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Auto Retina adds a settings form under **Configuration** (route
`auto_retina.admin_settings`). Its effect is felt on the image styles you manage
under **Configuration → Media → Image styles**.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Open the Auto Retina settings form and choose which image styles should have
   retina (2x) derivatives generated.
3. Save. From then on, the selected styles produce high-magnification
   derivatives automatically, and pages that use those styles serve crisp images
   on high-DPI displays with no manual doubled styles to maintain.
