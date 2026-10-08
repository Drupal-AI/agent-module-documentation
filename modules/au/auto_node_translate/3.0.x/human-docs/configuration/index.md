# Configuration

There are two settings forms and a set of permissions to set up, then the Auto
Translate operation is ready to use on your content.

## 1. Main settings

1. Log in as a user with the **Configure Auto Node Translate** permission.
2. Go to **Configuration → Regional and language → Auto Node Translate settings**
   (`/admin/config/regional/auto-node-translate-settings`).

Fields:

- **Translation provider** (`default_api`) — a dropdown of the available
  translation‑provider plugins. The built‑in **MyMemory** provider is selected by
  default; if you've installed another provider plugin, choose it here.
- **Moderation state** (`moderation_state`) — *only shown when Content Moderation
  is installed.* Choose what state new translations get: keep the **source node's
  state**, force **Draft** (so translations wait for editorial review), or force
  **Published**.

Click **Save configuration**.

## 2. MyMemory settings (optional)

If you're using the built‑in MyMemory provider, you can optionally register an
email to raise its free word quota.

1. Go to **Configuration → Regional and language → My Memory**
   (`/admin/config/regional/my-memory`).
2. **Email** (`mm_email`) — enter an email address. MyMemory uses it to lift the
   free daily quota (roughly from ~1,000 to ~10,000 words per day). This is
   optional and purely additive — the MyMemory API endpoint itself is fixed and
   not configurable.
3. Save.

## 3. Grant permissions

Auto Node Translate uses two kinds of permission (assign them at **People →
Permissions**, `/admin/people/permissions`):

- **Configure Auto Node Translate** — a *restricted* permission that gates both
  settings forms above. Grant it only to trusted administrators.
- **Auto translate [type]** — one permission per translatable content type (for
  example *Auto translate Article*). A user needs the matching one to run Auto
  Translate on that content type.

Note that running Auto Translate *also* requires the user to hold a core
content‑translation permission (such as **Create content translations**) and to be
able to edit the content — so grant those alongside the auto‑translate permission.

## 4. Run a translation

1. As a user with the right permissions, edit or view a translatable node.
2. Open its **Translate** tab (or use **Auto Translate** in the content list's
   operations).
3. Click **Auto Translate**. On the form, tick the target languages you want to
   generate.
4. Submit. The module translates the node's text, link, and paragraph fields into
   each chosen language and saves the translations (recording an
   "Automatic translation" revision). Re‑running it later updates an existing
   translation after the source changes.

> **Tip:** Machine translations are a starting point. A common workflow is to set
> the moderation state to **Draft** so a human can review and refine each
> translation before it goes live.

## Setting values without the UI

The settings can be set with Drush:

```bash
drush cset auto_node_translate.settings default_api auto_node_translate_mymemory -y
drush cset auto_node_translate.settings moderation_state draft -y
drush cset auto_node_translate.my_memory_settings mm_email you@example.com -y
```
