# Configuration

To do anything useful the module needs to know how to reach your MaPS System
instance and be given valid credentials. The upstream documentation is sparse,
so this page describes the setup in general terms — confirm the exact field
names and location against your installed release.

## Connect to MaPS System

After enabling the module, provide its connection settings under
**Configuration** (its own settings area). At minimum you will supply:

- The **MaPS System API endpoint** (base URL) for your instance.
- The **credentials** the API requires (for example an API key or a
  username/password pair).

Once the connection is configured, the module can synchronise digital assets and
product data from MaPS System into Drupal as media and content, including
translated values.

## Store credentials as secrets

MaPS credentials are secrets — never hard-code them in code or commit them to
version control. Store them in an **environment variable**, and where the module
supports it, reference them through a **Key** entity (the Key module's
environment provider reads a variable without exposing its value in
configuration). Make sure the API connection uses **HTTPS** so the credentials
are not sent in the clear.

If you are running DDEV, you can set an environment variable for the web
container with DDEV's dotenv support and restart, then reference it from Drupal —
see your project's setup notes for the exact commands.

## Permissions

The module provides its own permission to govern who can work with the sync.
Grant it on **People → Permissions** to trusted, administrative roles only,
since the sync connects to an external system with credentials and imports data
into your site.

## What the sync does and does not protect

The module imports external data; access to the resulting content and its
translations follows Drupal's normal **content-translation** and field access
rules. It has no access-control role of its own beyond its permission, so make
sure the fields and entities the data lands in have appropriate access settings
on the Drupal side.
