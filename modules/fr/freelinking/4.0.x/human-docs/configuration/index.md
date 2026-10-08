# Configuration

Freelinking is configured per **text format** — there's no separate settings page.
You enable its filter on the formats where editors should be able to write
`[[indicator:target]]` links, then choose which plugins apply and how strict the
filter is.

## Enable the filter on a text format

1. Log in as a user with the **Administer filters** permission (an administrator by
   default).
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
3. Click **Configure** next to the format your editors use.
4. In the **Enabled filters** list, tick **Freelinking** to turn it on for this
   format.

## Choose which plugins are active

With the filter enabled, its settings appear lower on the same form. Here you decide
which **indicator plugins** are active for this format — for example you might allow
`nodetitle`, `node`, `user`, and `path` but disable `google` or the external‑URL
plugin. Enable only the indicators your editors actually need.

## Set the default plugin

Choose the **default plugin** — the one used when an editor writes `[[target]]` with
no indicator prefix. Picking a sensible default (often node‑by‑title) makes the
common case effortless.

## Handle unknown indicators

The **Ignore Unknown Plugin Indicators** option controls what happens when the filter
meets an indicator it doesn't recognise (or one that's disabled):

- Leave it so unknown indicators **fall back to the default plugin**, or
- have them render a themeable **error** so editors notice and fix the typo.

Choose based on whether you'd rather quietly degrade or surface mistakes.

## The External plugin and "scrape"

The **External** plugin (for `[[https://…]]` links) has a **Scrape external URLs**
option that is **on by default**. When it's on and no link text is supplied, the
server fetches the linked URL to read the page's heading for a title. Set **Scrape
external URLs → No** on a format if you don't want that lookup.

Also, when you use the External plugin, **disable core's "Convert URLs into links"**
filter on the same format so the two don't conflict.

## A note on the User plugin

The **User** plugin resolves `[[user:…]]` links, and it gates the disclosure of email
addresses and user information on Drupal's permissions — so it won't leak details to
viewers who aren't allowed to see them.

## Save

Click **Save configuration** at the bottom of the format's form. Freelinking markup
in content saved through that format is now converted to links according to your
choices. Repeat for any other format that should support Freelinking.
