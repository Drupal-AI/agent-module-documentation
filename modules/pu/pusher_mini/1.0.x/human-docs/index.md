# Pusher mini — manual setup guide

**Pusher mini** (`pusher_mini`) is a small, focused glue module for
[Pusher Channels](https://pusher.com) (or a compatible self-hosted server such as
Soketi). It does two jobs. First, it hands the Pusher JavaScript client its
configuration by printing a `window.PusherConfiguration` object into the bottom of
every page for users who are allowed to load it. Second, it provides a server
endpoint that authenticates the logged-in Drupal user with Pusher, so you can
target real-time messages at specific users (Pusher "user" channels).

It is deliberately minimal: it does **not** bundle the Pusher JavaScript client
for you — you add that to your theme or build however you like (npm/Yarn, or a
CDN). Pusher mini simply passes along the client configuration and provides the
factory and auth endpoint on the server side.

Credentials are handled the secure way. Pusher mini stores your app key and secret
in a **Key** entity (via the [Key](https://www.drupal.org/project/key) module),
not in ordinary module configuration, and only the non-secret **app key** is ever
exposed to the browser. Outbound connections default to TLS, and the user-auth
endpoint is gated behind both "must be logged in" and a dedicated permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its Key dependency, and grant the permissions.
2. [Configuration](configuration/index.md) — create the credential Key, fill in
   the settings form field by field, and (optionally) point at a self-hosted
   server.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → Pusher mini**
(`/admin/config/services/pusher-mini`), reachable by users with the
**administer pusher_mini** permission.

## How to use it

The typical flow: create a Key holding your Pusher `app_key` and `app_secret`,
select that Key plus your app id and cluster on the settings form, then grant the
**pusher_mini use** permission to whichever roles should load the Pusher client on
the front end, and **pusher_mini authenticate** to roles that should be able to
authenticate for private/user channels. Your front-end JavaScript then reads
`window.PusherConfiguration` to connect. If you only ever use public channels, you
can switch the auth endpoint off from the settings form.
