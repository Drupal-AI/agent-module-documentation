# Brandfolder — manual setup guide

**Brandfolder** (`brandfolder`) integrates Drupal with the Brandfolder digital
asset management (DAM) platform. Brandfolder is a hosted library where an
organization keeps its brand assets — logos, images, videos, documents — and this
module lets Drupal editors browse and use those assets as Drupal media, so the
central brand library is available inside the site without copying files around
by hand.

It builds on core **Media**: assets referenced from Brandfolder are bridged into
Drupal's media system so they can be used like any other media. The module
provides its own permissions and a settings form for the connection.

Because it talks to the Brandfolder API, credential handling matters. The module
authenticates with a Brandfolder API key or token, and that credential is a
secret — store it in an environment variable and, where possible, reference it
through a Key entity rather than putting it in exported config or code. See
[Configuration](configuration/index.md) for the honest workflow.

This guide is written for a **human** setting the module up through the admin UI.
If you want a terse, token-cheap reference for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements (including core Media),
   installing with Composer, and enabling the module.
2. [Configuration](configuration/index.md) — connecting to Brandfolder and
   handling the API key as a secret.

## Where it lives in the admin menu

Brandfolder's settings form is at the `brandfolder.brandfolder_settings_form`
route (under **Configuration**), where you enter the API credential and connection
details. The module also provides its own permissions to control who may
administer the connection and use Brandfolder assets.

## How to use it

Connect the module to your Brandfolder account by entering the API key, then let
editors pull assets from the Brandfolder library into Drupal media. The result is
a single, central brand-asset library that content authors can draw on directly,
instead of downloading and re-uploading files. The assets stay sourced from
Brandfolder; the module bridges them into Drupal's media so they behave like
native media in your content.
