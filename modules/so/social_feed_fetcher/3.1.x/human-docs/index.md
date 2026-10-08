# Social Feed Fetcher — manual setup guide

**Social Feed Fetcher** (`social_feed_fetcher`) pulls posts from social platforms
into Drupal **nodes**, so a "social wall" on your site is built from content the
site actually owns rather than from an embedded third-party widget. It depends on
core's Node module and runs on Drupal 10 and 11.

The distinction is worth understanding before you install it. An **embedded
widget** is a third-party script that loads on every page view, tracks the
visitor, usually needs a consent banner, and breaks the day the platform changes
its embed code. **Fetching into nodes** — what this module does — stores each
post as local content: it is cached, themed like the rest of your site, indexed
by the site's own search, still there when the platform's API is down, and it
keeps working when the embed would not.

The honest thing to plan around is that the ongoing cost here is not the module —
it is the **credentials**. Social platform APIs have become hostile to this use
case: Twitter/X closed its free API tier, Instagram requires a Facebook app
review and a business account, and Facebook's page tokens expire and must be
refreshed. So each platform you want to pull from needs an app registered and a
token stored, and someone has to notice when a token expires — because the
failure mode is a feed that quietly stops updating, not an error anyone sees.
Store those tokens securely (a Key entity backed by an environment variable, not
exported configuration), and remember two things: imported posts are other
people's content, so check the platform's terms before republishing at length,
and fetched HTML is untrusted input that should pass through a text format rather
than going straight into a template.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form and the platform
   credentials you'll need to supply.

## Where it lives in the admin menu

The module provides a settings form (config `social_feed_fetcher.settings`) where
you enter each platform's credentials and choose what to fetch. Access to the
fetched-post entities is gated by the **administer socialpost entity** permission,
so grant that only to trusted administrators.
