# Configuration

Protected Download is configured from core's file system settings, plus a choice on
each file or image field you want to protect.

## Set up the protected file system

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Media → File system**
   (`/admin/config/media/file-system`).
3. In **File system path for HMAC protected files**, enter a path where protected
   files are stored. It is **recommended to place this outside the document root**, so
   the files are never web‑accessible except through a signed link.
4. Optionally adjust the cache settings inside the **Protected file system** fieldset
   (see below).
5. Click **Save configuration**.

## Cache lifetime settings (Minimum / Maximum TTL)

Because the generated links are cacheable by browsers and intermediate caches, the two
TTL settings control the trade‑off between cache efficiency and how long a link stays
valid. Choose them carefully — protected files are reachable by *anyone* who has a
valid link, including anonymous visitors.

- **Minimum TTL** — must be **higher than any expiry embedded in your generated
  markup**, and in particular higher than the **Expiration of cached pages** setting on
  **Configuration → Development → Performance**. If it is too low, links can expire
  before the page that contains them leaves the cache.
- **Maximum TTL** — set this **as high as is reasonable**. The bigger the gap between
  Minimum and Maximum TTL, the better your cache hit ratio — but also the longer a
  leaked URL would remain usable. Balance efficiency against exposure.

## Point a file or image field at the protected file system

Once the protected path exists, you can store uploads there:

1. Go to a file or image field's storage settings (**Structure → Content types →
   *(type)* → Manage fields → *(your field)***).
2. Set the field's **Upload destination** to **Protected files**.

Files uploaded to that field are now delivered only through signed, expiring links
rather than a permanent public URL.

## Tokens for emailing links

The module provides two replacement tokens, useful for sending an expiring link by
email (for example, from a Rules "Send mail" action after an order is paid):

- `[site:protected-download-expire]` — the expiry date of a protected download
  generated now.
- `[file:protected-download-url]` — the web‑accessible, authenticated URL for the file.

## A note on security

Keep the site's HMAC key secret — the entire scheme rests on it. Treat any valid,
unexpired link as a capability: whoever holds it can download the file, so deliver
links over secure channels and keep expiry windows no longer than you need.
