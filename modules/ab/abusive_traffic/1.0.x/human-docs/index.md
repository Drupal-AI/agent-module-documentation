# Abusive Traffic — manual setup guide

**Abusive Traffic** (`abusive_traffic`) reads your server's **Apache access-log
files** and picks out the IP addresses that are hammering the site with excessive
requests, so an administrator can decide to ban them. It is a security and
operations aid for spotting traffic abusers.

One important thing to understand about its scope: the module **only identifies**
the offending IP addresses — it does not block them itself. Actually stopping the
traffic is a separate step you take with another tool, such as your firewall or
Drupal's Ban module. Think of this as the detection half of the job.

Because it works by reading server log files, it touches operational and personal
data — access logs contain visitor IP addresses and the URLs they requested. That
makes it a tool to keep firmly in the hands of trusted administrators. It plays no
role in controlling who can access site content; it is purely an analysis tool.

This guide is written for a **human** setting the module up through the admin UI.
If you want the terse, token-cheap reference written for an AI coding agent, read
the sibling [`agent/`](../agent/start.md) docs instead.

> **Note on the available documentation.** The upstream agent docs describe the
> module's purpose but do not spell out an exact settings-page path or a
> field-by-field breakdown of its log-parsing options, so the description below is
> high-level. Confirm the specifics against the module's own README once it is
> installed.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

After enabling the module, point it at your Apache access-log files and let it
parse them to surface the IP addresses making excessive requests. Review that
list, then ban the genuinely abusive addresses using your firewall or Drupal's
Ban module — remember the module identifies IPs but does not block them for you.
Keep access to the tool restricted to trusted administrators, since it exposes
log data that includes visitor IPs and URLs.
