# Checkpost — manual setup guide

**Checkpost** (`checkpost`) locks a non-production site behind an allowlist so that
only requests you approve can reach it. It's aimed at staging, QA, and pre-launch
environments — the kind of site you don't want crawlers, search engines, or the
public stumbling onto before you're ready. It plays the same role as the popular
[Shield](https://www.drupal.org/project/shield) module, but instead of an HTTP
basic-auth username/password prompt it checks the incoming request against IP
addresses, CIDR ranges, request headers, and allowed page paths.

Under the hood it registers an HTTP middleware that runs before Drupal routes the
request. When enforcement is on, a request is allowed only if it matches one of
your rules: its path is on the allowed-pages list, it carries one of your
configured header name/value pairs, or the visitor's IP matches an allowed IP or
CIDR range. Anything else gets a plain **403 Access Denied**. A common pattern is
to allow your office IPs, add a secret bypass header that you set with a browser
extension such as [ModHeader](https://modheader.com/) or in your CI configuration,
and whitelist health-check or webhook paths so automated systems keep working.

The module is small, has no other module dependencies, and stores all its rules
in configuration — the allowlists never come from request data. It works but does
nothing until you open its settings page, add your rules, and switch enforcement
on.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add your IP, header, and path
   allowlists and turn enforcement on.

## Where it lives in the admin menu

Once enabled, Checkpost's settings form sits at **Configuration → Development →
Checkpost** (`/admin/config/development/checkpost`), reachable by users with the
**Administer site configuration** permission.
