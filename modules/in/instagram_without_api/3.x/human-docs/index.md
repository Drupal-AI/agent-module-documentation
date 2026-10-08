# Instagram Without API — manual setup guide

**Instagram Without API** (`instagram_without_api`) shows a block of recent posts
from a **public** Instagram account — with no API key and no access token
required. Where the other Instagram modules need you to register an app and
generate a token, this one simply reads the public profile: it fetches recent
posts from Instagram's public `web_profile_info` JSON endpoint, and if that is
unavailable it falls back to scraping the HTML profile page. The images it finds
are downloaded and stored locally (under `public://instagram_without_api/`) so
they render in the browser without cross‑origin issues.

That convenience comes with a real trade‑off worth understanding before you rely
on it. Because it reads Instagram's public pages rather than a supported API, it
is **inherently fragile**: it works until Instagram changes its page structure or
its anti‑scraping measures, at which point the feed breaks until the module is
updated. Scraping a site may also conflict with Instagram's **terms of service**.
For a low‑stakes decorative feed this is often an acceptable bargain; for anything
important, one of the API‑based Instagram modules is more reliable.

There is no site‑wide settings page — the account name and display options are set
on the block itself when you place it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated configuration page** for this module. All of its settings
live on the block itself — see "How to use it" below.

## Where it lives in the admin menu

It adds no configuration page of its own. You work with it from **Structure →
Block Layout** (`/admin/structure/block`), where you place the "Instagram Without
API" block into a region.

## How to use it

1. Confirm the Instagram account you want to show is **public** (not set to
   private) and that your server can make outbound HTTPS requests to
   `instagram.com`.
2. Go to **Structure → Block Layout** and click **Place block** on your chosen
   region.
3. Search for and select the **Instagram Without API** block.
4. In the block settings, configure:
   - **Instagram User Name** — the public account to pull posts from (for
     example, `drupalassociation`).
   - **Number of images to display** — defaults to 4.
   - **Image width / height** — in pixels, defaults to 200×200.
   - **Cache time** — in minutes, defaults to 1440 (24 hours). A longer cache
     means fewer requests to Instagram and less chance of being rate‑limited.
5. Save. The recent posts should render in the region you chose.

If the feed ever goes blank, it usually means Instagram changed or blocked the
public endpoint — check for a module update rather than assuming your
configuration is wrong.
