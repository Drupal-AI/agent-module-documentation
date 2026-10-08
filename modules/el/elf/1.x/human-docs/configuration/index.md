# Configuration

There are two parts to setting up External Links Filter: adjusting the module's
own settings, and turning the filter on for the text formats where you want it to
apply. The filter only affects content whose text format has it enabled.

## Module settings

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Content authoring → External Links Filter**, or
   navigate directly to `/admin/config/content/elf`.

Here you control how the filter behaves — for example whether external and mailto
links get their marking class, whether a `rel="nofollow"` attribute is added, and
whether external clicks are routed through the signed redirect page. Adjust the
options to suit your site and save.

### About the optional signed redirect

If you enable the redirect option, external clicks pass through the module's
redirect route on their way off‑site. This route is protected: it only follows a
target URL when the request carries a valid HMAC signature that the site
generated for that exact URL, so it cannot be tricked into redirecting to an
arbitrary destination. You do not need to manage any keys for this by hand — it
uses the site's private key.

## Enable the filter on a text format

The filter only runs on content whose text format has it switched on:

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Click **Configure** next to the text format you use for content (for example
   *Basic HTML* or *Full HTML*).
3. Under **Enabled filters**, tick the External Links Filter.
4. If the format lists a **filter processing order**, check that the filter sits
   sensibly relative to the others, then **Save configuration**.

## Verify

Edit a piece of content that uses the format you just configured, include an
external link, and view the rendered page — the external link should now carry the
module's class (and, if enabled, the `nofollow` attribute and/or the redirect
behaviour).
