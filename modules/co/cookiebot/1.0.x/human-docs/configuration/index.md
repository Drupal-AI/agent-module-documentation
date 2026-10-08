# Configuration

All of Cookiebot's settings live on one form at **Configuration → Cookiebot**
(`/admin/config/cookiebot`), reached with the **Administer cookiebot settings**
permission. The module does nothing until you enter a CBID.

## The required setting: your CBID

**Cookiebot Domain Group ID (CBID)** — the UUID from your Cookiebot Manager
account. This is injected as the `data-cbid` on the consent script. It is
**required**: with it empty, the module stays completely inert and no script is
added. The form validates that the value is a properly-formatted lowercase UUID and
trims surrounding whitespace, so paste it exactly as Cookiebot gives it to you.

## Consent behaviour

- **Enable auto cookie blocking** *(on by default)* — adds Cookiebot's automatic
  blocking mode, so cookies are blocked until the visitor consents. This is the
  usual GDPR-friendly choice.
- **Enable IAB framework** *(off by default)* — turns on the IAB Transparency &
  Consent Framework, for advertising/vendor consent signalling.
- **Use Drupal's language for the banner** *(off by default)* — sends the current
  Drupal interface language to Cookiebot as the banner's culture. Leave off to let
  Cookiebot auto-detect from the browser.
- **Disable async loading** *(off by default)* — omits the `async` attribute on the
  script tag. Turn this on only if you're working around a specific loading issue
  (for example certain Safari content-blocker behaviour).

## Where the banner loads (and where it doesn't)

- **Exclude paths** — a list of path patterns (one per line) where Cookiebot should
  **not** load. Supports the `*` wildcard and the `<front>` token.
- **Exclude admin theme** *(off by default)* — skip injecting the script on admin
  pages, so editors aren't shown the banner while working.
- **Disabled for roles** — select user roles for which Cookiebot should not load at
  all.

## The cookie declaration

Cookiebot can generate a table of all the cookies your site sets. You can surface
it two ways:

- **Show cookie declaration** — turn this on and choose a **node** whose page will
  display the full declaration (typically your "Cookie policy" page).
- **Cookie declaration block** — alternatively, place the **Cookie declaration
  block** in any region from **Structure → Block layout** to show the declaration
  table wherever you like. (The block renders nothing until a CBID is set.)

## Marketing placeholder

When Cookiebot blocks a marketing element (such as an embedded iframe) before
consent, you can show a message in its place. Turn on the **placeholder** option and
edit the placeholder message. The message supports dynamic tokens, including a
"renew consent" link that reopens the consent dialog. (A menu link to
`/cookiebot-renew` is also given a class so it reopens the dialog when clicked.)

## Save

Click **Save configuration**. Saving invalidates the relevant cache tags so the
change to the injected script takes effect on the next page load.

## Setting values by script

Most settings are simple config values you can also set with Drush, for example:

```bash
drush cset cookiebot.settings cookiebot_cbid "12345678-1234-1234-1234-123456789012" -y
drush cset cookiebot.settings cookiebot_block_cookies 1 -y
```

The full list of setting keys and their defaults is in the [agent configuration
doc](../agent/configure/settings.md).
