# Configuration

Simple oEmbed is configured entirely through Drupal's text-format system — there
is no separate settings page. You turn the filter on for the formats where you
want pasted links to become embeds, and you decide which providers are allowed.

## Enable the filter on a text format

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Choose the text format your content uses (for example *Basic HTML* or *Full
   HTML*) and click **Configure**.
3. In the **Enabled filters** list, tick the Simple oEmbed filter.
4. Save the format.

Content written in that format will now have bare, supported URLs replaced with
embed markup at render time — including older content and content that came in
through an API.

## Mind the filter order

Filters run in the order shown under **Filter processing order** on the same form.
Because Simple oEmbed rewrites URLs into embed markup, its position relative to
markup-restricting filters (such as *Limit allowed HTML tags*) matters — if a
restricting filter strips the embed markup after oEmbed adds it, the embed will
not appear. Place the oEmbed filter so its output survives the rest of the
pipeline, and test with a real link.

## Restrict which providers are allowed

This is the most important configuration decision. An oEmbed filter delegates
rendering to whatever domain an author pastes, so limit it to the providers you
actually trust rather than leaving it open to any domain. Configure the permitted
providers as the filter allows, and keep the list as small as your editors need.

## Privacy and availability

- **Consent.** Embeds run a third party's markup and usually their JavaScript in
  the visitor's browser. On a site with a cookie-consent manager, the embeds
  should be gated behind consent — treat oEmbed output the same way you would any
  third-party embed.
- **Availability.** oEmbed needs the provider reachable when the page renders. If
  a provider is down, or your environment restricts outbound network access, the
  embed will not render — worth keeping in mind for locked-down or offline
  environments.
