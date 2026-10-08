# Configuration

Getting PeerTube videos working is a three‑step sequence. Do them in order, and
clear caches after installing the module.

## 1. Add your PeerTube instance domains

1. Go to **Configuration → Media → PeerTube** (`/admin/config/media/peertube`).
2. Add the **domains** of the PeerTube instances whose videos you want to embed —
   for example the instance(s) your organisation uses or trusts.
3. Save.

This is the heart of what the module does: it tells Drupal that these PeerTube
domains are approved sources, working around core's fixed list of allowed remote
video providers.

> **Only add instances you trust.** Each domain you add becomes an approved source
> that Drupal will fetch oEmbed data and embeds from at display time.

## 2. Allow the PeerTube provider in oEmbed Providers

1. Go to **Configuration → Media → oEmbed Providers → Custom providers**
   (`/admin/config/media/oembed-providers/custom-providers`).
2. Allow / enable the **PeerTube** provider.
3. Save.

## 3. Allow PeerTube on the Remote Video media type

1. Go to **Structure → Media types → Remote video → Manage**
   (`/admin/structure/media/manage/remote_video`).
2. In the media source settings, allow the **PeerTube** provider alongside any
   others (YouTube, Vimeo, etc.).
3. Save.

## You're done

Editors can now add a PeerTube video the same way they add any remote video: create
a **Remote Video** media item and paste the PeerTube video URL from one of the
instances you allowed. The video is fetched from that instance via oEmbed and
rendered through Drupal's media system.

> **Availability note:** because the video is served by the source PeerTube
> instance, its playback and availability depend on that instance staying online.
> If a video stops embedding, check that its instance domain is still listed in step
> 1 and that the instance itself is reachable.
