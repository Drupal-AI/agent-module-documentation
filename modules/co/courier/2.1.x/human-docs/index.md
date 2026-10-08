# Courier — manual setup guide

**Courier** (`courier`) is a framework module that stores and sends multi‑channel
messages to "identities" (message recipients). Rather than each module writing its
own mail code, a module can hand Courier a set of templates — one per channel, such
as email — grouped into a **template collection**, and Courier renders them,
replaces tokens, and delivers a message using each recipient's preferred channel.
Out of the box it ships an email channel and a bridge that links that channel to
Drupal user accounts.

Courier is primarily a **developer/API module**: you rarely configure it directly.
Dependent modules — originally [RNG](https://www.drupal.org/project/rng), the event
registration module — drive it by defining channels and template collections and
calling Courier's central service to send. The value it provides is a single,
reusable messaging backend: per‑recipient channel preferences, a queue so messages
send in the background on cron (or immediately when needed), token replacement from
a declared context, and a clean extension point for adding new channels like SMS.

The building blocks are: a **Channel** (a template entity type per delivery method
— Courier's `courier_email` has a subject and a formatted body); a
**CourierContext** declaring which tokens are available; a **TemplateCollection**
grouping at most one template per channel; an **Identity** (any entity that can
receive a message); and an **IdentityChannel** plugin bridging a channel to an
identity type. Two submodules ship with it — **Courier System** (replace core
user/account emails with Courier templates) and **Courier Message Composer** (a
one‑off message composer that is **not compatible with Drupal 11**).

Its own configuration is minimal: a settings form for the send queue and channel
preferences, plus a maintenance form. Access to those is gated by the restricted
**Administer courier** permission. Courier depends on core's **Text** module and on
the contrib **Dynamic Entity Reference** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its Dynamic
   Entity Reference dependency) with Composer, enable it, and pick submodules.
2. [Configuration](configuration/index.md) — the queue/channel‑preference settings,
   the maintenance form, and the permissions.

## Where it lives in the admin menu

- **Settings:** **Configuration → Communication → Courier**
  (`/admin/config/communication/courier`), behind the *Administer courier*
  permission.
- **Maintenance:** **Configuration → Communication → Courier → Maintenance**
  (`/admin/config/communication/courier/maintenance`).

## How to use it

Because Courier is a framework, most sites install it as a **dependency of another
module** (such as RNG or the Courier System submodule) rather than using it
directly. The typical flow is:

1. Install and enable Courier (see [Installation](installation/index.md)) along with
   the module that drives it.
2. Review Courier's settings — decide whether messages queue for cron or send
   immediately, and set the channel preference order per identity type (see
   [Configuration](configuration/index.md)).
3. Let the driving module (or your own code) define the channel templates and
   template collections and call Courier's `courier.manager` service
   (`sendMessage()`), which renders each applicable channel, applies tokens, and
   either sends now or enqueues the message.

To **replace Drupal's core account/user emails** with Courier‑managed templates,
enable the **Courier System** submodule.

### Extending Courier (for developers)

Add a new delivery channel (for example SMS) by creating a channel entity type and
an `@IdentityChannel` plugin that bridges that channel to an identity entity type
(Courier ships `CourierEmail`/`User` linking the email channel to Drupal users,
plus a `broken` fallback). Installing the contrib **Token** module adds an improved
token‑selection UI to the message edit forms.
