# JWT Block — manual setup guide

**JWT Block** (`jwt_block`) provides a Drupal block that outputs a **signed JSON
Web Token** for the current user or context — along with a link to an endpoint that
uses that token. The idea is to bridge server‑side Drupal identity to something
running in the browser: a JavaScript front‑end or an external service can read the
token from the page and use it to authenticate on the client side.

The token is signed by the **JWT** module (which manages its keys through the
**Key** module, ideally backed by an environment variable). The block is designed
to be **extended**: by subclassing it you can change the payload — the claims that
go into the token — to carry whatever the consuming app needs.

Because the block emits a per‑user credential, treat it carefully: scope the
token's claims and lifetime to the minimum the consumer needs, and make sure the
block is cached **per user** (never shared across users) so one visitor's token
can't leak to another. The module depends on core's **Block** module plus the
**Key** and **JWT** modules, and it requires the **GMP** PHP extension. It supports
Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, satisfy the JWT,
   Key, and GMP requirements, and enable it.

This module has **no central settings form**. You configure it by placing (and
optionally extending) its block, described in "How to use it" below.

## Where it lives in the admin menu

JWT Block adds no dedicated settings page. You place its block from **Structure →
Block layout** (`/admin/structure/block`), and the token's signing keys are managed
in the JWT and Key modules under **Configuration → Security**.

## How to use it

1. Configure the **JWT** module first — it needs a signing key, which it stores
   through the **Key** module (see the JWT module's own documentation). This is
   what actually signs the tokens the block emits.
2. In Drupal, go to **Structure → Block layout** (`/admin/structure/block`), click
   *Place block* in your chosen region, and place the **JWT Block**.
3. To change what goes into the token, **extend the block class** in a custom
   module and override its payload — the default block emits a token for the
   current user/context, and subclassing lets you add or adjust the claims.
4. Make sure the block is cached per user and its token lifetime is short, so the
   emitted credential is scoped tightly.

> **Known limitation:** at the time of writing the module supports only JWE
> encryption and its supported encryption is hard‑coded, pending upstream issues on
> drupal.org. Check the project page for the current status before relying on a
> particular signing/encryption mode.
