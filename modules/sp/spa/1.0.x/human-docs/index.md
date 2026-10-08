# SPA — manual setup guide

**SPA** (`spa`) helps you embed a **single-page application** — a JavaScript
front-end built with React, Vue or similar — inside a Drupal page. Instead of
standing up a fully decoupled site, you can mount your SPA into a normal Drupal
page and let Drupal handle the surrounding page, menus and theme.

It works through a **config entity**: you define an SPA by specifying its HTML
snippet, the JavaScript and CSS it needs (as Drupal libraries), and any inline JS
snippets. To place the SPA on the site, the module provides a **block** you drop
into the region you want using Drupal's normal Block layout. The JS and CSS are
loaded through Drupal's library system, so the SPA's assets are managed the same
way as any other front-end code on the site. It depends on the **Plugin Form
Element** and **Multivalue Form Element** modules (which power its configuration
forms) and provides its own permission.

**A security note worth taking seriously.** The SPA is front-end code that *you*
supply, and a decoupled front-end must not assume Drupal is guarding whatever
back-end or API it talks to. Any endpoints your SPA calls need their own
authentication and access control — do not rely on the fact that the SPA is
rendered inside Drupal to protect its data. The module itself carries no
access-control role beyond its permission.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (along with its two form-element dependencies) and enable it.

## How to use it

After enabling, create an SPA config entity describing your application — its HTML
container, the Drupal libraries providing its JS/CSS, and any inline scripts.
Then place the SPA **block** in the region where you want it to appear using
**Structure → Block layout**. Make sure any API the SPA calls enforces its own
authentication, since Drupal does not gate those calls for you.

> **Note:** this is a beta release; test it before relying on it in production.
