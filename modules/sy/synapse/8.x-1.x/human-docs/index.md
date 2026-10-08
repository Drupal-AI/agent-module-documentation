# Synapse Staff — manual setup guide

**Synapse Staff** (`synapse`) is a site-specific customization module from the
Synatix/Synapse family. Its own documentation describes a small, practical set of
jobs: connecting the site to **Google Tag Manager** and adding site-verification
meta tags for **Google Webmaster** and **Yandex Webmaster**. More broadly it is a
vendor customization module, commonly used around staff-related content
management, so the exact behaviour you get depends on the customizations it
carries for that context.

Because it is a vendor/site-specific module rather than a general-purpose one,
its features are tailored to the Synatix/Synapse setting it was built for. It has
no documented general access-control role, but as a customization module it can
touch various parts of a site, so it is worth reviewing what it actually does in
your context before relying on it. It has no other module dependencies and
supports Drupal 8, 9, 10 and 11.

The module has a settings form for the integrations above; beyond that, consult
the vendor's own documentation for anything specific to your Synapse/Synatix
deployment.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the Synapse settings form (Google
   Tag Manager and site-verification meta tags).

## Where it lives in the admin menu

Synapse Staff provides a settings form at the `synapse.settings` route. Open it
after enabling the module to connect Google Tag Manager and enter your
site-verification meta values — see [Configuration](configuration/index.md).
