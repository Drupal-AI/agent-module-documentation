# Configuration

Setting up CKEditor 5 DeepL has three parts: store your DeepL API key, add and
configure the DeepL button on each text format, and (optionally) place the DeepL
translation block. Each CKEditor 5 text format is configured separately.

## 1. Store your DeepL API key securely

Your DeepL API key is a secret. Do **not** paste it into code or commit it to
version control — store it as a **Key** entity backed by an environment variable.

### DDEV: put the key in an environment variable first

If you are running under DDEV, save the value into the container's environment with
DDEV's dotenv command (this writes to `.ddev/.env`, which you must keep out of
version control), then restart so DDEV loads it:

```bash
ddev dotenv set .ddev/.env --deepl-api-key=YOUR_DEEPL_KEY
ddev restart
```

The flag `--deepl-api-key` becomes the environment variable `DEEPL_API_KEY` inside
the web container. You can confirm it is present without printing its value:

```bash
ddev exec 'test -n "$DEEPL_API_KEY"'   # exit status 0 means it is set
```

### Create the Key entity

1. Go to **Administration → Configuration → System → Keys**
   (`/admin/config/system/keys`).
2. Click **Add key**.
3. Give it a label, and choose the key type **DeepL API Key** (provided by this
   module).
4. For the key provider, choose the **Environment** provider and point it at the
   `DEEPL_API_KEY` variable (rather than typing the key into the database). If you
   are not using an environment variable, you can use the configuration/manual
   provider, but the environment approach keeps the secret out of your config.
5. Save the key.

## 2. Add and configure the DeepL button on a text format

1. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`).
2. Click **Configure** next to a text format whose editor is CKEditor 5.
3. In the CKEditor 5 toolbar configuration, drag the **DeepL** button up into the
   active toolbar.
4. Open the DeepL plugin's settings (they appear below the toolbar once the button
   is active) and configure the button — this is where you point it at the DeepL
   API key you created and set its translation options. The options available in
   the editor dialog depend on whether your key is a Free or Pro key.
5. Click **Save configuration**.

Repeat for any other CKEditor 5 formats that should offer DeepL translation.

## 3. Optional: place the DeepL translation block

The module provides a **DeepL translation block** you can place in any region of
your admin theme so a translator is available on every admin page:

1. Go to **Administration → Structure → Block layout**
   (`/admin/structure/block`).
2. In the region you want, click **Place block** and choose the DeepL translation
   block.
3. Configure its visibility and save.

## 4. Optional: view usage statistics

The module can display DeepL API usage statistics for each key, as reported by
DeepL, so you can keep track of how much of your quota you have consumed.

## Permissions and cost

This module defines its own permission(s) — review them at **People → Permissions**
(`/admin/people/permissions`) and grant DeepL translation to the roles that should
use it. Remember that every translation sends the selected text to DeepL's external
API and counts against your DeepL quota (and billing on a Pro plan), so grant
access deliberately.
