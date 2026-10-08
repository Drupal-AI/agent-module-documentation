# Mautic Content Provider — manual setup guide

**Mautic Content Provider** (`mautic_content_provider`) exposes Drupal **nodes and
views as clean, email‑friendly HTML** so that **Mautic** can pull your Drupal content
into its email campaigns. Instead of copying content by hand into Mautic templates,
you let Mautic fetch selected Drupal content as dynamic content blocks.

It works by letting you choose which **nodes** are exposed and in which **view
modes**, and it adds a **Views display type** specifically for producing Mautic
output. The rendered HTML is stripped down to what email clients handle well, so the
content drops cleanly into a Mautic email template.

There is an important dependency on the Mautic side: for the exposed content to be
usable in Mautic, you must enable the **"Drupal Integrated Content"** Mautic plugin
on your Mautic installation. Drupal exposes the content; the Mautic plugin consumes
it.

Because this feature publishes selected content to an endpoint Mautic reads, be
deliberate about **which content you expose** and keep endpoint access appropriate to
your needs. It supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose the nodes and view modes to
   expose, and add the Mautic Views display.

## Where it lives in the admin menu

Its settings form is at **Configuration → Web services → Mautic Content Provider**
(`/admin/config/services/mautic-content-provider`). The Mautic Views display type is
added on any view, under its **Displays** in the Views UI.
