# Stand With Palestine — manual setup guide

**Stand With Palestine** (`standwithpalestine`) adds the Stand With Palestine
solidarity widget to your site. It injects the widget's JavaScript (from the
standwithpalestine.org project) on every page, so a solidarity banner appears
site-wide for your visitors. There is nothing to place and nothing to configure
per page — enabling the module is what turns the widget on everywhere.

The module is very small and works on-enable. It supports Drupal 8 and later. It
declares a permission of its own but has no configuration form; once enabled, the
widget simply loads on every page. Because the widget's JavaScript comes from an
external project, keep in mind that it loads a third-party script — worth noting
if your site has a strict content-security policy or offline requirements.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

There is no admin page to visit. Once you enable the module, the Stand With
Palestine widget's JavaScript is added to every page automatically and the
solidarity banner displays site-wide. To remove it, disable the module.
