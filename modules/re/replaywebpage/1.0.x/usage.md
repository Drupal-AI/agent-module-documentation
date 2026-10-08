<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ReplayWeb.page plays web archive files using ReplayWeb.page.

---

ReplayWeb.page plays **web archive files** (WARC/WACZ captures of web pages) in the browser using the
**ReplayWeb.page** viewer — so archived web content stored as media can be replayed/browsed on the site. It
depends on core Media, in the Custom package.

Use it to present web-archive captures. It is a media/display feature. Security note: it **replays archived
web content**, which is essentially embedding potentially-**untrusted third-party content** — ReplayWeb.page
sandboxes replay (it renders the archive in an isolated context via a service worker), but treat the archives
you host as you would any embedded external content (host trusted archives, and understand replayed pages can
contain their own scripts running in the sandbox). It loads the ReplayWeb.page viewer assets. It has no
access-control role. Configure the web-archive media and viewer.

---

- Play WARC/WACZ web archives.
- Use the ReplayWeb.page viewer.
- Replay archived web pages.
- Depend on core Media.
- Browse archived content.
- Render archives in the browser.
- TREAT archives as untrusted embedded content.
- Rely on ReplayWeb.page's sandboxing.
- Host trusted archives.
- Have no access-control role.
- Configure the archive media.
- Handle web archives.
- Replay archives.
- Configure the viewer.
- Play captures.
- Handle the replay.
- Browse archives.
- Render captures.
- Set up archives.
- Provide archive replay.
