# Mailchimp Events — manual setup guide

**Mailchimp Events** (`mailchimp_events`) lets your Drupal site record what known
visitors do on the site and send those actions to Mailchimp as **events**, so you
can use Mailchimp's **Behavioral Targeting** to build smarter audiences. The
classic example: if someone keeps reading your spaghetti recipes, you can make
sure they land in the audience that gets your pasta newsletter.

The events describe interactions by **known users** — people who are logged in or
otherwise identified by an email address — and once they're in Mailchimp, you can
segment and target based on that behaviour when building campaigns and automations.
You define which events your site sends, and the module manages those event
definitions as entities.

Mailchimp Events used to be part of the main Mailchimp project and has been split
out into its own module. It is **100% dependent on the Mailchimp module** — you
must install and configure Mailchimp (and its list handling, `mailchimp_lists`)
first, or this module has nothing to talk to. It supports Drupal 10 and 11.
Because it sends behavioural data to a third party, review the privacy notes in
[Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Mailchimp
   dependency with Composer.
2. [Configuration](configuration/index.md) — configure the Mailchimp connection,
   define events, and handle data and consent responsibly.

## How it fits together

1. You install and configure the base **Mailchimp** module (with your API key) and
   **Mailchimp Lists** — Mailchimp Events does nothing until these are set up.
2. You **define the events** you want to track as entities in this module.
3. As known users perform those actions on your site, the events are **sent to
   Mailchimp**.
4. In Mailchimp, you use Behavioral Targeting to build audiences and automations
   from that activity.
