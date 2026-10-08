# Sessionless API — manual setup guide

**Sessionless API** (`sessionless`) is a developer-oriented module that provides an
API for building *stateless* features using cryptographically signed tokens. The
idea is to carry the small amount of state you need inside an encrypted, signed
token — in a sticky query string or a hidden form field — instead of storing it in a
server-side session. In special cases (not as a general replacement!) this lets you
avoid server state and cookies altogether, which can be handy for high-scale or
decoupled scenarios where session storage is something you'd rather not maintain.

The module leverages JWT-style encrypted and signed tokens for two concrete uses the
maintainers call out: keeping app state in sticky queries, and storing a form's
state encrypted and signed in a hidden HTML field. It is a building block for
developers — there is no admin UI and no content of its own.

Because everything rests on the tokens, two things matter: the signing key/material
must be stored securely (keep it in the environment, not in committed config), and
token validation must be done correctly. The module has no access-control role of
its own. It needs no other modules and supports Drupal 10 and 11.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

There is no settings form. Sessionless is an API you build against: enable it, make
sure its signing material is provided securely through your environment, then use
its token facilities from your own code to sign and validate the state you want to
carry in sticky queries or hidden form fields. Treat token validation as
security-sensitive and keep the signing key out of version control.
