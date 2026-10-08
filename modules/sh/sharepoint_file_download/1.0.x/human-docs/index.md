# Sharepoint file download — manual setup guide

**Sharepoint file download** (`sharepoint_file_download`) lets people download
SharePoint-hosted documents through Drupal by using a shareable URL ID. Rather than
giving intranet users direct access to SharePoint, Drupal fetches the file from
SharePoint on their behalf (proxying it via the **Sharepoint API** module) and
hands it back as a download. It is a convenient way for intranet users to reach
shared documents without a SharePoint account of their own.

Downloading is gated by the **Download sharepoint files**
(`download sharepoint files`) permission, so you decide which roles are allowed to
pull files through this route. The files themselves are fetched using the
SharePoint connection you configure through the Sharepoint API module, whose
credentials should be backed by an environment variable.

This module builds directly on **Sharepoint API** (`sharepoint_api`), which it
requires. It supports Drupal 8 through 11.

A note on access: because the module fetches files from SharePoint using the site's
configured credentials, anyone you grant the *download sharepoint files* permission
can retrieve documents through it. Restrict that permission to trusted roles only.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module
   and its Sharepoint API dependency.

## How to use it

Once the module is enabled and the Sharepoint API connection is configured, users
with the *download sharepoint files* permission can download a SharePoint document
by providing its shareable URL ID; Drupal fetches the file from SharePoint and
serves it. Review the permission grants at **People → Permissions**
(`/admin/people/permissions`) and keep the *download sharepoint files* permission
limited to roles you trust.
