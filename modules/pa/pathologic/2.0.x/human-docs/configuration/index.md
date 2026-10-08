# Configuration

Configuring Pathologic is two steps: enable the filter on the text formats that
need it, then set the options — either globally or per format.

## Step 1 — Enable the filter on a text format

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit a format (for example *Full HTML*).
2. Under **Enabled filters**, tick **"Correct URLs with Pathologic"**.
3. In the **Filter processing order** list, drag Pathologic to the **bottom** so it
   runs **last**. This matters: Pathologic rewrites finished markup, so it must run
   after every other filter has produced its output. The filter ships with a heavy
   weight to nudge it into last place, but always confirm it.
4. Save the format.

Each format where you enable the filter also gets one choice — **Settings source**:

- **Use global Pathologic settings** *(default)* — this format uses the shared
  settings from the global form (Step 2).
- **Use custom settings for this text format** — this format gets its own copy of the
  same options, edited right there on the format's filter settings, independent of
  the global values.

## Step 2 — Global settings

For the shared settings used by every format set to "global":

1. Log in as a user with the **Administer filters** permission.
2. Go to **Configuration → Content authoring → Pathologic**
   (`/admin/config/content/pathologic`).

The options are:

- **Protocol style** — how rewritten URLs are output. Choose one:
  - **Full URLs** *(default)* — `http://example.com/foo/bar`. Best for stopping
    broken links and images in syndicated content such as RSS feeds, but can cause
    problems on sites reachable over both HTTP and HTTPS.
  - **Protocol-relative URLs** — `//example.com/foo/bar`. Avoids HTTP/HTTPS mixing;
    some older feed readers don't understand this form.
  - **Paths relative to server root** — `/foo/bar`. The safest choice for sites served
    over both HTTP and HTTPS, but because it has no host, it does **not** fix links in
    syndicated content.
- **All base paths for this site** — a textarea where you list, one per line, every
  base path or URL the site is or has ever been served at (for example a staging URL
  like `http://dev.example.org/staging/`). Links that were authored against any of
  these are recognized and corrected. This is the key to fixing content after a site
  move.
- **Keep language prefix** — only shown when the core **Language** module is enabled.
  When on, language prefixes such as `/fr` are kept in rewritten URLs; uncheck it to
  strip them.

Click **Save configuration**. Because these are stored as a config object, you can
export and deploy them between environments.

There is one additional setting, **allowed URL schemes** (`scheme_allow_list`),
which controls which URL schemes Pathologic processes (by default `http`, `https`,
plus `files` and `internal` for legacy Path Filter compatibility). It has **no form
field** — adjust it only via configuration or Drush if you need to.

> Remember: the global settings only affect formats whose filter is set to "Use
> global Pathologic settings." Formats using their own per-format settings ignore
> them.
