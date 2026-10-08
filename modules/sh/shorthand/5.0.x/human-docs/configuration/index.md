# Configuration

Setting Shorthand up has three parts: enter your API token, download the stories
you want, then add a field to display a story on an entity.

## 1. Enter your API token

1. Log in as a user with the **Administer shorthand** permission.
2. Go to **Configuration → Web services → Shorthand**
   (`/admin/config/services/shorthand`).
3. Paste your Shorthand **API token** into the single field and click **Save**.

When you save, the module validates the token against Shorthand's `token-info`
endpoint. If the token is wrong or rejected, the form refuses to save and shows an
error — so a successful save confirms your token works. The token is stored in the
`shorthand.settings` config object (key `shorthand_token`).

> **Keeping the token out of exported config.** The token is ordinary Drupal
> config, so it will appear in a configuration export. If you would rather keep it
> out of version control, set it per environment with a `settings.php` config
> override that reads an environment variable, for example
> `$config['shorthand.settings']['shorthand_token'] = getenv('SHORTHAND_API_TOKEN');`,
> and store the value in your environment (with DDEV, `ddev dotenv set`).

## 2. Download stories

1. Go to **Content → Shorthand** (`/admin/content/shorthand`). This page lists all
   the stories in your Shorthand account with their cover image, status, dates, and
   a link to the live story.
2. Click **Download** next to a story. A batch runs that fetches the story's `.zip`
   and extracts it into your site's public files at
   `public://shorthand/stories/<story-id>/<version>/`.
3. When Shorthand shows a newer version of a story you already have, the list shows
   an **Update story** action; re-downloading fetches the newer version alongside
   the old one.

> **Access note.** In this release the remote-list route requires an
> `access shorthand story overview` permission that the module never actually
> defines, so — until that is fixed or the route requirement is adjusted — the list
> page is reachable only by user 1 (the superuser). The two permissions the module
> *does* define are **Administer shorthand** (for the settings form) and
> **Download shorthand content** (to download stories).

## 3. Add a Shorthand field to display a story

1. Make sure a text format capable of rendering full HTML exists (Shorthand
   stories contain rich markup and scripts).
2. On the entity you want to render the story on — a content type, a taxonomy
   vocabulary, a user, etc. — add a new field of type **Shorthand select**
   (`shorthand_local`, listed under *Reference*).
3. On **Manage form display**, the field's **widget** is a dropdown of the
   story/version folders you have downloaded, each labelled with its story title.
   Pick the story you want.
4. On **Manage display**, the field's **formatter** reads the extracted
   `article.html` and `head.html`, rewrites the story's relative asset URLs to your
   site's public-file URLs, drops the story's own `<title>`, and outputs the
   markup. If `article.html` is missing, the item is simply skipped.

For a clean, full-bleed story page, hide the entity's label and other fields on the
display (and, if you like, use a dedicated page template or Layout Builder for that
bundle) so the story fills the page.

## 4. Metatag integration (optional)

If the [Metatag](https://www.drupal.org/project/metatag) module is enabled,
Shorthand reads the downloaded story's `head.html` and copies its `<meta>` tags
onto the host entity (skipping any you have already set, and the `generator` tag),
rewriting `og:image` / `twitter:image` to your locally served asset URLs. This
means a story you download can populate the host page's SEO and social-share tags
automatically.

## Housekeeping: clean up old downloads

As you re-download updated stories, old version folders pile up in
`public://shorthand/stories/`. The Drush command removes versions and stories no
longer referenced by any published story node:

```bash
drush shorthand:clean-up   # alias: drush shcu
```

It asks for confirmation, then deletes story folders (and stale version
subfolders) that are not in use. **Before running it**, confirm which bundle and
field hold your Shorthand references — the command is hardcoded to look for a
`field_shorthand` field on `shorthand_story` nodes, so custom setups (including the
example submodule's `field_shorthand_story`) may look "unused" to it.
