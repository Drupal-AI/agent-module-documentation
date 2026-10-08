# Social Auth Decoupled — manual setup guide

**Social Auth Decoupled** (`social_auth_decoupled`) is a **base module for
decoupled (headless) social login**. It extends the Social Auth framework so that
a separate front end — a React, Vue, or other decoupled client — can drive social
authentication and receive back the authenticated user's ID together with a
**CSRF token** to use on subsequent requests. It is a foundation for other
modules rather than a standalone feature.

On its own it does not add a login button for a particular provider. Instead it
provides base functionality that decoupled social‑login modules build on, and it
is designed to work with any Social Auth network configuration. Modules that
already build on it include the Social Auth Google API and Social Auth Facebook
API projects. It depends on the **Social Auth** module and core's **System**
module.

Because it is a base/developer module, there is no settings form to fill in — you
enable it as a dependency of a decoupled social‑login implementation, and the
provider details (client ID/secret and so on) are configured on whichever Social
Auth network module you pair it with. The underlying OAuth provider flow,
including the `state`/CSRF handling for the provider round‑trip, is handled by the
Social Auth framework; this module additionally uses Drupal core's CSRF token
generator to issue a token to the decoupled client.

A few security points from the module's own docs apply to any decoupled auth
setup built on it: serve everything over **HTTPS**, make sure the front end stores
and uses the returned token safely, and validate and scope which origins are
allowed to drive the flow (CORS). It grants access through the Social Auth login it
wraps and has no access‑control role of its own. Note that the project is **not**
covered by Drupal's security advisory policy and is currently **seeking a new
maintainer**.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it as the base for a decoupled social‑login implementation.

## How to use it

Social Auth Decoupled is a building block. In practice you enable it alongside a
decoupled social‑login module (for example one built on Social Auth Google API or
Social Auth Facebook API) and configure the provider credentials on that module.
Your decoupled front end then drives the login flow and, on success, receives the
authenticated user's ID and a CSRF token to authorise its follow‑up requests. There
is no configuration form on this module itself.
