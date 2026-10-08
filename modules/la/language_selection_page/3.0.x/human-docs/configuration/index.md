# Configuration

Language Selection Page is configured as part of Drupal's **language detection**
chain, not on a separate settings screen. There are two jobs: enable the
"Selection Page" method and place it correctly in the order, then tune the
method's own options.

## Open the detection settings

1. Log in as a user with the **Administer languages** permission (an administrator
   by default).
2. Go to **Configuration → Regional and language → Languages → Detection and
   selection**, or navigate directly to
   `/admin/config/regional/language/detection`.

## Enable and — critically — position the method

On the detection page you will see a list of methods (URL, Session, User, Browser,
Selected language, and now **Selection Page**), each with an **Enabled** checkbox
and a drag handle for ordering.

- Tick **Enabled** next to **Selection Page**.
- Drag it **near the bottom** of the list, *below* the URL and User (account)
  methods. The whole point is that it runs only as a fallback — after the reliable
  methods have failed to decide. Putting it too high means visitors who already
  have a clear language preference are still shown the chooser, which hurts more
  than it helps.
- It is strongly recommended to have another method active above it, such as
  **URL** or a cookie‑based method (the contrib *Language cookie* module), so
  returning visitors are not sent to the selection page too often.

Click **Save settings**.

## Configure the Selection Page method

The Selection Page method has its own options form (reached from a "Configure"
link beside the method, or the gear/settings control next to it). The key
settings are:

### How the page is rendered

You can choose how the selection markup is delivered:

- **Inject into the page content** — the module places the language‑choice HTML
  into the `$content` of an otherwise normal page, so it inherits your theme's
  layout.
- **Use the module's own template** — the module renders a dedicated page you can
  fully customise through Drupal's theming system. Copy the template into your
  theme and edit it; the `$language_selection_page` variable gives you everything
  you need to lay out the links.

Choose injection if you want the chooser to sit inside your normal page shell,
and the dedicated template if you want a clean, standalone splash page.

### Blacklisted paths

Provide a list of **paths where the module must not run**. This is where you keep
the selection page away from places it would do harm — API endpoints, admin
paths, and anything a search engine or automated client hits. Add one path per
line.

### Language prefixes

For the selection page to work properly, make sure **every enabled language has a
URL prefix** set (under **Languages → Detection and selection → URL language
detection configuration**, or the language edit form). Without prefixes the module
cannot build correct links to each language's version of the page.

## Save

Save the method's options, then save the detection settings. Test as a fresh
visitor (a private/incognito window with no existing language cookie) to confirm
the chooser appears — and that once you pick a language, you land on the correct
prefixed URL for your original destination.

## A note on SEO

Because a crawler that reaches the selection page will index *it* rather than your
content, keep the page out of your XML sitemap and ensure your language‑prefixed
pages remain reachable directly. Related modules worth pairing: **Global
Redirect** (redirects un‑prefixed URLs to the correct prefixed one) and **Language
cookie** (remembers a returning visitor's choice so they skip the chooser).
