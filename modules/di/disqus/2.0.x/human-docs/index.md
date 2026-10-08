# Disqus — manual setup guide

**Disqus** (`disqus`) integrates the hosted [Disqus](https://disqus.com)
commenting service into Drupal. Instead of (or alongside) Drupal's own comment
system, each piece of content renders a Disqus discussion thread, and the comments
themselves live on Disqus's servers — not in your database. Disqus handles the
posting UI, moderation, and spam filtering for you.

Setup has two essential parts. First, you tell Drupal your Disqus site
**shortname** — the identifier from your Disqus account (for `example.disqus.com`
the shortname is `example`). You will need a Disqus account and a registered site
to get one; the module does not create it for you. Second, you attach a **Disqus
comments** field to any entity bundle (article, blog post, even users or media),
which is what actually places a thread on those entities.

Beyond the basics, the module ships display blocks (recent comments, popular
threads, top commenters, and a combined widget), a Views field for comment counts,
and several optional integrations: Single Sign-On so logged-in Drupal users
comment under their site identity, API-driven updating or closing of threads when
content is edited or deleted, new-comment notification emails, and Google
Analytics event tracking. The advanced features require Disqus API credentials and
the bundled `disqus/disqus-php` PHP library.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in the
   Disqus PHP library) and enable the module.
2. [Configuration](configuration/index.md) — enter your shortname, attach the
   comments field, the optional API/SSO settings, blocks, and permissions.

## Where it lives in the admin menu

The main settings form is at **Configuration → Web services → Disqus**
(`/admin/config/services/disqus`), gated by the *Administer disqus* permission.
Comments are switched on per bundle from that bundle's **Manage fields** page, and
the display blocks are placed under **Structure → Block layout**.
