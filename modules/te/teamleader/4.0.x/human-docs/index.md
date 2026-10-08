# Teamleader — manual setup guide

**Teamleader** (`teamleader`) integrates the **Teamleader** CRM and
business‑management platform with Drupal through Teamleader's API. It gives your
site an authenticated connection to Teamleader (over OAuth2) so you can push data
such as contacts and leads from Drupal into your CRM. A bundled example submodule,
**`teamleader_contact`**, shows the pattern in action: it saves submissions from
Drupal core's Contact form as contacts in Teamleader.

The 4.0.x branch — the current, actively developed one — connects using the
`janhenkes/teamleader-php-sdk` PHP library (installed automatically with Composer)
and requires Drupal 10.2 or newer and PHP 8.1 or newer. The module provides its
own permissions and can optionally use the **Key** module to store your OAuth2
client ID and secret securely.

A couple of security points matter here. The module authenticates to the Teamleader
API with **OAuth2 client credentials**, which are secrets — keep the client ID,
client secret and any tokens out of version control by storing them in environment
variables and, ideally, behind a **Key** entity, and always connect over HTTPS.
And because the integration **sends contact and customer data (personal
information) to Teamleader**, a third‑party service, treat it as a data‑egress and
privacy matter and handle it in line with your privacy policy. The module adds no
access control of its own beyond its permissions.

This guide is written for a **human** working through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module (and the contact submodule), and note the PHP requirement.
2. [Configuration](configuration/index.md) — enter your Teamleader app client ID
   and secret and connect.

## Where it lives in the admin menu

The connection settings are at **Configuration → Web services → Teamleader**
(`/admin/config/services/teamleader`), where you enter your Teamleader app
credentials and follow the on‑screen instructions to connect.
