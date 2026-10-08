# Antispam by CleanTalk — manual setup guide

**Antispam by CleanTalk** (`cleantalk`) connects your Drupal site to CleanTalk's
cloud anti-spam service so you can filter out spam comments, fake registrations,
and junk form submissions **without ever showing a CAPTCHA**. When a form is
submitted, the module sends the submission's metadata to the CleanTalk API, which
returns an allow-or-deny verdict — so spammers are stopped invisibly and real
visitors are never asked to solve a puzzle.

It protects a wide range of forms — comments, user registration, contact forms,
webforms, forum topics, the search form, node content, and custom or external
forms — and you choose exactly which ones are checked. On top of the per-form
checks it ships a **SpamFireWall (SFW)** that blocks known spam IP addresses and
bots at the request level, before the page even renders, plus optional
Anti-Crawler and Anti-Flood layers and a JavaScript bot detector.

Everything is driven from a single settings form and stored in one configuration
object. The only value you *must* supply is a CleanTalk **Access key**, which you
get from a free or paid account at cleantalk.org. Live spam checks require both a
valid key and outbound network access to the CleanTalk API — without them your
form-protection choices are still saved, but no remote verdicts happen.

The module also adds handy retroactive tools to scan your existing users and
comments for spam and clean them out.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your Access key, choose which
   forms are protected, set up the SpamFireWall, and manage exclusions.

## Where it lives in the admin menu

The settings form is at **Configuration → Content authoring → Antispam by
CleanTalk → Settings**
(`/admin/config/cleantalk/cleantalk_settings_form`). The retroactive scan tools
(Check spam users, Check spam comments) live alongside it under
`/admin/config/cleantalk/`.

## How to use it

1. Create an account at cleantalk.org and copy your **Access key**.
2. Install and enable the module, then open the settings form.
3. Paste your Access key and save — the form validates it against the CleanTalk
   API.
4. Turn on protection for the forms you care about and, if you want request-level
   blocking, leave the SpamFireWall enabled.

See [Configuration](configuration/index.md) for the full walkthrough.
