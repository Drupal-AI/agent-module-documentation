# Configuration

Image Domain Filter is configured the same way as any Drupal text filter: you enable
it on a text format and set its options there. It is most useful on the formats that
handle **untrusted input** — the ones available to anonymous users, commenters, or
lower-trust editorial roles.

## Enable the filter on a text format

1. Log in as a user with the **Administer filters** permission (an administrator by
   default).
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
3. Click **Configure** next to the text format you want to protect (for example
   *Basic HTML* or a custom "Restricted" format used for comments).
4. In the **Enabled filters** section, tick **Restrict images to trusted sites**.

## Set the trusted-host allowlist

With the filter enabled, its options appear in the **Filter processing order** /
**Filter settings** area lower down the same form. There you provide the list of
**allowed hosts/domains** — the hosts from which embedded images are permitted (for
example your CDN or object-storage domain). Any `<img>` pointing at a host not on the
list is not allowed through the filter.

- List the specific hosts you trust (such as your CDN, S3, or Cloudflare domain).
- Keep the list as small as possible — every entry is a host you are choosing to
  trust for embedded images.

### Filter order matters

As with all text filters, the order in which filters run can affect the result. If
you also use HTML-restricting filters, make sure the image domain restriction runs in
a sensible position relative to them (Drupal lets you drag filters into order on the
same form). Review the processing order after enabling.

## Save

Click **Save configuration**. The restriction takes effect for content rendered
through that text format. Repeat for every format that accepts untrusted input; you do
**not** need to enable it on trusted, administrator-only formats.
