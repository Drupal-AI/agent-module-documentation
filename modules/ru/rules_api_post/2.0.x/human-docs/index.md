# Rules API Post — manual setup guide

**Rules API Post** (`rules_api_post`) is a **worked example** — documentation and
sample code — for replicating Drupal content to an external system over REST. It
adds a single **Rules action plugin**, *API POST*, that sends entity data to a
configured REST API using the `hal_json` format. The idea is that a reaction rule
fires on some event (a node being created, say) and POSTs that content to another
site or service.

Because it's meant as a learning and starting point rather than a turnkey feature,
the module also ships two demo content types and an example Rule configuration so you
can see the pattern end to end. Its lineage traces back to the *Rules HTTP Client*
project, which it credits.

A few honest caveats. The project describes itself as a working example and is
marked "no further development"; the maintainers note plans (not yet done) to move
from `hal_json` to JSON:API. The `hal_json` format it relies on has been moved out
of Drupal core, so you'll need the HAL and related web‑services modules enabled. And
because the action makes the server POST to a remote API, treat it like any outbound
integration — the destination URL and credentials come from the rule/action
configuration set by an administrator.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Rules dependency.

There is **no dedicated configuration page** for this module. You configure the
action inside a Rule, described in "How to use it" below.

## How to use it

The action lives inside the **Rules** UI, not on a settings page of its own:

1. Make sure the web‑services modules the `hal_json` format needs are enabled —
   typically **HAL**, **Serialization**, **RESTful Web Services**, **HTTP Basic
   Authentication**, and (for setup convenience) **REST UI**.
2. Go to **Configuration → Workflow → Rules** and create a reaction rule (or open
   the bundled example rule that this module imports).
3. Choose the event that should trigger replication — for example *After saving a
   new content item*.
4. Add the **API POST** action to the rule. Configure the target REST API endpoint,
   the authentication (the basic‑auth credentials/token), and which entity data to
   send.
5. Save the rule and test it by performing the triggering action, then confirming the
   data arrives at the remote API.

The two bundled demo content types and the sample rule are there to show a complete,
working configuration you can copy and adapt for your own integration.

> **Good practice:** restrict who can administer Rules — a Rules author can make the
> server POST to arbitrary endpoints. Use static, admin‑controlled destination URLs
> and store credentials carefully.
