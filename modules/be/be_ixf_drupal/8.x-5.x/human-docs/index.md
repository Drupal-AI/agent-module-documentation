# BrightEdge Autopilot (be_ixf_drupal) — manual setup guide

**BrightEdge Autopilot** (`be_ixf_drupal`) connects a Drupal site to
[BrightEdge](https://www.brightedge.com/)'s Instant eXperience Framework (IXF).
The idea is that an SEO team manages page-level content — internal link modules,
meta changes, structured blocks — inside BrightEdge, and the site pulls that
content in at render time and injects it into the page. So SEO changes can be made
in BrightEdge without a Drupal deployment.

This module is the Drupal side of that arrangement: a service and factory around
the BrightEdge IXF SDK, a content block for placing BrightEdge "capsules" on
pages, an admin form for the account and connector settings, and an event
subscriber for redirect handling. The content is fetched **server-side** and
rendered as part of your page.

Three things are worth being clear about with any server-side content-injection
integration like this one:

- **It puts a third party in your render path.** If BrightEdge is slow or
  unreachable, page rendering waits on it. Check the SDK's timeout and failure
  behaviour before putting this on a high-traffic template, and make sure a vendor
  outage degrades gracefully rather than blocking the page.
- **Injected content is content you did not review.** Whatever BrightEdge returns
  is rendered under your domain. That is the intended behaviour, but it means your
  trust boundary now includes the BrightEdge account — anyone who can publish a
  capsule there can publish on your site.
- **The settings page is administrator-only, by accident.** Its route requires a
  permission named `administer` that does not actually exist in Drupal, which
  fails closed: only roles flagged as full administrators can reach the form, and
  the setting cannot be delegated to an SEO-only role.

This module talks to BrightEdge using account credentials. **Treat those as
secrets** — store them in an environment variable, never hard-code or commit them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the class names
and the permission finding in condensed form — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — connect the site to your BrightEdge
   account and place capsules.

## Where it lives in the admin menu

Once enabled, the connector is configured at **Configuration → Web services →
BrightEdge** (`/admin/config/services/brightedge`, route `brightedge.admin_form`).
That page is reachable only by full administrators (see the permission note
above). Capsules are placed on pages with the module's **IXF Content Block**
through Block layout or Layout Builder, so normal block visibility conditions
apply.
