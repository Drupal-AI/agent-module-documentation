# Sharepoint share link — manual setup guide

**Sharepoint share link** (`sharepoint_share_link_filter`) provides a text filter
that recognizes SharePoint share links inside your content and renders them through
Drupal. It works together with the **Sharepoint file download** module, so a shared
SharePoint document referenced in a piece of content can be embedded or linked and
then served through Drupal rather than requiring direct SharePoint access. This is
particularly useful on intranets that pull documents from SharePoint.

Because it is a text filter, you turn it on per text format: enable the filter on
whichever formats (for example *Full HTML* or *Basic HTML*) should process
SharePoint share links. Under the hood it relies on the Sharepoint file download
module's connection and credentials, which should be stored securely via an
environment variable.

This module depends on **Sharepoint file download** (`sharepoint_file_download`),
which in turn depends on the Sharepoint API module. It supports Drupal 8 through 11.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module
   and its dependencies, and turn the filter on for your text formats.

## How to use it

After installing, enable the SharePoint share link filter on the text formats where
you want it active. Go to **Configuration → Content authoring → Text formats and
editors** (`/admin/config/content/formats`), edit a format, tick this module's
filter in the **Enabled filters** list, and save. From then on, SharePoint share
links written in content using that format are handled by the filter and served
through the Sharepoint file download integration.
