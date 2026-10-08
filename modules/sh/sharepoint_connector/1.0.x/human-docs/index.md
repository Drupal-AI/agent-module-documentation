# Sharepoint Connector — manual setup guide

**Sharepoint Connector** (`sharepoint_connector`) adds a customizable connection
between Drupal and Microsoft SharePoint. Its most common use is pushing data out of
Drupal and into SharePoint — for example, sending Webform submissions to a
SharePoint location — but it can also serve as a general bridge for integrating
SharePoint with your site. It depends on the **Webform** module.

You configure the connection with your SharePoint / Microsoft app credentials, and
from there Drupal can send data across on your behalf. The module uses Drupal's
standard HTTP client for its requests (TLS certificate verification is *not*
disabled), so traffic goes over a normal secure connection.

A few things to keep in mind as an operator: the app credentials it uses (client ID
and secret, or a token) are secrets — store them as secrets rather than in exported
configuration, and always operate over HTTPS. Because the data you send (such as
form submissions) may contain personal information, treat this as a data-handling
consideration and be mindful of what leaves your site. The module has no
access-control role of its own.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and its Webform dependency.

## How to use it

After enabling the module (and Webform, which it requires), set up the SharePoint
connection with your app credentials, keeping those credentials in a secret store
such as an environment variable. Once the connection is in place, you can route
data — typically Webform submissions — into SharePoint. Handle any personal data in
those submissions responsibly and keep the connection on HTTPS.
