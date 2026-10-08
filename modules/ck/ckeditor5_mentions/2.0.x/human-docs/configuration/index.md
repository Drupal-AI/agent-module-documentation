# Configuration

Setting up mentions is a two-part job: first you create one or more **Mention
Feeds** (what suggestions appear and which marker triggers them), then you enable
those feeds on the CKEditor 5 text formats where you want mentions to work.

## Step 1 — Create a Mention Feed

1. Log in as a user with permission to administer the module's configuration.
2. Go to **Configuration → Content authoring → Mention Feeds**
   (`/admin/config/content/mention-feed`).
3. Add a new Mention Feed and configure:
   - **Marker** — the character that triggers the autocomplete panel, for example
     `@` for people or `#` for topics.
   - **Feed source** — where suggestions come from. A feed can be backed by a
     **static list** of items (good for a small, fixed set of names) or by an
     **entity type** (for example users or taxonomy terms), so suggestions are
     drawn from your site's data.
   - Any additional options the feed offers for how items are matched and
     displayed.
4. Save the feed.

You can create several feeds — for instance one `@` feed for users and one `#`
feed for taxonomy terms.

> **Privacy caveat:** a feed backed by users will reveal usernames to anyone who
> can use the editor it's enabled on. That's usually fine for trusted internal
> editors, but scope the feed (and the text formats you enable it on) with that
> exposure in mind.

## Step 2 — Enable the feed on a text format

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Click **Configure** next to a format that uses CKEditor 5.
3. In the CKEditor 5 settings, open the **Mentions** configuration and enable the
   feed(s) you want available in that editor.
4. Click **Save configuration**.

## Permissions

The module provides its own permissions. Review them at **People → Permissions**
(`/admin/people/permissions`) and grant them to the roles that should be able to
manage feeds and use mentions.

## Try it

Edit content with a format that has a feed enabled, type the feed's marker (such
as `@`), and confirm the autocomplete panel appears. Selecting a suggestion
inserts the mention into your content.
