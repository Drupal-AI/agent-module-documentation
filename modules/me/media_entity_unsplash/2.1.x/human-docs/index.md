# Media Entity: Unsplash — manual setup guide

**Media Entity: Unsplash** (`media_entity_unsplash`) integrates
[Unsplash](https://unsplash.com/)'s library of millions of free, high-quality
photos into your Drupal site as media. You either paste an Unsplash photo ID or
URL, or search Unsplash straight from the media form, and the module fetches the
image through the Unsplash API, stores it locally, and generates the photographer
attribution Unsplash requires. It works seamlessly with Drupal's Media Library,
depends only on core modules (Image, Media Library, Path, User) plus the
`unsplash/unsplash` PHP SDK, and runs on Drupal 11.3 and 12.

Attribution is handled for you: because Unsplash photographers contribute their
work for free and attribution is how they benefit, the module automatically
produces the "Photo by *Photographer* on Unsplash" credit with profile links, so
you stay compliant with Unsplash's API terms without extra effort.

Two things set this module apart from the plain "paste a URL" media sources and
shape how you set it up. First, it talks to the Unsplash API on your behalf, so it
needs **API credentials** — you create a free Unsplash application to get an Access
Key and Secret Key, which you enter on the Unsplash media type's configuration
form. Second, because it *downloads* each photo and stores it locally, the images
become ordinary local files (so image styles and the rest of Drupal's image
handling apply normally) — but the fetch means your server makes outbound (egress)
calls to Unsplash's API whenever an editor adds or searches for a photo.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (which also pulls the Unsplash PHP SDK) and enable it alongside its core
   dependencies.
2. [Configuration](configuration/index.md) — create an Unsplash application, get
   your Access Key and Secret Key, and connect the module.

## Where it lives in the admin menu

The Unsplash media source is set up like any other media source, under **Structure
→ Media types** (`/admin/structure/media`). The API credentials are entered on the
**Unsplash** media type's edit form (`/admin/structure/media/manage/unsplash`).
Individual photos are added from **Content → Media** (`/admin/content/media`) or
through the Media Library.

## How to use it

1. Complete the [Configuration](configuration/index.md) steps so the module has a
   working Unsplash Access Key and Secret Key.
2. The module ships an **Unsplash** media type that uses the Unsplash media source
   — you can use it as-is or create additional types on the same source.
3. Add an Unsplash photo from **Content → Media → Add media → Unsplash**. Start
   typing keywords to search Unsplash, or paste a photo ID or full URL. The module
   downloads the image, stores it locally, and attaches the photographer
   attribution automatically.
4. Reference the photo anywhere media is supported — media reference fields, the
   Media Library, and CKEditor.
