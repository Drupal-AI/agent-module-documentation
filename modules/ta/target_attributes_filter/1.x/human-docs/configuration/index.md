# Configuration

Target Attributes Filter is configured as a filter on a text format — there is no
separate settings page. You enable it on whichever formats should get the
behavior, then set its options.

## Enable the filter on a text format

1. Log in as a user with permission to administer filters (an administrator by
   default).
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
3. Click **Configure** next to the text format you want to change (for example
   *Basic HTML* or *Full HTML*).
4. In the **Enabled filters** list, tick **Add target attribute to links**.
5. Scroll down to the **Filter settings** section, where a settings group for this
   filter appears.

## Filter settings

Review these options under the filter's settings:

- **Target attribute value** — the value written onto matched links. The default
  is `_blank` (open in a new tab); `_self` keeps links in the same tab. This value
  is set here by the administrator and applied to every matched link, so authors
  do not choose it per link.
- **Which links to affect** — choose whether the target is added to **all** links
  or only **external** links. Limiting it to external links is the usual choice
  when the goal is "external links open in a new tab, internal links stay in the
  same tab."
- **Replace existing targets** — whether the filter overrides a `target` already
  present on a link, or leaves existing targets alone.

## A note on link order

Filters run in the order shown on the format's configuration page. If you use this
alongside other link-related filters, check the order under **Filter processing
order** so the target is applied as you expect.

## Save

Click **Save configuration**. The change takes effect immediately — content
rendered with that text format now carries the target you configured.

## Tabnabbing reminder

If you set the value to `_blank` and need to support older browsers, remember that
`target="_blank"` should be paired with `rel="noopener"` to prevent the opened
page from reaching your page through `window.opener`. Modern browsers apply this
implicitly (since around 2021), so most sites need no extra action, but it is
worth knowing if your audience includes older browsers.
