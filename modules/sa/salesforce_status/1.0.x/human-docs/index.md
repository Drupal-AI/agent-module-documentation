# Salesforce Status — manual setup guide

**Salesforce Status** (`salesforce_status`) watches the health of your site's
Salesforce connection and reacts when it changes. It is meant for sites where
sending or receiving data from Salesforce is critical, and where you need to know —
and act — quickly if that link stops working.

To decide whether Salesforce is up, the module checks a basic Salesforce endpoint
(`/sobjects`). A successful response confirms both that the OAuth token is valid (or
has been refreshed) and that Salesforce is answering. On top of that check, it does
three useful things: it **dispatches events** when the connection changes state
(from stable to failing, and from failing back to normal) so other modules can
respond; it adds a **queue processor** that suspends push processing while the
endpoints are failing, so items are not sent into a broken connection; and it logs
the transitions and reports an unavailable Salesforce on the site's **status
report**.

The core module has no settings form — it works once enabled, alongside a
configured Salesforce Suite. Its real power is for developers, who can subscribe to
its two events (`STATUS_FAIL` and `STATUS_BACK_TO_NORMAL`) to run their own logic
when the connection changes. For email alerts, there is an optional **Salesforce
Status Mail** submodule (`salesforce_status_mail`), which sends notifications and
serves as a worked example of subscribing to the events.

It depends on the **Salesforce Suite** (`salesforce`), which owns the actual
connection and its credentials — this module only observes status and emits events,
and has no access-control role of its own. It requires no third-party PHP libraries.

This guide is written for a **human**. If you are an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — Composer, the Salesforce Suite
   dependency, enabling the module, and the optional mail submodule.

## How to use it

Once enabled with a working Salesforce Suite connection, Salesforce Status runs on
its own: it checks the endpoint, logs connection changes, suspends the push queue
when Salesforce is unreachable, and reports availability on the status report at
**Reports → Status report** (`/admin/reports/status`).

To react to connection changes in your own code, subscribe to the module's events:

- `\Drupal\salesforce_status\Event\SalesforceStatusEvents::STATUS_FAIL` — fired when
  the connection goes from stable to failing.
- `\Drupal\salesforce_status\Event\SalesforceStatusEvents::STATUS_BACK_TO_NORMAL` —
  fired when it recovers.

The `salesforce_status_mail` submodule is a ready-made example of exactly this,
turning those events into email notifications. If you enable it, configure the
recipients appropriately — bear in mind status emails can carry connection detail,
so send them only to the right people.
