# Feeds LDAP — manual setup guide

**Feeds LDAP** (`feeds_ldap`) extends the
[Feeds](https://www.drupal.org/project/feeds) module with an **LDAP fetcher and
parser**: it runs a configured LDAP query and turns the returned directory entries
into Feeds results, so Drupal content can be created or updated automatically from
an LDAP directory. Typical uses are syncing people/staff directories, groups, or
organisational data from LDAP or Active Directory into Drupal content on a
schedule.

It's a port of the old `ldap_feeds` submodule (once part of the D7 LDAP module),
rebuilt for more complex use cases than the simpler periodic‑update mechanism that
replaced it. Feeds gives you more flexibility: mapping advanced attributes through
the UI, combining users from multiple queries, and mapping LDAP results onto
entities other than users.

The heavy lifting of connecting to the directory is handled by the
[LDAP Servers](https://www.drupal.org/project/ldap) and **LDAP Query** modules, on
which this module depends. You define the server connection and the query there,
then use this module's fetcher and parser to feed those query results into a Feeds
importer.

> **The trust boundary is the directory connection.** The LDAP server connection
> uses bind credentials configured in LDAP Servers — store and protect those, and
> prefer **LDAPS or StartTLS** for the directory connection. The query is
> administrator‑defined (not supplied by end users), so LDAP injection from
> visitors isn't the exposure. But directory data becomes Drupal content, so treat
> that data as external input when it's displayed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Feeds, LDAP Servers and LDAP Query.

There is **no separate settings page** for this module. The LDAP connection and
query live in the LDAP Servers / LDAP Query modules, and the fetcher/parser are
configured on a feed type, described in "How to use it" below.

## Where it lives in the admin menu

Feeds LDAP adds no admin page of its own. LDAP servers and queries are configured
under the LDAP modules (**Configuration → People → LDAP**), and the fetcher/parser
appear when you create or edit a feed type at **Structure → Feed types**.

## How to use it

1. Configure your **LDAP server** connection in the LDAP Servers module, using
   secure bind credentials and LDAPS/StartTLS where possible.
2. Define an **LDAP Query** that returns the directory entries you want to import.
3. Create a feed type at **Structure → Feed types** and choose the **LDAP** fetcher
   (pointed at your LDAP query) and the **LDAP** parser.
4. Choose a processor (for example the user or node processor) and map the LDAP
   attributes onto your entity's fields.
5. Add a feed at **Content → Feeds** and run the import, or set a periodic import so
   it refreshes on cron.
