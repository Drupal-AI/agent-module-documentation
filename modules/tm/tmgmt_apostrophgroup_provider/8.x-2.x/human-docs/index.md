# Apostroph Group Translator — manual setup guide

**Apostroph Group Translator** (`tmgmt_apostrophgroup_provider`) is a translation
provider plugin for the [Translation Management Tool](https://www.drupal.org/project/tmgmt)
(TMGMT). It connects Drupal to the **Apostroph Group** professional language
service (their "myApostroph" REST platform), so you can send content straight from
Drupal for translation and get the finished translation imported back into your
site automatically — no copying and pasting into a separate portal.

When you request a translation, the module exports each TMGMT job item to XLIFF,
zips it up, and POSTs it to the Apostroph service over its REST API using HTTP
Basic authentication. The remote translation id it gets back is stored as the job
reference. Finished translations come back in one of two ways: automatically on
cron (if you enable that per translator), or by manually triggering a "semi
import" for a single job. Deleting or aborting a job calls Apostroph's cancel
endpoint. All communication is outbound (plus cron polling) — there is **no
inbound webhook or callback route**, so nothing on your site is exposed for an
anonymous party to trigger.

A couple of things are worth handling with care. The connector credentials
(username and password) are stored as **plaintext** in the TMGMT translator
configuration entity — this is standard for TMGMT providers, but it means you
should treat any exported configuration as sensitive. More importantly, the
exported source ZIP/XLIFF files default to the **public** file scheme, and a
download link to them is surfaced in an on-screen status message — so for any
confidential content, switch the translator's file scheme to **private**. See the
[Configuration](configuration/index.md) page for exactly where.

It works over HTTPS with TLS certificate verification left at Guzzle's secure
default (it is never disabled). It depends on TMGMT and the TMGMT File submodule,
and requires Drupal 10 or 11. Getting a working setup requires a username,
password, and client/customer id from Apostroph Group.

This guide is written for a **human** setting the module up by hand. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in TMGMT
   and TMGMT File, and enable the module.
2. [Configuration](configuration/index.md) — add the Apostroph translator, enter
   your credentials, choose the file scheme, and optionally enable cron delivery.

## Where it lives in the admin menu

The provider is configured like any other TMGMT translator, under
**Configuration → Regional and language → Translation providers** (TMGMT →
Providers). Add a translator that uses the **Apostroph Group Connector** plugin and
fill in its settings there.
