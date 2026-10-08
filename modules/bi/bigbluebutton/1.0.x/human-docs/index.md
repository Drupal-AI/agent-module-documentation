# Big Blue Button — manual setup guide

**Big Blue Button** (`bigbluebutton`) integrates BigBlueButton — the open-source
web-conferencing and virtual-classroom system — into Drupal as a field. Content on
your site can then host and join BBB meetings and manage recordings, which makes it
handy for course pages, event pages, or any content that needs a live video room.

It works by adding a field, so you attach BBB meeting capability to whichever content
types make sense for your site. The connection to your BigBlueButton server is
configured centrally, and the module defines its own permissions to control who may
create meetings and manage recordings.

BigBlueButton's API is authenticated with a **shared secret**. The module builds
properly signed API URLs using that secret (the standard BBB SHA-checksum signing),
so calls to your BBB server are authenticated. The secret is a credential: store it
securely, always talk to the BBB server over HTTPS, and gate meeting and recording
management behind the module's permissions. The [Configuration](configuration/index.md)
guide covers the server URL and secret. The module's security posture around signing
was reviewed and found sound.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — connect your BigBlueButton server
   (URL + shared secret) and set permissions.

## Where it lives in the admin menu

The connection settings live at the module's settings form
(`bigbluebutton.settings`), and its permissions are set under **People →
Permissions** (`/admin/people/permissions`).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Enter your BigBlueButton server URL and shared secret, storing the secret
   securely (see [Configuration](configuration/index.md)).
3. Add the BigBlueButton field to the content types that should host meetings, and
   grant the meeting/recording permissions to the appropriate roles.
