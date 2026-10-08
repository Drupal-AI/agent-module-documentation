# Pusher API — manual setup guide

**Pusher API** (`pusher_api`) connects Drupal to [pusher.com](https://pusher.com),
the hosted Pusher Channels real-time messaging service. It is a base client: on
its own it does not add any visible feature to your site. Instead it gives other
modules (and your own custom code) a clean way to publish events to Pusher
channels so that browsers subscribed to those channels receive live updates —
think notifications, presence indicators, or chat that appear without the visitor
reloading the page.

Version 3.x is a ground-up redesign that provides a new public developer API and a
default set of services to build real-time features on. It is intended to be
extended by supplementary modules (for example a "Pusher User" ecosystem module),
so you will normally install it as the foundation other real-time modules build
upon rather than as a finished feature in itself. It supports Drupal 10.2+ and 11.

The one thing you must take care of yourself is the connection to your Pusher
account. Your Pusher **app id**, **key**, and **secret** are sensitive
credentials — they should be supplied through the environment and never committed
to the repository. The "Installation" guide below explains how to store them
safely.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and store your Pusher credentials securely.

## How to use it

Pusher API is a developer-facing framework. Once it is installed and your
credentials are in place, real-time features come from either an ecosystem module
built on top of Pusher API or from your own custom code that uses the module's
services to publish events to a channel. Browsers then subscribe to those channels
(using Pusher's JavaScript client) to receive the live updates. If you simply want
a ready-made "inject the client and authenticate users" integration rather than a
framework to build on, look at the sibling **Pusher mini** (`pusher_mini`) module.

## Where it lives in the admin menu

This release does not register a dedicated settings form of its own — the Pusher
app credentials are supplied through the environment (see
[Installation](installation/index.md)) rather than typed into an admin page.
